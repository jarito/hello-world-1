global class UpdateOrderBatch implements Database.Batchable<sObject>, Database.Stateful{
    
    global Set<ID> setOrderIds = new Set<ID>();
    Public String query; 
    Public Id recordId;
    Public String customStatus = 'Shipped';
    Public String stdStatus = 'Activated';
    
    public UpdateOrderBatch(){
        System.debug('In Constructor ....');
        System.debug(' ** '+customStatus+' .... '+stdStatus);
        this.query = 'Select Id From Order Where (No_of_Contracts__c = 0 OR No_of_Contracts__c = null) AND Count_of_Order_Products__c > 0 AND Batch_logic_applied__c = false AND Order_Status__c =: customStatus AND Status =: stdStatus';
    }
    
    public UpdateOrderBatch(ID detailPageId) {
        recordId = detailPageId;
        if(!String.isBlank(recordId)) {
            System.debug(' ** '+customStatus+' .... '+stdStatus);
            System.debug('Batch is invoked from Detail Page button');
            this.query = 'Select Id From Order Where Id = :recordId AND (No_of_Contracts__c = 0 OR No_of_Contracts__c = null) AND Count_of_Order_Products__c > 0 AND Batch_logic_applied__c = false AND Order_Status__c =: customStatus AND Status =: stdStatus';
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('Query >>> '+query);
        return Database.getQueryLocator(this.query);
    } 

    global void execute(Database.BatchableContext bc , List<Order> lstOrdersInitial){ 
        List<Order> listOrders = [  SELECT 
                                          Id
                                        , SBQQ__Contracted__c
                                        , No_of_Contracts__c
                                        , Owner.Email
                                        , (Select Id, SBQQ__Contracted__c FROM OrderItems)
                                        , (Select Id From SBQQ__Contracts__r)
                                    FROM Order
                                    WHERE Id IN : lstOrdersInitial];
        System.debug('Main List size >>>>> '+listOrders.size());

        List<Order> lstOrdersContractedTrue = new List<Order>();
        List<Order> lstOrdersContractedFalse = new List<Order>();
        if(!listOrders.isEmpty()) {
            for(Order objOrder : listOrders) {
                setOrderIds.add(objOrder.Id);
                if(objOrder.SBQQ__Contracted__c == true) {
                    lstOrdersContractedTrue.add(objOrder);
                }
                else {
                    lstOrdersContractedFalse.add(objOrder);
                }
            }
        }
        System.debug('Size >> lstOrdersContractedTrue >>> '+lstOrdersContractedTrue.size());
        
        List<Order> lstOrdersToBeUpdatedUncheckContracted = new List<Order>();
        List<Order> lstOrdersToBeUpdatedCheckContracted = new List<Order>();
        List<OrderItem> lstOrderProductsToBeUpdated = new List<OrderItem>();

        //Uncheck the SBQQ__Contracted__c checkbox which was previously checked 
        if(!lstOrdersContractedTrue.isEmpty()) {
            for(Order objOrderFirstUpdate : lstOrdersContractedTrue) {
                if(objOrderFirstUpdate.SBQQ__Contracts__r.isEmpty()) { 
                    objOrderFirstUpdate.SBQQ__Contracted__c = false;
                    lstOrdersToBeUpdatedUncheckContracted.add(objOrderFirstUpdate);
                    //mapOfOrderIDAndOrderOwnerEmailAddress.put(objOrderFirstUpdate.Id, objOrderFirstUpdate.Owner.Email);
                    for(OrderItem objOrderProduct : objOrderFirstUpdate.orderItems) {
                        if(objOrderProduct.SBQQ__Contracted__c == true) {
                            objOrderProduct.SBQQ__Contracted__c = false;
                            lstOrderProductsToBeUpdated.add(objOrderProduct);
                        }
                    }
                }
            }
        }

        if(!lstOrderProductsToBeUpdated.isEmpty()) {
            Database.SaveResult[] srOrderProductList = Database.update(lstOrderProductsToBeUpdated, false);
        }
        //Perform First Update DML
        Set<ID> erroneousOrderIds = new Set<ID>();
        if(!lstOrdersToBeUpdatedUncheckContracted.isEmpty()) {
            Database.SaveResult[] srList = Database.update(lstOrdersToBeUpdatedUncheckContracted, false);
            // Iterate through each returned result
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully updated Order ID: ' + sr.getId());
                    //flag = true;
                }
                else {
                    erroneousOrderIds.add(sr.getId());
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Order fields that affected this error: ' + err.getFields());
                    }
                }
            }
        }

        if(!lstOrdersContractedFalse.isEmpty()) {
            System.debug('Size >> lstOrdersContractedFalse >>> '+lstOrdersContractedFalse.size());
            lstOrdersToBeUpdatedUncheckContracted.addAll(lstOrdersContractedFalse);
        }

        //Check the SBQQ__Contracted__c checkbox which was unchecked through this Batch
        System.debug('Error List Size >>> '+erroneousOrderIds.size());
        if(!lstOrdersToBeUpdatedUncheckContracted.isEmpty() && erroneousOrderIds.size() < 1) {
            for(Order objOrderSecondUpdate : lstOrdersToBeUpdatedUncheckContracted) {
                objOrderSecondUpdate.SBQQ__Contracted__c = true;
                objOrderSecondUpdate.Batch_logic_applied__c = true;
                lstOrdersToBeUpdatedCheckContracted.add(objOrderSecondUpdate);
            }
        }

        if(!lstOrdersToBeUpdatedCheckContracted.isEmpty()) {
            System.debug('Size >> lstOrdersToBeUpdatedCheckContracted >>> '+lstOrdersToBeUpdatedCheckContracted.size());
        }

        //Perform Second Update DML
        if(!lstOrdersToBeUpdatedCheckContracted.isEmpty()) {
            System.debug('Size of Final List to be updated >>>>> '+lstOrdersToBeUpdatedCheckContracted.size());
            Database.SaveResult[] srList = Database.update(lstOrdersToBeUpdatedCheckContracted, false);
        }
    }  
 
    global void finish(Database.BatchableContext bc){ 
        if(!setOrderIds.isEmpty()) {
            //Call Batch class with delay of 1 hour (Current Time + 1 Hour)
            //VerifyContractGeneratedBatch objSchedClass = new VerifyContractGeneratedBatch(setOrderIds);
            //String batch2JobId = System.scheduleBatch(objSchedClass, 'Batch 2', 60);
        }
    }     
}
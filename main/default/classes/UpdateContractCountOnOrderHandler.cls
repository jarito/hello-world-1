public class UpdateContractCountOnOrderHandler {
    public void updateContractCount(List<Contract> lstContract) {
        Set<Id> setOrderIds = new Set<Id>();
        List<Order> orderListToUpdate = new List<Order>();
        if(!lstContract.isEmpty()) { 
            for(Contract objContract : lstContract) {
                System.debug('Filling Set of IDs');
                setOrderIds.add(objContract.SBQQ__Order__c); 
            }    
        }
        System.debug('setOrderIds >>> '+setOrderIds);
        
        if(!setOrderIds.isEmpty()) {
            List<Order> lstOrders = [ SELECT 
                                            Id,
                                            No_of_Contracts__c,
                                            (SELECT 
                                                Id
                                             FROM SBQQ__Contracts__r)
                                     FROM Order
                                     WHERE Id IN : setOrderIds ];

            System.debug('lstOrders >>>> '+lstOrders);
            if(!lstOrders.isEmpty()) {
                for(Order objOrder : lstOrders) {
                    System.debug('objOrder.SBQQ__Contracts__r.size() >>>> '+objOrder.SBQQ__Contracts__r.size());
                    objOrder.No_of_Contracts__c = objOrder.SBQQ__Contracts__r.size(); 
                    orderListToUpdate.add(objOrder);       
                }
            }    
        }
        if(!orderListToUpdate.isEmpty()) {
            Database.SaveResult[] srList = Database.update(orderListToUpdate, false);
            // Iterate through each returned result
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully updated Order ID: ' + sr.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Order fields that affected this error: ' + err.getFields());
                    }
                }
            }
        }
    }
}
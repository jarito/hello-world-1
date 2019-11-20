global class VerifyContractGeneratedSchedulable Implements Database.Batchable<sObject>, Database.Stateful{
    global Set<ID> setOrderIdsFromBatch;
    global List<Order> lstOrders = new List<Order>();
    global VerifyContractGeneratedSchedulable (Set<ID> setOrderIds) {
        System.debug('In Batch 2 >>>> Parameterized Constructor');
        setOrderIdsFromBatch = setOrderIds;
    }

    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'Select Id From Order Where Id IN : setOrderIdsFromBatch AND SBQQ__Contracted__c = true AND No_of_Contracts__c = 0 AND Batch_logic_applied__c = true';
        System.debug('Query >>> '+query);
        return Database.getQueryLocator(query);
    } 

    global void execute(Database.BatchableContext bc , List<Order> lstOrdersInitial){ 
        System.debug('setOrderIds in Schedulable Class size>>>> '+setOrderIdsFromBatch.size());
        lstOrders = [SELECT 
                          Id
                        , OrderNumber
                        , Batch_logic_applied__c
                        , No_of_Contracts__c
                        , Owner.Email
                        FROM Order 
                        WHERE Id IN : lstOrdersInitial];

        if(!lstOrders.isEmpty()) {
            System.debug('Check Order List >>> lstOrders >>>> '+lstOrders);
        }
    }

    global void finish(Database.BatchableContext bc){ 
        if(!lstOrders.isEmpty()) {
            String emailBodyString = ''; 
            for(Order objOrder : lstOrders) {
                if(!String.isEmpty(objOrder.OrderNumber)) {
                    emailBodyString += objOrder.OrderNumber + ', ';
                }
            } 
            emailBodyString = emailBodyString.removeEnd(' ');
            emailBodyString = emailBodyString.removeEnd(',');         
            String finalEmailBody = '';
            if(lstOrders.size() == 1) {
                finalEmailBody = 'Contract for the Order '+emailBodyString+ ' has not been generated.';
            }
            else if(lstOrders.size() > 1) {
                finalEmailBody = 'Contract for the respective Orders '+emailBodyString+ ' are not generated.';
            }            
            System.debug('finalEmailBody >>>> '+finalEmailBody);

            List<Messaging.SingleEmailMessage> sendEMailList = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage objectEmail = new Messaging.SingleEmailMessage();
            List<String> toAdd = new List<String>();
            //String ownerEmailId = 'shreejita7@gmail.com';
            //toAdd.add(ownerEmailId);
            toAdd.add('shruti.kulkarni@eternussolutions.com');
            system.debug('toAdd >>>> '+toAdd);
            objectEmail.setplaintextbody(finalEmailBody);
            objectEmail.setToAddresses(toAdd);
            sendEMailList.add(objectEmail);
            system.debug('List of Emails'+sendEMailList);
            if(!sendEMailList.isEmpty()){
                //List of all Emails
                List<Messaging.SendEmailResult>  result = Messaging.sendEmail(sendEMailList); 
                system.debug('----sendEMailList--'+sendEMailList);
                for(Messaging.SendEmailResult objResult : result) {   
                    Messaging.SendEmailError[] errorList =  objResult.getErrors();       
                    System.debug('errorList >>> '+errorList);  
                }     
            }                
        }
    }     
}
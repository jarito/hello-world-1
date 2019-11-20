public class VerifyAddressHandler {
    public void VerifyAddressmethod(List< EFT_Transaction_Status__c > listOfNewETF , Map<ID,EFT_Transaction_Status__c> mapOfEFT ){
        /* ++++    
        List<EFT_Transaction_Status__c > listEFT = new List< EFT_Transaction_Status__c >();
        List<ID> listID = new List<ID>();
        */
        
        /* List of IDs of all input records */
        /* ++++
        for(EFT_Transaction_Status__c EFTobject : listOfNewETF ){
            listID.add(EFTobject.Id );
        }
        */
        List<EFT_Transaction_Status__c > listEFT = new List< EFT_Transaction_Status__c >();
        /* List of all related fields from the records who ID is present in 
        the list ListID above which belongs to Custom Object EFT_Transaction_Status__c */
        listEFT = [ Select 
                        ID,
                        Name,   
                        Transaction_Status__c, 
                        Transaction_Date__c  , 
                        Method_Name__c,
                        SalesHeaderStatus__c,
                        SalesHeaderStatus__r.Bill_to_Contact__c, 
                        SalesHeaderStatus__r.Status__c,
                        SalesHeaderStatus__r.Bill_to_Customer__c, 
                        SalesHeaderStatus__r.Name, 
                        SalesHeaderStatus__r.Bill_to_Customer__r.Name
                    From  
                        EFT_Transaction_Status__c 
                    where    
                        Id IN : mapOfEFT.keySet() ];

        system.debug('----All Related Fields----'+listEFT);                

        /* Fetch the ID of Record Type */    
        //ID recordId = [Select Id, Name From RecordType Where SObjectType = 'Case'].Id;
        //Get ID of RecordType without querying
        Id devRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Assignment').getRecordTypeId();

        //QueueSObject queueIdObject = [Select Id From QueueSObject Where Queue.Name = 'AVSQueue'];
        QueueSObject queueIdObject = [Select Id, QueueId From QueueSObject Where Queue.Id = '00G6F000004kz43'];
        //system.debug('------------Queue ID-----------'+ queueIdObject);
        //Group QueueId =  [Select Id From Group Where  Type = 'Queue'  And Name =  'AVS Queue'];
        system.debug('---Trigger.New---'+ listOfNewETF);
            
        List<Case> listOfCases = new List<Case>(); 
            
        for(EFT_Transaction_Status__c EFTobject : listEFT ){
            system.debug('EFTobject.Method_Name__c == Credit Card Address' + (EFTobject.Method_Name__c == 'Credit Card Address'));
            system.debug(' EFTobject.Transaction_Status__c == Declined' + (EFTobject.Transaction_Status__c == 'Declined'));
            system.debug('EFTobject.SalesHeaderStatus__r.Status__c == Open' + (EFTobject.SalesHeaderStatus__r.Status__c == 'Open'));
            if( (EFTobject.Method_Name__c == 'Credit Card Address') && 
                ( EFTobject.Transaction_Status__c == 'Declined' ) && 
                ( EFTobject.SalesHeaderStatus__r.Status__c == 'Open' ) ){
                        
                    system.debug('---If condition is True---'+ listOfNewETF);
                    Case caseObj = new Case();
                    system.debug('-------EFTobject.SalesHeaderStatus-------'+EFTobject.SalesHeaderStatus__c);

                    system.debug('-------EFTobject.SalesHeaderStatus__r.Name--------'+EFTobject.SalesHeaderStatus__r.Name);

                    system.debug('-------EFTobject.SalesHeaderStatus__r.Bill_to_Customer__c--------'+caseObj.Account );
                    
                    caseObj.AccountID = EFTobject.SalesHeaderStatus__r.Bill_to_Customer__c ;
                        
                    caseObj.ContactID = EFTobject.SalesHeaderStatus__r.Bill_to_Contact__c ;
                    /*caseObj.RecordTypeId = recordId ; */    
                    caseObj.RecordTypeId = devRecordTypeId ;
                        
                    caseObj.Origin = 'Internal';
                        
                    //caseObj.OwnerId =   queueIdObject.Id ;
                    caseObj.OwnerId = queueIdObject.QueueId;
                        
                    caseObj.Priority = 'High';
                        
                    caseObj.Reason = 'Address Did Not Verify';
                        
                    caseObj.Type = 'Address Did Not Verify';
                        
                    caseObj.Status = 'New';
                        
                    caseObj.Subject = EFTobject.SalesHeaderStatus__r.Bill_to_Customer__r.Name + ' Address Did Not Verify ' ;
                    
                    caseObj.Open_Sales_Order__c =  EFTobject.SalesHeaderStatus__c ;
                        
                    caseObj.Sales_Order_Number__c =  EFTobject.SalesHeaderStatus__r.Name ;

                    caseObj.Order_Date__c =  EFTobject.Transaction_Date__c ;
                        
                    listOfCases.add(caseObj);
                    system.debug('---Case to be inserted---'+ listOfCases);
            }
        }

        /* Check whether the list Empty and Insert if it is not Empty */   
        if(!listOfCases.isEmpty()){
            system.debug('---Inside If Statement---'+  listOfCases);
            insert listOfCases;   
            /* New case is inserted here */
        }
    }
}
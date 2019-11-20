@isTest
public class TestVerifyAddressHandler {
    /*This method checks the working of trigger with correct input data data*/
    static testMethod void correctInputs() {
        SalesHeader__c objectSalesHeader = new SalesHeader__c();
        objectSalesHeader.Status__c = 'Open';
        insert objectSalesHeader;
        System.debug('---Sales Header---'+objectSalesHeader);

        EFT_Transaction_Status__c objectEFT = new EFT_Transaction_Status__c();
        objectEFT.Method_Name__c = ' Credit Card Address ';
        objectEFT.Transaction_Status__c = 'Declined';
        System.debug('--- Transaction Status---'+ objectEFT.Transaction_Status__c);
        objectEFT.SalesHeaderStatus__c = objectSalesHeader.id;
        //objectEFT.SalesHeaderStatus__c = objectSalesHeader ;
        //objectEFT.SalesHeaderStatus__r.Status__c = objectSalesHeader.Status__c ;
        
        System.debug('---Status---'+objectEFT.SalesHeaderStatus__r.Status__c);

        //List<EFT_Transaction_Status__c> assertList = new List<EFT_Transaction_Status__c>();
        //assertList.add(objectEFT);
        insert objectEFT;
        System.debug('---List Inserted---'+objectEFT);

        List<Case> listOfCases = [Select Priority,Subject From Case];
        system.debug('***'+listOfCases);
        system.assertEquals(1, listOfCases.size());
    }

    static testMethod void bulkCorrectInputs() {
        SalesHeader__c objectSalesHeader = new SalesHeader__c();
        objectSalesHeader.Status__c = 'Open';
        insert objectSalesHeader;
        System.debug('---Sales Header---'+objectSalesHeader);

        EFT_Transaction_Status__c objectEFT ;
        List<EFT_Transaction_Status__c> listBulkEFT = new List<EFT_Transaction_Status__c>();
        for(Integer i = 1 ; i<=400; i++){
            objectEFT = new EFT_Transaction_Status__c();
            objectEFT.Method_Name__c = ' Credit Card Address ';
            objectEFT.Transaction_Status__c = 'Declined';
            System.debug('--- Transaction Status---'+ objectEFT.Transaction_Status__c);
            objectEFT.SalesHeaderStatus__c = objectSalesHeader.id;
            listBulkEFT.add(objectEFT);
         }
        
        System.debug('---Status---'+objectEFT.SalesHeaderStatus__r.Status__c);
        
        Database.insert (listBulkEFT);
        System.debug('---List Inserted---'+objectEFT);

        List<Case> listOfCases = [Select Priority,Subject From Case];
        system.debug('***'+listOfCases);
        system.assertEquals(400, listOfCases.size());
    }    
    
    static testMethod void InvalidMethodName(){
		SalesHeader__c objectSalesHeader = new SalesHeader__c();
        objectSalesHeader.Status__c = 'Open';
        insert objectSalesHeader;
        System.debug('---Sales Header---'+objectSalesHeader);

        EFT_Transaction_Status__c objectEFT = new EFT_Transaction_Status__c();
        System.debug('---Invalid Method Name---'+objectSalesHeader);
        objectEFT.Method_Name__c = ' Credit Card ';
        objectEFT.Transaction_Status__c = 'Declined';

        
        System.debug('--- Transaction Status---'+ objectEFT.Transaction_Status__c);
        objectEFT.SalesHeaderStatus__c = objectSalesHeader.id;
        //objectEFT.SalesHeaderStatus__c = objectSalesHeader ;
        //objectEFT.SalesHeaderStatus__r.Status__c = objectSalesHeader.Status__c ;
        
        System.debug('---Status---'+objectEFT.SalesHeaderStatus__r.Status__c);

        //List<EFT_Transaction_Status__c> assertList = new List<EFT_Transaction_Status__c>();
        //assertList.add(objectEFT);
        insert objectEFT;
        System.debug('---List Inserted---'+objectEFT);

        List<Case> listOfCases = [Select Priority,Subject From Case];
        system.debug('***'+listOfCases); 
        system.assertEquals(0, listOfCases.size());
   }
    
    static testMethod void bulkInvalidMethodName(){
		SalesHeader__c objectSalesHeader = new SalesHeader__c();
        objectSalesHeader.Status__c = 'Open';
        insert objectSalesHeader;
        System.debug('---Sales Header---'+objectSalesHeader);

        EFT_Transaction_Status__c objectEFT ;
        List<EFT_Transaction_Status__c> listBulkEFT = new List<EFT_Transaction_Status__c>();
        for(Integer i = 1 ; i<=200; i++){
            objectEFT = new EFT_Transaction_Status__c();
            if(i<=100){
                objectEFT.Method_Name__c = ' Credit Card Address ';
                objectEFT.Transaction_Status__c = 'Declined';
                System.debug('--- Transaction Status---'+ objectEFT.Transaction_Status__c);
                objectEFT.SalesHeaderStatus__c = objectSalesHeader.id;
                listBulkEFT.add(objectEFT);                
            }
            if(i>100 && i<=200){
                objectEFT.Method_Name__c = ' Credit Card Access ';
                objectEFT.Transaction_Status__c = 'Declined';
                System.debug('--- Transaction Status---'+ objectEFT.Transaction_Status__c);
                objectEFT.SalesHeaderStatus__c = objectSalesHeader.id;
                listBulkEFT.add(objectEFT);                
            }
         }
        Database.insert (listBulkEFT);
        System.debug('---List Inserted---'+objectEFT);

        List<Case> listOfCases = [Select Priority,Subject From Case];
        system.debug('***'+listOfCases); 
        system.assertEquals(100, listOfCases.size());
   }    
    
    static testMethod void InvalidTransactionStatus(){
		SalesHeader__c objectSalesHeader = new SalesHeader__c();
        objectSalesHeader.Status__c = 'Open';
        insert objectSalesHeader;
        System.debug('---Sales Header---'+objectSalesHeader);

        EFT_Transaction_Status__c objectEFT = new EFT_Transaction_Status__c();
        System.debug('---Invalid Transaction Status Name---');
        objectEFT.Method_Name__c = ' Credit Card Address';
        objectEFT.Transaction_Status__c = 'Dec';

        
        System.debug('--- Transaction Status---'+ objectEFT.Transaction_Status__c);
        objectEFT.SalesHeaderStatus__c = objectSalesHeader.id;
        //objectEFT.SalesHeaderStatus__c = objectSalesHeader ;
        //objectEFT.SalesHeaderStatus__r.Status__c = objectSalesHeader.Status__c ;
        
        System.debug('---Status---'+objectEFT.SalesHeaderStatus__r.Status__c);

        //List<EFT_Transaction_Status__c> assertList = new List<EFT_Transaction_Status__c>();
        //assertList.add(objectEFT);
        insert objectEFT;
        System.debug('---List Inserted---'+objectEFT);

        List<Case> listOfCases = [Select Priority,Subject From Case];
        system.debug('***'+listOfCases); 
        system.assertEquals(0, listOfCases.size());
   }
    
    static testMethod void bulkInvalidTransactionStatus(){
		SalesHeader__c objectSalesHeader = new SalesHeader__c();
        objectSalesHeader.Status__c = 'Open';
        insert objectSalesHeader;
        System.debug('---Sales Header---'+objectSalesHeader);

        EFT_Transaction_Status__c objectEFT ;
        List<EFT_Transaction_Status__c> listBulkEFT = new List<EFT_Transaction_Status__c>();
        for(Integer i = 1 ; i<=200; i++){
            objectEFT = new EFT_Transaction_Status__c();
            if(i<=100){
                objectEFT.Method_Name__c = ' Credit Card Address ';
                objectEFT.Transaction_Status__c = 'Declined';
                System.debug('--- Transaction Status---'+ objectEFT.Transaction_Status__c);
                objectEFT.SalesHeaderStatus__c = objectSalesHeader.id;
                listBulkEFT.add(objectEFT);                
            }
            if(i>100 && i<=200){
                objectEFT.Method_Name__c = ' Credit Card Address ';
                objectEFT.Transaction_Status__c = 'Accepted';
                System.debug('--- Transaction Status---'+ objectEFT.Transaction_Status__c);
                objectEFT.SalesHeaderStatus__c = objectSalesHeader.id;
                listBulkEFT.add(objectEFT);                
            }
         }
        Database.insert (listBulkEFT);
        System.debug('---List Inserted---'+objectEFT);

        List<Case> listOfCases = [Select Priority,Subject From Case];
        system.debug('***'+listOfCases); 
        system.assertEquals(100, listOfCases.size());
   }     
   
    static testMethod void InvalidStatusSalesHeader(){
		SalesHeader__c objectSalesHeader = new SalesHeader__c();
        objectSalesHeader.Status__c = 'Closed';
        insert objectSalesHeader;
        System.debug('---Sales Header---'+objectSalesHeader);

        EFT_Transaction_Status__c objectEFT = new EFT_Transaction_Status__c();
        System.debug('---Invalid Method Name---'+objectSalesHeader);
        objectEFT.Method_Name__c = ' Credit Card Address';
        objectEFT.Transaction_Status__c = 'Declined';
        objectEFT.SalesHeaderStatus__c = objectSalesHeader.id;
        //objectEFT.SalesHeaderStatus__c = objectSalesHeader ;
        //objectEFT.SalesHeaderStatus__r.Status__c = objectSalesHeader.Status__c ;
        
        insert objectEFT;
        System.debug('---List Inserted---'+objectEFT);

        List<Case> listOfCases = [Select Priority,Subject From Case];
        system.debug('***'+listOfCases); 
        system.assertEquals(0, listOfCases.size());
       
    }
    
    static testMethod void bulkInvalidStatusSalesHeader(){
		SalesHeader__c objectSalesHeader = new SalesHeader__c();
        objectSalesHeader.Status__c = 'Closed';
        insert objectSalesHeader;
        System.debug('---Sales Header---'+objectSalesHeader);

        EFT_Transaction_Status__c objectEFT ;
        List<EFT_Transaction_Status__c> listBulkEFT = new List<EFT_Transaction_Status__c>();
        for(Integer i = 1 ; i<=200; i++){
            objectEFT = new EFT_Transaction_Status__c();
            if(i<=200){
                objectEFT.Method_Name__c = ' Credit Card Address ';
                objectEFT.Transaction_Status__c = 'Declined';
                System.debug('--- Transaction Status---'+ objectEFT.Transaction_Status__c);
                objectEFT.SalesHeaderStatus__c = objectSalesHeader.id;
                listBulkEFT.add(objectEFT);                
            }
         }
        Database.insert (listBulkEFT);
        System.debug('---List Inserted---'+objectEFT);

        List<Case> listOfCases = [Select Priority,Subject From Case];
        system.debug('***'+listOfCases); 
        system.assertNotEquals(200, listOfCases.size());
   } 

    static testMethod void bulkInvalidMethodAndTransaction(){
		SalesHeader__c objectSalesHeader = new SalesHeader__c();
        objectSalesHeader.Status__c = 'Open';
        insert objectSalesHeader;
        System.debug('---Sales Header---'+objectSalesHeader);

        EFT_Transaction_Status__c objectEFT ;
        List<EFT_Transaction_Status__c> listBulkEFT = new List<EFT_Transaction_Status__c>();
        for(Integer i = 1 ; i<=400; i++){
            objectEFT = new EFT_Transaction_Status__c();
            if(i<=200){
                objectEFT.Method_Name__c = ' Credit Card Access ';
                objectEFT.Transaction_Status__c = 'Declined';
                System.debug('--- Transaction Status---'+ objectEFT.Transaction_Status__c);
                objectEFT.SalesHeaderStatus__c = objectSalesHeader.id;
                listBulkEFT.add(objectEFT);                
            }
            if(i>200 && i<=400){
                objectEFT.Method_Name__c = ' Credit Card Address ';
                objectEFT.Transaction_Status__c = 'Accepted';
                System.debug('--- Transaction Status---'+ objectEFT.Transaction_Status__c);
                objectEFT.SalesHeaderStatus__c = objectSalesHeader.id;
                listBulkEFT.add(objectEFT);                
            }
         }
        Database.insert (listBulkEFT);
        System.debug('---List Inserted---'+objectEFT);

        List<Case> listOfCases = [Select Priority,Subject From Case];
        system.debug('***'+listOfCases); 
        system.assertEquals(0, listOfCases.size());
   }    
    
}
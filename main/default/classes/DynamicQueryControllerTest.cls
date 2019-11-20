@isTest
public with sharing class DynamicQueryControllerTest {
	static testMethod void validSearchValue(){
		List<Account> accountList = TestDataFactory.insertAccountList10();
        insert accountList;
        List<Account> checkList = [Select name From Account];
        system.debug('----Accounts----'+checkList);
        List<ID> IdList = new List<ID>();
        for(Account eachID : accountList){
            IdList.add(eachID.Id);
        }
        Id [] fixedSearchResults= new Id[2];
        fixedSearchResults[0] = IdList[5];
        fixedSearchResults[1] = IdList[6];
        
		Test.setFixedSearchResults(fixedSearchResults);
		test.startTest();        
        DynamicQueryController objectDynamic = new DynamicQueryController();
		objectDynamic.selectedObject = 'account';
        objectDynamic.getunSelectedValues();
        objectDynamic.getSelectedValues();
        objectDynamic.getSortOptionList();
        objectDynamic.selectclick();
        objectDynamic.unselectclick();
        Set<String> selectedFieldList = new Set<String>{'name','phone'};
		objectDynamic.rightvalues = selectedFieldList;
		objectDynamic.inputValue = 'test';
        objectDynamic.selectedField = 'name';
        objectDynamic.recordCount = '100';
        objectDynamic.getRecords();
        test.stopTest();
        system.debug('***'+objectDynamic.searchList);
        system.assertEquals(false,ApexPages.hasMessages(),'sb no errors');
	} 

	static testMethod void noSearchValue(){
		List<Account> accountList = TestDataFactory.insertAccountList10();
        insert accountList;
        List<Account> checkList = [Select name From Account];
        system.debug('----Accounts----'+checkList);
        
        try{
            test.startTest();
            DynamicQueryController objectDynamic = new DynamicQueryController();
			objectDynamic.selectedObject = 'account';
            Set<String> selectedFieldList = new Set<String>{'name','phone'};
            objectDynamic.rightvalues = selectedFieldList;
            objectDynamic.inputValue = '';
            objectDynamic.selectedField = 'name';
            objectDynamic.recordCount = '100';
            objectDynamic.getRecords();
            test.stopTest();
            system.debug('***'+objectDynamic.searchList);            
        }
        catch(Exception e){
            system.assertEquals('search term must be longer than one character: *', e.getMessage());
        }
	} 
    
	static testMethod void noFieldsSelected(){
		List<Account> accountList = TestDataFactory.insertAccountList10();
        insert accountList;
        List<Account> checkList = [Select name From Account];
        system.debug('----Accounts----'+checkList);
        
        try{
            test.startTest();
            DynamicQueryController objectDynamic = new DynamicQueryController();
			objectDynamic.selectedObject = 'account';
            Set<String> selectedFieldList = new Set<String>();
            objectDynamic.rightvalues = selectedFieldList;
            objectDynamic.inputValue = 'test';
            objectDynamic.selectedField = 'name';
            objectDynamic.recordCount = '100';
            objectDynamic.getRecords();
            test.stopTest();
            system.debug('***'+objectDynamic.searchList);            
        }
        catch(Exception e){
            system.assert(e.getMessage().contains('unexpected token'));
        }
	}    
    
	static testMethod void NumericSearchValue(){
		List<Account> accountList = TestDataFactory.insertAccountList10();
        insert accountList;
        List<Account> checkList = [Select name From Account];
        system.debug('----Accounts----'+checkList);
       
            test.startTest();
            DynamicQueryController objectDynamic = new DynamicQueryController();
			objectDynamic.selectedObject = 'account';
            Set<String> selectedFieldList = new Set<String>();
            objectDynamic.rightvalues = selectedFieldList;
            objectDynamic.inputValue = '200';
            objectDynamic.selectedField = 'name';
            objectDynamic.recordCount = '100';
            objectDynamic.getRecords();
            ApexPages.Message[] pageMessages = ApexPages.getMessages();
            Boolean messageFound = false;
            
            for(ApexPages.Message message : pageMessages) {
                if(message.getSummary() == 'Please Enter text value '
                    && message.getSeverity() == ApexPages.Severity.WARNING) {
                    messageFound = true;        
                }
            }
 			test.stopTest();           
            System.assert(messageFound);
                
	}
}
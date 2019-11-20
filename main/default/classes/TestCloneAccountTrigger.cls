@isTest
public with sharing class TestCloneAccountTrigger {

	//Below method checks insertion of two records .
	//This method inserts two records which are inturn cloned
	
	static testMethod void InsertTwoRecords()
	{
		Account accountObject = new Account();
		accountObject.Name = 'TestAccountClone1';
			
        test.startTest();
		insert accountObject;
        test.stopTest();
        
		Integer count = [Select count() From Account Where Name = 'TestAccountClone1' ];
		// Prints Total number of Accounts
		system.debug('--------- Total No of Accounts --------------');
		system.debug(count);
		system.assertEquals(2,count);
	}

	//Below method inserts bulk records which are inturn cloned. 
	//Currently 205 records are being cloned 
	 
	static testMethod void InsertBulkRecords()
	{
		List<Account> accountsCloned = new  List<Account>();
        Set<String> uniqueAccounts = new Set<String>();
		Account accountObject;
		for(Integer i = 0 ; i < 200 ; i++ )
		{
			accountObject = new Account(Name = 'TestCloneAccount'+''+string.valueof(i));
			accountsCloned.add(accountObject);
            uniqueAccounts.add(accountObject.Name);
		}
            
		Test.startTest();
		insert accountsCloned;
        Test.stopTest();
        
		Integer countBulkRecords = [Select count() From Account Where Name IN : uniqueAccounts];
		// Prints Total number of Accounts
		system.debug('------Total Accounts-----');
		system.debug('     '+countBulkRecords+'    ');
		system.assertEquals(400 , countBulkRecords);
	}
}
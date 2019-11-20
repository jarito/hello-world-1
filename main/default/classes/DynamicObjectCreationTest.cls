@isTest
/**
 * This test class checks whether all the scenarios of Batch are being covered
 */
public with sharing class DynamicObjectCreationTest {
	/**
	 * This method checks whether the appropriate object is getting created with appropraite fields.
	 * Here, Lead record is being created 
	 */
	static testMethod void validInputSingleLead(){
        ManageEvent__c thisEvent = TestDataFactory.validInputSingleLead();
		insert thisEvent;

		test.startTest();        
        DynamicObjectCreation objectDynamicObjectCreation = new DynamicObjectCreation();
		Database.executeBatch(objectDynamicObjectCreation);
		test.stopTest();

		List<Lead> checkList = [Select Id From Lead Where LastName = 'BatchApexLead'];
		system.assertEquals(1,checkList.size());	
	}

	/**
	 * This method checks whether the appropriate object is getting created with appropraite fields.
	 * Here, Account record is being created 
	 */
	static testMethod void validInputSingleAccount(){
        ManageEvent__c thisEvent = TestDataFactory.validInputSingleAccount();
		insert thisEvent;

		test.startTest();        
        DynamicObjectCreation objectDynamicObjectCreation = new DynamicObjectCreation();
		Database.executeBatch(objectDynamicObjectCreation);
		test.stopTest();

		List<Account> checkList = [Select Id From Account Where Name = 'BatchApexAccount'];
		system.assertEquals(1,checkList.size());	
	}

	/**
	 * This method checks whether the appropriate object is getting created with appropraite fields.
	 * Here, Contact record is being created 
	 */
	static testMethod void validInputSingleContact(){
        ManageEvent__c thisEvent = TestDataFactory.validInputSingleContact();
		insert thisEvent;

		test.startTest();        
        DynamicObjectCreation objectDynamicObjectCreation = new DynamicObjectCreation();
		Database.executeBatch(objectDynamicObjectCreation);
		test.stopTest();

		List<Contact> checkList = [Select Id From Contact Where Name = 'BatchApexContact'];
		system.assertEquals(1,checkList.size());	
	}

	/**
	 * This method checks whether the appropriate object is getting created with appropraite fields.
	 * Here, 200 Lead records are being created 
	 */
	static testMethod void validInputBulk(){
        List<ManageEvent__c> thisEvent = TestDataFactory.validInputBulkEvent();
		insert thisEvent;
		test.startTest();        
        DynamicObjectCreation objectDynamicObjectCreation = new DynamicObjectCreation();
		Database.executeBatch(objectDynamicObjectCreation);
		test.stopTest();

		List<Lead> checkList = [Select Id From Lead];
		system.assertEquals(200,checkList.size());	
	}		

	/**
	 * This method checks whether the appropriate object is getting created with appropraite fields
	 * Here, 200 Lead records are being created
	 * This method also checks the behavior of batch by passing empty value in the key value pair 
	 */
	static testMethod void validInputBulkOneValueEmpty(){
        List<ManageEvent__c> thisEvent = TestDataFactory.inValidInputBulkEvent();
		insert thisEvent;
		test.startTest();        
        DynamicObjectCreation objectDynamicObjectCreation = new DynamicObjectCreation();
		Database.executeBatch(objectDynamicObjectCreation);
		test.stopTest();

		List<Lead> checkList = [Select Id From Lead];
		system.assertEquals(198,checkList.size());	
	}

	static testMethod void scheduler(){
		SchedulerForDynamicObjectCreation.scheduleMe();
	}
}
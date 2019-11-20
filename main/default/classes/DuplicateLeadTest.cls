@isTest
/**
 * This test class checks whether all the scenarios of Batch are being covered
 */
public with sharing class DuplicateLeadTest {
	
	/**
	 * This method tests the behavior of batch class when Duplicate check is to be done based on
	 * Email when the Custom setting of Email based check is set to true. Here, two records are considered for test
	 */
	static testMethod void oneleadDuplicateByEmailTrue(){
		DuplicateCheck__c logSettings = DuplicateCheck__c.getOrgDefaults();
    	System.debug('**'+logSettings);
		logSettings.EmailBased__c = true;
    	insert logSettings;
		List<Lead> leadList = TestDataFactory.dataOneleadDuplicateByEmail();
		insert leadList;

		test.startTest();        
        DuplicateLead objectDuplicateLead = new DuplicateLead();
		Database.executeBatch(objectDuplicateLead);
		test.stopTest();	
		List<Lead> checkList = [Select
									Id
								From
									Lead];
		system.assertEquals(1,checkList.size());
	}

	/**
	 * This method tests the behavior of batch class when Duplicate check is to be done based on
	 * Email but the Custom setting of Email based check is set to false. Here, two records are considered for test
	 */
	static testMethod void oneleadDuplicateByEmailFalse(){
		EmailBasedDuplicateCheck__c logSettings = EmailBasedDuplicateCheck__c.getOrgDefaults();
    	logSettings.EmailBased__c = false;
    	insert logSettings;List<Lead> leadList = TestDataFactory.dataOneleadDuplicateByEmail();
		insert leadList;

		test.startTest();        
        DuplicateLead objectDuplicateLead = new DuplicateLead();
		Database.executeBatch(objectDuplicateLead);
		test.stopTest();	
		List<Lead> checkList = [Select
									Id
								From
									Lead];
		system.assertNotEquals(1,checkList.size());
	}

	/**
	 * This method tests the behavior of batch class when Duplicate check is to be done based on
	 * Phone when the Custom setting of Phone based check is set to true. Here, two records are considered for test
	 */
	static testMethod void oneleadDuplicateByPhoneTrue(){
		DuplicateCheck__c logSettings = DuplicateCheck__c.getOrgDefaults();
    	logSettings.PhoneBased__c = true;
    	insert logSettings;List<Lead> leadList = TestDataFactory.OneleadDuplicateByPhone();
		insert leadList;

		test.startTest();        
        DuplicateLead objectDuplicateLead = new DuplicateLead();
		Database.executeBatch(objectDuplicateLead);
		test.stopTest();	
		List<Lead> checkList = [Select
									Id
								From
									Lead];
		system.assertEquals(1,checkList.size());
	}

	/**
	 * This method tests the behavior of batch class when Duplicate check is to be done based on
	 * Phone but the Custom setting of Phone based check is set to false. Here, two records are considered for test
	 */
	static testMethod void oneleadDuplicateByPhoneFalse(){
		DuplicateCheck__c logSettings = DuplicateCheck__c.getOrgDefaults();
    	logSettings.PhoneBased__c = false;
    	insert logSettings;List<Lead> leadList = TestDataFactory.OneleadDuplicateByPhone();
		insert leadList;

		test.startTest();        
        DuplicateLead objectDuplicateLead = new DuplicateLead();
		Database.executeBatch(objectDuplicateLead);
		test.stopTest();	
		List<Lead> checkList = [Select
									Id
								From
									Lead];
		system.assertNotEquals(1,checkList.size());
	}

	/**
	 * This method tests the behavior of batch class when Duplicate check is to be done based on
	 * FirstName when the Custom setting of FirstName based check is set to true. Here, two records are considered for test
	 */
	static testMethod void oneleadDuplicateByFirstNameTrue(){
		DuplicateCheck__c logSettings = DuplicateCheck__c.getOrgDefaults();
    	logSettings.FirstNameBased__c = true;
    	insert logSettings;
		List<Lead> leadList = TestDataFactory.OneleadDuplicateByFirstName();
		insert leadList;

		test.startTest();        
        DuplicateLead objectDuplicateLead = new DuplicateLead();
		Database.executeBatch(objectDuplicateLead);
		test.stopTest();	
		List<Lead> checkList = [Select
									Id
								From
									Lead];
		system.assertEquals(1,checkList.size());
	}

	/**
	 * This method tests the behavior of batch class when Duplicate check is to be done based on
	 * FirstName but the Custom setting of FirstName based check is set to false. Here, two records are considered for test
	 */
	static testMethod void oneleadDuplicateByFirstNameFalse(){
		DuplicateCheck__c logSettings = DuplicateCheck__c.getOrgDefaults();
    	logSettings.FirstNameBased__c = false;
    	insert logSettings;
		List<Lead> leadList = TestDataFactory.OneleadDuplicateByFirstName();
		insert leadList;

		test.startTest();        
        DuplicateLead objectDuplicateLead = new DuplicateLead();
		Database.executeBatch(objectDuplicateLead);
		test.stopTest();	
		List<Lead> checkList = [Select
									Id
								From
									Lead];
		system.assertNotEquals(1,checkList.size());
	}
	/**
	 * This method tests the Batch class logic with 200 leads being inserted at a time where multiple fields
	 * leads are duplicate. Here, FirstName is considered duplicate
	 */
	static testMethod void multipleleadDuplicateByFirstName(){
		DuplicateCheck__c logSettings = DuplicateCheck__c.getOrgDefaults();
    	logSettings.FirstNameBased__c = true;
    	insert logSettings;
		List<Lead> leadList = TestDataFactory.MultipleleadDuplicateByFirstName();
		insert leadList;

		test.startTest();        
        DuplicateLead objectDuplicateLead = new DuplicateLead();
		Database.executeBatch(objectDuplicateLead);
		test.stopTest();	
		List<Lead> checkList = [Select
									Id
								From
									Lead];
		system.assertEquals(42,checkList.size());
	}

	/**
	 * This method tests the Batch class logic with 200 leads being inserted at a time where multiple fields
	 * leads are duplicate. Here, Email is considered duplicate
	 */
	static testMethod void multipleleadDuplicateByEmail(){
		DuplicateCheck__c logSettings = DuplicateCheck__c.getOrgDefaults();
    	logSettings.EmailBased__c = true;
    	insert logSettings;
		List<Lead> leadList = TestDataFactory.MultipleleadDuplicateByEmail();
		insert leadList;

		test.startTest();        
        DuplicateLead objectDuplicateLead = new DuplicateLead();
		Database.executeBatch(objectDuplicateLead);
		test.stopTest();	
		List<Lead> checkList = [Select
									Id
								From
									Lead];
		system.assertEquals(42,checkList.size());
	}

	/**
	 * This method tests the Batch class logic with 200 leads being inserted at a time where multiple fields
	 * leads are duplicate. Here, Phone is considered duplicate
	 */
	static testMethod void multipleleadDuplicateByPhone(){
		DuplicateCheck__c logSettings = DuplicateCheck__c.getOrgDefaults();
    	logSettings.PhoneBased__c = true;
    	insert logSettings;
		List<Lead> leadList = TestDataFactory.MultipleleadDuplicateByPhone();
		insert leadList;

		test.startTest();        
        DuplicateLead objectDuplicateLead = new DuplicateLead();
		Database.executeBatch(objectDuplicateLead);
		test.stopTest();	
		List<Lead> checkList = [Select
									Id
								From
									Lead];
		system.assertEquals(42,checkList.size());
	}

	static testMethod void scheduler(){
		SchedulerForDuplicateLead.scheduleMe();
	}

}
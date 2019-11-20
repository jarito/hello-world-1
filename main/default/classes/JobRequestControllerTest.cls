/** 
 * Test class to verify whether controller 'JobRequestControllerTest' is working as expected
 */
@isTest
public with sharing class JobRequestControllerTest {
	/**
	 * Method to check the behavior of Save method of controller
	 * Note : JobType type is Maintainance
	 */
	static testMethod void checkSaveMethodMaintainance(){
		List<Case> listOfCases = TestDataFactory.createCases(1,'Maintainance');
		test.startTest();
		JobRequestController objectJobRequestController = new JobRequestController( new ApexPages.StandardController(listOfCases[0]));
		objectJobRequestController.selectedJob='Maintainance';
		PageReference pageRef = objectJobRequestController.save();
		test.stopTest();
		list<Case> checkList = [Select Job_Description__c,Job_Type__c From Case];
		system.assertEquals('Maintainance',checkList[0].Job_Type__c);
		system.assertEquals('Technical issue0',checkList[0].Job_Description__c);
        AssignmentRule AR = new AssignmentRule();
        AR = [select id,Name from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
		system.assertEquals('assignToTechnician',AR.Name);
		system.assertEquals(null,pageRef);
	}
	/**
	 * Method to check the behavior of Save method of controller
	 * Note : JobType type is Repair
	 */
	static testMethod void checkSaveMethodRepair(){
		List<Case> listOfCases = TestDataFactory.createCases(1,'Repair');
		test.startTest();
		JobRequestController objectJobRequestController = new JobRequestController( new ApexPages.StandardController(listOfCases[0]));
		objectJobRequestController.selectedJob='Repair';
		PageReference pageRef = objectJobRequestController.save();
		test.stopTest();
		list<Case> checkList = [Select Job_Description__c,Job_Type__c From Case];
        AssignmentRule AR = new AssignmentRule();
        AR = [select id,Name from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
		system.assertEquals('Repair',checkList[0].Job_Type__c);
		system.assertEquals('Technical issue0',checkList[0].Job_Description__c);
		system.assertEquals('assignToTechnician',AR.Name);
		system.assertEquals(null,pageRef);
	}
	/**
	 * Method to check the behavior of Update method of controller
	 * Note : Out of total 8 cases, JobType type for 4 cases is Repair and 4 cases is Maintainance 
	 */
	static testMethod void checkUpdateMethodDisplay(){
		List<Case> listOfCases = TestDataFactory.createCases(4,'Repair');
		insert listOfCases;
		List<Case> caseList = TestDataFactory.createCases(4,'Maintainance');
		insert caseList;		
		test.startTest();
		JobRequestController objectJobRequestController = new JobRequestController( new ApexPages.StandardController(listOfCases[0]));
		objectJobRequestController.init();
		system.debug('-----Existing records-----> '+objectJobRequestController.existingCases);
		List<Case> checkList = objectJobRequestController.existingCases;
		system.debug('-----Existing records   -----> '+checkList);
		checkList[7].Job_Description__c = 'test';
		PageReference pageRef = objectJobRequestController.updateRecord();
		system.debug('Check Update--->'+checkList[7].Job_Description__c);
		test.stopTest();
		system.assertEquals('test',checkList[7].Job_Description__c);
		system.assertEquals(null,pageRef);
	}
	/**
	 * Method to check whether current page is getting redirected to new page 
	 * on click of button 'Track and Update Job' where new page is the page 
	 * where user can track his/her previous Job Requests or update the previous
	 * Job Requests
	 */
	static testMethod void checkPageRefUpdateJob(){
		List<Case> listOfCases = TestDataFactory.createCases(4,'Repair');
		insert listOfCases;		
		test.startTest();
		JobRequestController objectJobRequestController = new JobRequestController( new ApexPages.StandardController(listOfCases[0]));
		PageReference checkReference = ApexPages.currentPage();
		PageReference pageRef = objectJobRequestController.updateJob();
		system.assertNotEquals(checkReference , pageRef);

	}
}
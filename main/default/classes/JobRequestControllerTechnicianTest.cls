/**
 * Test class to check the working of Controller 'JobRequestControllerTechnician'
 */
@isTest
public with sharing class JobRequestControllerTechnicianTest {
	/**
	 * Method to check whether the changes made by the Technician are are getting saved.
	 * Note: Here making changes refers to modifying the status of Status of the Job Request.
	 */
	static testMethod void checkUpdates(){
		List<Case> listOfCases = TestDataFactory.createCases(4,'Maintainance');
		insert listOfCases;
		List<Case> CaseList = TestDataFactory.createCases(4,'Repair');
		insert CaseList;
		test.startTest();
			JobRequestControllerTechnician objectJobRequestControllerTechnician = new JobRequestControllerTechnician( new ApexPages.StandardController(listOfCases[0]));
			objectJobRequestControllerTechnician.init();
			List<Case> checkList = objectJobRequestControllerTechnician.existingCases;
			checkList[1].Status = 'Closed';
			PageReference pageRef = objectJobRequestControllerTechnician.updateRecord();
			List<Case> checkListOnUpdate = [Select Status From Case];
		test.stopTest();
		system.assertEquals('Closed',checkListOnUpdate[1].Status);
		system.assertEquals(null,pageRef);
	}
}
/**
 * This class verifies behavior of 'SoapLeadDml' class for different scenarios 
 */
@isTest
public with sharing class SoapLeadDmlTest {
    /**
     * This methods checks the behavior of Create method by sending valid parameters to the Create method
     */
	static testMethod void createLeadValidParams(){
		test.startTest();
		String expectedResult = SoapLeadDml.createLead('leadFName','leadLName','lead@gmail.com','8899','Espl','Closed - Converted');
  		System.debug('Result---->'+expectedResult);
		test.stopTest();
		System.assert(expectedResult.contains('Success'));
    	System.assert(expectedResult.contains('true'));		
	}
    /**
     * This methods checks the behavior of Create method by sending Invalid parameters to the Create method
     * Note: Here LastName is missing	
	 */
	static testMethod void createLeadNoLastName(){
		test.startTest();
		String expectedResult = SoapLeadDml.createLead('leadFName',' ','lead@gmail.com','8899','Espl','Closed - Converted');
  		System.debug('Result---->'+expectedResult);
		test.stopTest();
    	System.assert(expectedResult.contains('false'));		
	}

    /**
     * This methods checks the behavior of Delete method by sending parameters to the Delete method
     */    
	static testMethod void deleteLeadValidParams(){
		Lead leadObj = new Lead(FirstName = 'leadFName', Lastname = 'leadLName', Email = 'lead@gmail.com',Phone = '8899',  Company ='Espl', Status='Closed - Converted');
		insert leadObj;
		test.startTest();
		String expectedResult = SoapLeadDml.deleteLead('leadFName','leadLName','lead@gmail.com','8899','Espl','Closed - Converted');
  		System.debug('Result---->'+expectedResult);
		test.stopTest();
		System.assert(expectedResult.contains('Success'));
    	System.assert(expectedResult.contains('true'));		
	}

    /**
     * This methods checks the behavior of Create method by sending parameters to the Delete method
     * Note : Here there's no record matching with the parameters passed
     */	
	static testMethod void deleteLeadInValidParams(){
		Lead leadObj = new Lead(FirstName = 'leadFName', Lastname = 'leadName', Email = 'lead@gmail.com',Phone = '8899',  Company ='Espl', Status='Closed - Converted');
		insert leadObj;
		test.startTest();
		String expectedResult = SoapLeadDml.deleteLead('leadFName','leadLName','lead@gmail.com','8899','Espl','Closed - Converted');
  		System.debug('Result---->'+expectedResult);
		test.stopTest();
    	System.assert(expectedResult.contains('No such record exists'));		
	}
    /**
     * This methods checks the behavior of Update method by sending valid parameters to the Update method
     */
	static testMethod void updateLeadValidParams(){
		Lead leadObj = new Lead(FirstName = 'leadFName', Lastname = 'leadLName', Email = 'lead@gmail.com',Phone = '8899',  Company ='Espl', Status='Closed - Converted');
		insert leadObj;
		test.startTest();
		String expectedResult = SoapLeadDml.updateLead('leadFName','leadLName','lead@yahoo.com','8888888','Espl','Closed - Converted');
  		System.debug('Result---->'+expectedResult);
		test.stopTest();
		System.assert(expectedResult.contains('Success'));
    	System.assert(expectedResult.contains('true'));		
	}
    /**
     * This methods checks the behavior of update method by sending invalid parameters to the update method
     * Note : Here there's no record matching with the parameters passed
	 */
	static testMethod void updateLeadInValidParams(){
		Lead leadObj = new Lead(FirstName = 'leadName', Lastname = 'leadLName', Email = 'lead@gmail.com',Phone = '8899',  Company ='Espl', Status='Closed - Converted');
		insert leadObj;
		test.startTest();
		String expectedResult = SoapLeadDml.updateLead('leadFName','leadLName','lead@yahoo.com','8888888','Espl','Closed - Converted');
  		System.debug('Result---->'+expectedResult);
		test.stopTest();
		System.assert(expectedResult.contains('No such record exists'));		
	}
}
/**
 * Test class to verify the working of 'AcceptLead' class
 */
@isTest
public with sharing class AcceptLeadTest {
    /**
 	 * This method checks the behavior of the class when valid parameters are passed to the Create method 
     */
    static testMethod void createLeadValidParams(){
        AcceptLead.leadRecord innerClass  = TestDataFactory.createLeadList();

        String JsonParams = JSON.serialize(innerClass);
        system.debug('----JsonParams------'+JsonParams);
        Test.startTest();
        RestRequest requestObj = new RestRequest(); 
        RestResponse responseObj = new RestResponse();

        requestObj.requestURI = 'https://ap4.salesforce.com/services/apexrest/getData';  //Request URL
        requestObj.httpMethod = 'POST';
        requestObj.requestBody = Blob.valueof(JsonParams);
        system.debug('-----requestObj.requestBody------'+requestObj.requestBody);
        RestContext.request = requestObj;
        RestContext.response= responseObj; 

        AcceptLead.createLeadRecord(innerClass);
        //AcceptLead.ResponseMessage checkResponseObject = new AcceptLead.ResponseMessage();
        system.debug('--------------RestContext.response----------'+RestContext.response.responseBody.toString());
        //system.debug('--------------RestContext.response status----------'+RestContext.response.responseBody.Status.toString());
        System.assert(RestContext.response.responseBody.toString().contains('Success'));
        System.assert(RestContext.response.responseBody.toString().contains('true'));       

        Test.stopTest(); 
    } 
    /**
 	 * This method checks the behavior of the class when Invalid parameters are passed to the Create method
 	 * Note : Here LastName is missing 
     */
    static testMethod void createLeadLastNameMissing(){
        AcceptLead.leadRecord innerClass  = TestDataFactory.createLeadListNoLastName();

        String JsonParams = JSON.serialize(innerClass);
        system.debug('----JsonParams------'+JsonParams);
        Test.startTest();
        RestRequest requestObj = new RestRequest(); 
        RestResponse responseObj = new RestResponse();

        requestObj.requestURI = 'https://ap4.salesforce.com/services/apexrest/getData';  //Request URL
        requestObj.httpMethod = 'POST';
        requestObj.requestBody = Blob.valueof(JsonParams);
        system.debug('-----requestObj.requestBody------'+requestObj.requestBody);
        RestContext.request = requestObj;
        RestContext.response= responseObj;

        AcceptLead.createLeadRecord(innerClass);
        AcceptLead.ResponseMessage checkResponseObject = new AcceptLead.ResponseMessage();
        system.debug('--------------RestContext.response----------'+RestContext.response.responseBody.toString());
        System.assert(RestContext.response.responseBody.toString().contains('false'));      

        Test.stopTest(); 
    }

    /**
 	 * This method checks the behavior of the class when No parameters are passed to the Create method 
     */    
    static testMethod void createLeadAllParamsMissing(){
        AcceptLead.leadRecord innerClass  = TestDataFactory.createLeadListNoLastName();
        String JsonParams = JSON.serialize(innerClass);
        system.debug('----JsonParams------'+JsonParams);
        Test.startTest();
        RestRequest requestObj = new RestRequest(); 
        RestResponse responseObj = new RestResponse();

        requestObj.requestURI = 'https://ap4.salesforce.com/services/apexrest/getData';  //Request URL
        requestObj.httpMethod = 'POST';
        requestObj.requestBody = Blob.valueof(JsonParams);
        system.debug('-----requestObj.requestBody------'+requestObj.requestBody);
        RestContext.request = requestObj;
        RestContext.response= responseObj;

        AcceptLead.createLeadRecord(innerClass);
        AcceptLead.ResponseMessage checkResponseObject = new AcceptLead.ResponseMessage();
        system.debug('--------------RestContext.response----------'+RestContext.response.responseBody.toString());  
        Test.stopTest(); 
        System.assert(RestContext.response.responseBody.toString().contains('false'));          
    }   
    /**
 	 * This method checks the behavior of the class by passing parameters to the Delete method 
     */
    static testMethod void deleteLeadValidInput(){
        Lead leadObj = new Lead (LastName = 'TestLead10', Company = 'ESPL' , Status = 'Closed - Converted' );
        insert leadObj;
        String thisId = leadObj.Id;
        String lastname = leadObj.LastName;
        Test.startTest();
        RestRequest requestObj = new RestRequest();
        RestResponse responseObj = new RestResponse();
        requestObj.requestUri = 'https://ap4.salesforce.com/services/apexrest/getData?leadId='+thisId+'&leadLastName='+lastname;
        system.debug('URI----> '+requestObj.requestUri);
        RestContext.request = requestObj;
        RestContext.response= responseObj;
        AcceptLead.doDelete();
        Test.stopTest();
        system.debug('--------------RestContext.response----------'+RestContext.response.responseBody.toString());
        System.assert(RestContext.response.responseBody.toString().contains('true'));          
    }

    /**
 	 * This method checks the behavior of the class by passing parameters to the Update method 
     */   
    static testMethod void updateLead(){        
        //Lead leadObj = TestDataFactory.createLead();
        Lead leadObj = new Lead ();
        leadObj.LastName = 'TestLead600'; 
        leadObj.Status = 'Closed-Converted'; 
        leadObj.Company = 'Espl5';
        insert leadObj;
        AcceptLead.leadRecord innerClass  = TestDataFactory.createLeadList();
        String JsonParams = JSON.serialize(innerClass);
        system.debug('----JsonParams for Update------'+JsonParams);
        Test.startTest();
        RestRequest requestObj = new RestRequest(); 
        RestResponse responseObj = new RestResponse();

        requestObj.requestURI = 'https://ap4.salesforce.com/services/apexrest/getData?_HttpMethod=PATCH';  //Request URL
        requestObj.httpMethod = 'POST';
        requestObj.requestBody = Blob.valueof(JsonParams);
        system.debug('-----requestObj.requestBody------'+requestObj.requestBody);
        RestContext.request = requestObj;
        RestContext.response= responseObj;

        AcceptLead.leadUpdate(innerClass);
        AcceptLead.ResponseMessage checkResponseObject = new AcceptLead.ResponseMessage();
        system.debug('--------------RestContext.response----------'+RestContext.response.responseBody.toString());
        //system.debug('--------------RestContext.response status----------'+RestContext.response.responseBody.Status.toString());
        System.assert(RestContext.response.responseBody.toString().contains('Success'));
        System.assert(RestContext.response.responseBody.toString().contains('true'));
        Test.stopTest(); 
    
        List<Lead> leadCheck = [Select Id,Company From Lead ];
        for(Lead listNew : leadCheck){
            system.debug('*****'+listNew.Company);
        }
    }       
}
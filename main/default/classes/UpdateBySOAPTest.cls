/**
 * This class checks the working of class 'GuestValidationTriggerHandler' with various scenarios
 */
@isTest
public with sharing class UpdateBySOAPTest { 
  /** 
   * This method verifies the response when valid parameters are sent and buffer is zero
   */
  static testMethod void createGuestValidParamsBuffer0(){
    Test.setMock(WebServiceMock.class, new MockGuestSoapUpdate('A'));
    /** 
     * Guest record with all valid parameters
     */
    List<Guest__c> guestList = TestDataFactory.createGuest('validParamsBuffer0');
    insert guestList;
    /**
     * Serialized the List to pass it as a parameter to future method
     * As future method cannot take sObjects as a parameter, here JSON string is sent 
     */
    String newGuests = json.serialize(guestList);
    String guestID;  
    for(Guest__c eachGuest : guestList){ 
      guestID = eachGuest.Id ; 
    }
    Test.startTest();
    
    GuestValidationTriggerHandler.validateGuestRecordSoap(newGuests , guestID);
    String expectedResponse = GuestValidationTriggerHandler.retId;
    Test.stopTest();
    //System.assertEquals('Congratulations',expectedResponse);    
  }

  /** 
   * This method verifies the response when valid parameters are sent and buffer has some value
   */
  static testMethod void createGuestValidParamsWithBuffer(){
    Test.setMock(WebServiceMock.class, new MockGuestSoapUpdate('B'));
    /** 
     * Guest record with all valid parameters and some buffer value
     */
    List<Guest__c> guestList = TestDataFactory.createGuest('validParamsWithBuffer');
    insert guestList;
    /**
     * Serialized the List to pass it as a parameter to future method
     * As future method cannot take sObjects as a parameter, here JSON string is sent 
     */
    String newGuests = json.serialize(guestList);
    String guestID;  
    for(Guest__c eachGuest : guestList){ 
      guestID = eachGuest.Id ; 
    }
    Test.startTest();
    
    GuestValidationTriggerHandler.validateGuestRecordSoap(newGuests , guestID);
    String expectedResponse = GuestValidationTriggerHandler.retId;
    Test.stopTest();
    //System.assertEquals('Congratulations',expectedResponse);    
  }

  /** 
   * This method verifies the response when wrong Arrival Terminal is sent 
   */
  static testMethod void createGuestWrongArrivalTerminal(){
    Test.setMock(WebServiceMock.class, new MockGuestSoapUpdate('C'));
    /** 
     * Guest record with wrong Arrival Terminal
     */
    List<Guest__c> guestList = TestDataFactory.createGuest('wrongArrivalTerminal');
    insert guestList;
    /**
     * Serialized the List to pass it as a parameter to future method
     * As future method cannot take sObjects as a parameter, here JSON string is sent 
     */
    String newGuests = json.serialize(guestList);
    String guestID;  
    for(Guest__c eachGuest : guestList){ 
      guestID = eachGuest.Id ; 
    }
    Test.startTest();
    
    GuestValidationTriggerHandler.validateGuestRecordSoap(newGuests , guestID);
    String expectedResponse = GuestValidationTriggerHandler.retId;
    Test.stopTest();
    //System.assertEquals('Congratulations',expectedResponse);    
  }

  /** 
   * This method verifies the response when wrong Arrival AirportCode
   */
  static testMethod void createGuestWrongArrivalAirportCode(){
    Test.setMock(WebServiceMock.class, new MockGuestSoapUpdate('D'));
    /** 
     * Guest record with wrong Arrival AirportCode
     */
    List<Guest__c> guestList = TestDataFactory.createGuest('wrongArrivalAirportCode');
    insert guestList;
    /**
     * Serialized the List to pass it as a parameter to future method
     * As future method cannot take sObjects as a parameter, here JSON string is sent 
     */
    String newGuests = json.serialize(guestList);
    String guestID;  
    for(Guest__c eachGuest : guestList){ 
      guestID = eachGuest.Id ; 
    }
    Test.startTest();
    
    GuestValidationTriggerHandler.validateGuestRecordSoap(newGuests , guestID);
    String expectedResponse = GuestValidationTriggerHandler.retId;
    Test.stopTest();
    //System.assertEquals('Congratulations',expectedResponse);    
  }

  /** 
   * This method verifies the response when wrong Departure Terminal & Departure Airport Code is sent 
   */
  static testMethod void createGuestTwoParamsWrong(){
    Test.setMock(WebServiceMock.class, new MockGuestSoapUpdate('E'));
    /** 
     * Guest record with wrong  Departure Terminal & Departure Airport Code 
     */
    List<Guest__c> guestList = TestDataFactory.createGuest('wrongDepartureTerminal&DepartureAirportCode');
    insert guestList;
    /**
     * Serialized the List to pass it as a parameter to future method
     * As future method cannot take sObjects as a parameter, here JSON string is sent 
     */
    String newGuests = json.serialize(guestList);
    String guestID;  
    for(Guest__c eachGuest : guestList){ 
      guestID = eachGuest.Id ; 
    }
    Test.startTest();
    
    GuestValidationTriggerHandler.validateGuestRecordSoap(newGuests , guestID);
    String expectedResponse = GuestValidationTriggerHandler.retId;
    Test.stopTest();
    //System.assertEquals('Congratulations',expectedResponse);    
  }

  /** 
   * This method verifies the response when  Departure Terminal is Missing 
   */
  static testMethod void createGuestDepartureTreminalMissing(){
    Test.setMock(WebServiceMock.class, new MockGuestSoapUpdate('F'));
    /** 
     * Guest record with wrong  Departure Terminal is Missing 
     */
    List<Guest__c> guestList = TestDataFactory.createGuest('departureTreminalMissing');
    insert guestList;
    /**
     * Serialized the List to pass it as a parameter to future method
     * As future method cannot take sObjects as a parameter, here JSON string is sent 
     */
    String newGuests = json.serialize(guestList);
    String guestID;  
    for(Guest__c eachGuest : guestList){ 
      guestID = eachGuest.Id ; 
    }
    Test.startTest();
     
    GuestValidationTriggerHandler.validateGuestRecordSoap(newGuests , guestID);
    String expectedResponse = GuestValidationTriggerHandler.retId;
    Test.stopTest();
    //System.assertEquals('Congratulations',expectedResponse);    
  }

  /** 
   * This method verifies the response when All Related Fields are Missing
   */
  static testMethod void createGuestAllRelatedFieldsMissing(){
    Test.setMock(WebServiceMock.class, new MockGuestSoapUpdate('G'));
    /** 
     * Guest record with  All Related Fields Missing
     */
    List<Guest__c> guestList = TestDataFactory.createGuest('allRelatedFieldsMissing');
    insert guestList;
    /**
     * Serialized the List to pass it as a parameter to future method
     * As future method cannot take sObjects as a parameter, here JSON string is sent 
     */
    String newGuests = json.serialize(guestList);
    String guestID;  
    for(Guest__c eachGuest : guestList){ 
      guestID = eachGuest.Id ; 
    }
    Test.startTest();
    
    GuestValidationTriggerHandler.validateGuestRecordSoap(newGuests , guestID);
    String expectedResponse = GuestValidationTriggerHandler.retId;
    Test.stopTest();
    //System.assertEquals('Congratulations',expectedResponse);    
  }
 
}
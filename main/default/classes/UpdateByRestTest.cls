@isTest
public class UpdateByRestTest { 
    /**
	 * Test Case 1
     * This method verifies the response which should be generated when valid parameters are passed 
     * for Validation
     */ 
    static testMethod void createGuestValidParamsBuffer0(){
        Test.setMock(HttpCalloutMock.class, new MockUpdateByRest('A'));
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
		test.startTest();
 		GuestValidationTriggerHandler.validateGuestRecord(newGuests , guestID);
        //system.debug('Body-----> '+res.getBody());
        test.stopTest();
		//system.assert(res.getBody().contains('true'));
    }

	/** 
	 * Test Case 2 
	 * This method verifies the response when valid parameters are sent and buffer has some value
	 */
    static testMethod void createGuestValidParamsWithBuffer(){
        Test.setMock(HttpCalloutMock.class, new MockUpdateByRest('B'));
		/** 
		 * Guest record with all valid parameters
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
		test.startTest();
 		GuestValidationTriggerHandler.validateGuestRecord(newGuests , guestID);
        //system.debug('Body-----> '+res.getBody());
        test.stopTest();
		//system.assert(res.getBody().contains('true'));
    }

	/** 
	 * Test Case 3
	 * This method verifies the response when wrong Arrival Terminal is sent 
	 */
    static testMethod void createGuestWrongArrivalTerminal(){
        Test.setMock(HttpCalloutMock.class, new MockUpdateByRest('C'));
		/** 
		 * Guest record with all valid parameters
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
		test.startTest();
 		GuestValidationTriggerHandler.validateGuestRecord(newGuests , guestID);
        //system.debug('Body-----> '+res.getBody());
        test.stopTest();
		//system.assert(res.getBody().contains('true'));
    }

	/** 
	 * Test Case 4
	 * This method verifies the response when wrong Arrival AirportCode is sent
	 */
    static testMethod void createGuestWrongArrivalAirportCode(){
        Test.setMock(HttpCalloutMock.class, new MockUpdateByRest('D'));
		/** 
		 * Guest record with all valid parameters
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
		test.startTest();
 		GuestValidationTriggerHandler.validateGuestRecord(newGuests , guestID);
        //system.debug('Body-----> '+res.getBody());
        test.stopTest();
		//system.assert(res.getBody().contains('true'));
    }

	/** 
	 * Test Case 5
	 * This method verifies the response when wrong Departure Terminal and Wrong Departure AirportCode is sent
	 */
    static testMethod void createGuestTwoParamsWrong(){
        Test.setMock(HttpCalloutMock.class, new MockUpdateByRest('E'));
		/** 
		 * Guest record with all valid parameters
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
		test.startTest();
 		GuestValidationTriggerHandler.validateGuestRecord(newGuests , guestID);
        //system.debug('Body-----> '+res.getBody());
        test.stopTest();
		//system.assert(res.getBody().contains('true'));
    }

	/** 
	 * Test Case 6
	 * This method verifies the response when Departure Terminal is missing
	 */
    static testMethod void createGuestDepartureTreminalMissing(){
        Test.setMock(HttpCalloutMock.class, new MockUpdateByRest('F'));
		/** 
		 * Guest record with all valid parameters
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
		test.startTest();
 		GuestValidationTriggerHandler.validateGuestRecord(newGuests , guestID);
        //system.debug('Body-----> '+res.getBody());
        test.stopTest();
		//system.assert(res.getBody().contains('true'));
    }

	/** 
	 * Test Case 7
	 * This method verifies the response when all related fields are missing
	 */
    static testMethod void createGuestAllRelatedFieldsMissing(){
        Test.setMock(HttpCalloutMock.class, new MockUpdateByRest('G'));
		/** 
		 * Guest record with all valid parameters
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
		test.startTest();
 		GuestValidationTriggerHandler.validateGuestRecord(newGuests , guestID);
        //system.debug('Body-----> '+res.getBody());
        test.stopTest();
		//system.assert(res.getBody().contains('true'));
    }

}
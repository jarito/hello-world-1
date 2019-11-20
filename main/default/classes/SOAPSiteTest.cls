@isTest
global with sharing class SOAPSiteTest {
	/**
	 * Test Case 1
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
    static testMethod void searchWithValidParams(){
        Test.setMock(WebServiceMock.class, new MockSOAPSiteTest('A'));
		/** 
		 * Guest record with all valid parameters
		 */
		List<Guest__c> guestList = TestDataFactory.createGuest('validParamsBuffer0'); 
		
		test.startTest();
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList[0];
 		objGuest.getFlights();
		system.debug('objGuest.flightList-->'+objGuest.flightList); 
        test.stopTest();
		/**
		 * Assert to check the size of list returned as response. 
		 * This list contains the flight records matching with the search parameters entered by the guest
		 */
		system.assertEquals(1 , objGuest.flightList.size() );
    }
	//CONTINUE FROM HERE ************
	/**
	 * Test Case 2
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
	
    static testMethod void searchAirportCodeOnly(){
        Test.setMock(WebServiceMock.class, new MockSOAPSiteTest('B'));
		 
		//Guest record with all valid parameters
		 
		List<Guest__c> guestList = TestDataFactory.createGuest('searchAirportCodeOnly'); 
		
		test.startTest();
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList[0];
 		objGuest.getFlights();
		system.debug('objGuest.flightList-->'+objGuest.flightList); 
        test.stopTest();
		
		 // Assert to check the size of list returned as response. 
		 // This list contains the flight records matching with the search parameters entered by the guest
		 
		system.assertEquals(1 , objGuest.flightList.size() );
    }
	
	/**
	 * Test Case 3
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
	
    static testMethod void searchArrivalDateOnly(){
        Test.setMock(WebServiceMock.class, new MockSOAPSiteTest('C'));
		 
		//Guest record with all valid parameters
		 
		List<Guest__c> guestList = TestDataFactory.createGuest('searchArrivalDateOnly'); 
		
		test.startTest(); 
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList[0];
 		objGuest.getFlights();
		system.debug('objGuest.flightList-->'+objGuest.flightList); 
        test.stopTest();
		
		 // Assert to check the size of list returned as response. 
		 // This list contains the flight records matching with the search parameters entered by the guest
		 
		system.assertEquals(2 , objGuest.flightList.size() );
    }

	/**
	 * Test Case 4
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
	
    static testMethod void searchDepartureDateOnly(){
        Test.setMock(WebServiceMock.class, new MockSOAPSiteTest('D'));
		 
		//Guest record with all valid parameters
		 
		List<Guest__c> guestList = TestDataFactory.createGuest('searchDepartureDateOnly'); 
		
		test.startTest(); 
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList[0];
 		objGuest.getFlights();
		system.debug('objGuest.flightList-->'+objGuest.flightList); 
        test.stopTest();
		
		 // Assert to check the size of list returned as response. 
		 // This list contains the flight records matching with the search parameters entered by the guest
		 
		system.assertEquals(2 , objGuest.flightList.size() );
    }

	/**
	 * Test Case 5
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
	
    static testMethod void searchAirportCodeAndFlightNumber(){
        Test.setMock(WebServiceMock.class, new MockSOAPSiteTest('E'));
		 
		//Guest record with all valid parameters
		 
		List<Guest__c> guestList = TestDataFactory.createGuest('searchAirportCodeAndFlightNumber'); 
		
		test.startTest(); 
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList[0];
 		objGuest.getFlights();
		system.debug('objGuest.flightList-->'+objGuest.flightList); 
        test.stopTest();
		
		 // Assert to check the size of list returned as response. 
		 // This list contains the flight records matching with the search parameters entered by the guest
		 
		system.assertEquals(1 , objGuest.flightList.size() );
    }

	/**
	 * Test Case 6
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
	
    static testMethod void searchWrongAirportCode(){
        Test.setMock(WebServiceMock.class, new MockSOAPSiteTest('F'));
		 
		//Guest record with all valid parameters
		 
		List<Guest__c> guestList = TestDataFactory.createGuest('searchWrongAirportCode'); 
		
		test.startTest(); 
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList[0];
 		objGuest.getFlights();
		system.debug('objGuest.flightList-->'+objGuest.flightList); 
        test.stopTest();
		
		 // Assert to check the size of list returned as response. 
		 // This list contains the flight records matching with the search parameters entered by the guest
		 
		system.assertEquals(0 , objGuest.flightList.size() );
    }

	/**
	 * Test Case 7
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */	
    static testMethod void searchWrongArrivalTime(){
        Test.setMock(WebServiceMock.class, new MockSOAPSiteTest('G'));
		 
		//Guest record with all valid parameters
		 
		List<Guest__c> guestList = TestDataFactory.createGuest('searchWrongArrivalTime'); 
		
		test.startTest(); 
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList[0];
 		objGuest.getFlights();
		system.debug('objGuest.flightList-->'+objGuest.flightList); 
        test.stopTest();
		
		 // Assert to check the size of list returned as response. 
		 // This list contains the flight records matching with the search parameters entered by the guest
		 
		system.assertEquals(0 , objGuest.flightList.size() );
    }	 
}
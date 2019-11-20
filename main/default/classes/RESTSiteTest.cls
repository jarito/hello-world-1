@isTest
public with sharing class RESTSiteTest {
	/**
	 * Test Case 1
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
    static testMethod void searchWithValidParams(){
        Test.setMock(HTTPCalloutMock.class, new MockRESTSiteTest('A'));
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

	/**
	 * Test Case 2
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
    static testMethod void searchAirportCodeOnly(){
        Test.setMock(HttpCalloutMock.class, new MockRESTSiteTest('B'));
		/** 
		 * Guest record with all valid parameters
		 */
		Guest__c guestList = TestDataFactory.createGuestForSite('searchAirportCodeOnly'); 
		
		test.startTest();
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList;
 		objGuest.getFlights();
		system.debug('objGuest.flightList-->'+objGuest.flightList); 
        test.stopTest();
		/**
		 * Assert to check the size of list returned as response. 
		 * This list contains the flight records matching with the search parameters entered by the guest
		 */
		system.assertEquals(1 , objGuest.flightList.size() );
    }

	/**
	 * Test Case 3
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
    static testMethod void searchArrivalDateOnly(){
        Test.setMock(HttpCalloutMock.class, new MockRESTSiteTest('C'));
		/** 
		 * Guest record with all valid parameters
		 */
		Guest__c guestList = TestDataFactory.createGuestForSite('searchArrivalDateOnly'); 
		
		test.startTest();
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList;
 		objGuest.getFlights();
		system.debug('objGuest.flightList-->'+objGuest.flightList); 
        test.stopTest();
		/**
		 * Assert to check the size of list returned as response. 
		 * This list contains the flight records matching with the search parameters entered by the guest
		 */
		system.assertEquals(2 , objGuest.flightList.size() );
    }

	/**
	 * Test Case 4
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
    static testMethod void searchDepartureDateOnly(){
        Test.setMock(HttpCalloutMock.class, new MockRESTSiteTest('D'));
		/** 
		 * Guest record with all valid parameters
		 */
		Guest__c guestList = TestDataFactory.createGuestForSite('searchDepartureDateOnly'); 
		
		test.startTest();
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList;
 		objGuest.getFlights();
		system.debug('objGuest.flightList-->'+objGuest.flightList); 
        test.stopTest();
		/**
		 * Assert to check the size of list returned as response. 
		 * This list contains the flight records matching with the search parameters entered by the guest
		 */
		system.assertEquals(2 , objGuest.flightList.size() );
    }

	/**
	 * Test Case 5
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
    static testMethod void searchAirportCodeAndFlightNumber(){
        Test.setMock(HttpCalloutMock.class, new MockRESTSiteTest('E'));
		/** 
		 * Guest record with all valid parameters
		 */
		Guest__c guestList = TestDataFactory.createGuestForSite('searchAirportCodeAndFlightNumber'); 
		
		test.startTest();
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList;
 		objGuest.getFlights();
		system.debug('objGuest.flightList-->'+objGuest.flightList); 
        test.stopTest();
		/**
		 * Assert to check the size of list returned as response. 
		 * This list contains the flight records matching with the search parameters entered by the guest
		 */
		system.assertEquals(1 , objGuest.flightList.size() );
    }

	/**
	 * Test Case 6
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
    static testMethod void searchWrongAirportCode(){
        Test.setMock(HttpCalloutMock.class, new MockRESTSiteTest('F'));
		/** 
		 * Guest record with all valid parameters
		 */
		Guest__c guestList = TestDataFactory.createGuestForSite('searchWrongAirportCode'); 
		
		test.startTest();
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList;
 		objGuest.getFlights();
		
        test.stopTest();
		/**
		 * Assert to check the size of list returned as response. 
		 * This list contains the flight records matching with the search parameters entered by the guest
		 */
		//system.assertEquals('0' , objGuest.flightList.size() );
    }

	/**
	 * Test Case 7
	 * This method checks the response generated when the search parameters entered by guests has 
	 * matching record/records in the other org, where callout is made
	 */
    static testMethod void searchWrongArrivalTime(){
        Test.setMock(HttpCalloutMock.class, new MockRESTSiteTest('G'));
		/** 
		 * Guest record with all valid parameters
		 */
		Guest__c guestList = TestDataFactory.createGuestForSite('searchWrongArrivalTime'); 
		
		test.startTest();
		SiteForFlightInfoController objGuest = new SiteForFlightInfoController();
		objGuest.guest = guestList;
 		objGuest.getFlights();
		
        test.stopTest();
		/**
		 * Assert to check the size of list returned as response. 
		 * This list contains the flight records matching with the search parameters entered by the guest
		 */
		//system.assertEquals('0' , objGuest.flightList.size() );
    }

}
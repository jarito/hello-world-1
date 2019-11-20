public with sharing class SiteForFlightInfoController {
    public class OAuth2{
        public String access_token{get;set;}    
    }
	public class InnerClass{
		public String airLineCode{get;set;}
		public String flightNumber{get;set;}
		public DateTime arrivalTime{get;set;}
		public DateTime departureTime{get;set;}
		public String arrivalAirportCode {get;set;}
		public String departureAirportCode {get;set;}
		public String arrivalTerminal {get;set;}
		public String departureTerminal {get;set;}
	}

	public Guest__c guest {get;set;}
	public List<InnerClass> flightList {get;set;}
	public List<soapSforceComSchemasClassFlightserv.innerClass> flightList1 {get;set;}
	public SiteForFlightInfoController() {
		guest = new Guest__c();
		flightList = new List<InnerClass>();
		
	}
    // REST Method starts here 
	
	public void getFlights(){
		InnerClass objInnerClass = new InnerClass();
		if( (guest.Airline_Code__c == '' || guest.Airline_Code__c == null) && 
		    (guest.Flight_Number__c == '' || guest.Flight_Number__c == null ) && 
			( guest.Arrival_Time__c == null) && 
			( guest.Departure_Time__c == null ) ){
				system.debug('IF LOOP Check');
				ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Oops !! You did not enter anything to search'));	 				
		}
		else{
			objInnerClass.airLineCode = guest.Airline_Code__c;
			objInnerClass.flightNumber = guest.Flight_Number__c;		 
			objInnerClass.arrivalTime = guest.Arrival_Time__c;
			objInnerClass.departureTime = guest.Departure_Time__c;

			system.debug('Check DATETIME ---> '+objInnerClass.arrivalTime);
			String record = JSON.serialize(objInnerClass);
			system.debug('Check this String ---> '+record);
			String token;
			String clientId = '3MVG9YDQS5WtC11r0rQi024uFUaTtCDigt2cQ8L5Xz3k.K1TALA8NV6DE8ifY3nBIQ2xCBq.Q6oaeQznNz9.8';
			String clientSecret = '2845833679178439160';
			String userName = 'shruti@eternussolutions.com';
			String password = 'espl@1819wCfvIk2ZF6kBYbt5AzknsTvy';
			String requestBody= '&grant_type=password'+'&client_id='+clientId+
							'&client_secret='+clientSecret+'&username='+username+'&password='+password ;
			
			HttpRequest requestForToken = new HttpRequest();
			requestForToken.setBody(requestBody);
			requestForToken.setMethod('POST');
			requestForToken.setEndPoint('https://ap4.salesforce.com/services/oauth2/token');
			Http httpConnectionforToken = new Http();
			HttpResponse response = httpConnectionforToken.send(requestForToken);
			system.debug('*****'+response);
			OAuth2 objAuthenticationInfo = (OAuth2)JSON.deserialize(response.getbody(), OAuth2.class);
			system.debug('---Token---'+objAuthenticationInfo.access_token);
			token = objAuthenticationInfo.access_token;
				
			Http httpConnectionSetToken = new Http();
			HttpRequest requestForSetToken = new HttpRequest();
			requestForSetToken.setHeader('Authorization','Bearer '+objAuthenticationInfo.access_token);
			requestForSetToken.setHeader('Content-Type','application/json');
			requestForSetToken.setHeader('Accept','application/json');
			requestForSetToken.setBody(record);//Send JSON body
			requestForSetToken.setMethod('POST');
			requestForSetToken.setEndpoint('https://ap4.salesforce.com/services/apexrest/getFlight');
			HttpResponse res1 = httpConnectionSetToken.send(requestForSetToken);
			system.debug('RESPONSE_BODY----> '+res1.getbody());
			system.debug('RESPONSE_STATUS------> '+res1.getStatus());
			system.debug('RESPONSE_STATUS------> '+res1.getStatusCode());
				
			if(res1.getStatusCode() == 200){
				system.debug('Inside status code----> ');
				String str = res1.getBody();
				system.debug('Inside status code String----> '+str);
				//system.debug('tempList----> '+flightList);

				flightList = (List<InnerClass>)Json.deserialize(str, List<InnerClass>.class);
				
			}
			else if(res1.getStatusCode() == 500) { 
				ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,res1.getBody()));	
				system.debug('Error Message----> '+res1.getBody());	   
			}
		}
	}
	

	// REST Method Ends here */

	// SOAP Method Starts here 
	/*
	public void getFlights(){
		if( (guest.Airline_Code__c == '' || guest.Airline_Code__c == null) && 
		    (guest.Flight_Number__c == '' || guest.Flight_Number__c == null ) && 
			( guest.Arrival_Time__c == null) && 
			( guest.Departure_Time__c == null ) ){
				system.debug('IF LOOP Check');
				ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Oops !! You did not enter anything to search'));	 				
		}
		else{
			string sessionidfetch;

			partnerSoapSforceCom1.Soap myPartnerSoap=new partnerSoapSforceCom1.Soap();  // Main class:partnerSoapSforceCom  Sublcass:Soap which contains login method
			partnerSoapSforceCom1.LoginResult  partnerloginresult=myPartnerSoap.login('shruti@eternussolutions.com','espl@123fgP8qxs4JAVV1S1mhYopfLMA');
			// Return type of login method is "partnerSoapSforceCom.LoginResult"
			system.debug('Generated session id is'+partnerloginresult.sessionId);  // Generating session id
			sessionidfetch=partnerloginresult.sessionId; // Storing session id          

			soapSforceComSchemasClassFlightserv.SessionHeader_element webservicesessionheader=new soapSforceComSchemasClassFlightserv.SessionHeader_element();
			webservicesessionheader.sessionId=sessionidfetch;  // Passing session id to session header element
			soapSforceComSchemasClassFlightserv.innerClass objInnerClass = new soapSforceComSchemasClassFlightserv.innerClass();
			objInnerClass.airLineCode = guest.Airline_Code__c;
			objInnerClass.flightNumber = guest.Flight_Number__c;		 
			objInnerClass.arrivalTime = guest.Arrival_Time__c;
			objInnerClass.departureTime = guest.Departure_Time__c;
			soapSforceComSchemasClassFlightserv.FlightServerSOAP objA=new soapSforceComSchemasClassFlightserv.FlightServerSOAP();
			objA.SessionHeader=webservicesessionheader; 
			flightList1 = new List<soapSforceComSchemasClassFlightserv.innerClass>();
			flightList1= objA.createGuestRecord(objInnerClass);
			if(flightList1 == null){
				String errorMsg = 'Oops !'+'\n'+'There are no Flights available fitting this Criteria';
				system.debug('Check String---->'+errorMsg);
				ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,errorMsg));
			}
			else{
				InnerClass objInnerClass1 = new InnerClass();
				for(soapSforceComSchemasClassFlightserv.innerClass obj : flightList1){
					objInnerClass1 = new InnerClass();
					objInnerClass1.airLineCode = obj.airLineCode;
					objInnerClass1.flightNumber = obj.flightNumber;
					objInnerClass1.arrivalTerminal = obj.arrivalTerminal;
					objInnerClass1.arrivalTime = obj.arrivalTime;
					objInnerClass1.departureTime = obj.departureTime;
					objInnerClass1.arrivalAirportCode = obj.arrivalAirportCode;
					objInnerClass1.departureAirportCode = obj.departureAirportCode;
					objInnerClass1.departureTerminal = obj.departureTerminal;
					flightList.add(objInnerClass1);
				}
			}
			system.debug('Response is 1---------> '+flightList1);
		}		
	}
	*/
	// SOAP Method Ends here 
}
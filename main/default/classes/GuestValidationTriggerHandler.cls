global with sharing class GuestValidationTriggerHandler {
    
    public class OAuth2{
        public String access_token{get;set;}    
    }

	public class Record{
		public String airLineCode{get;set;}
		public String arrivalAirportCode {get;set;} 
		public String departureAirportCode {get;set;}
		public String arrivalTerminal {get;set;}
		public String departureTerminal {get;set;}
		public DateTime arrivalTime {get;set;}
		public DateTime departureTime {get;set;}
		public String flightNumber {get;set;}
        public Decimal buffer {get;set;}
	}

    /** REST IMPLEMENTATION **/
    /*
    @future(callout=true) 
    global static void validateGuestRecord(String newGuests , String id){
		List<Guest__c> listObj = (List<Guest__c>)Json.deserialize(newGuests, List<Guest__c>.class);
		Record objRecord = new Record();
		for(Guest__c eachGuest : listObj){
			objRecord.airLineCode = eachGuest.Airline_Code__c;
			objRecord.arrivalAirportCode = eachGuest.Arrival_Airport_Code__c;
			objRecord.departureAirportCode = eachGuest.Departure_Airport_Code_c__c;
			objRecord.arrivalTerminal = eachGuest.Arrival_Terminal__c;
			objRecord.departureTerminal = eachGuest.Departure_Terminal__c;
			objRecord.arrivalTime = eachGuest.Arrival_Time__c;
			objRecord.departureTime = eachGuest.Departure_Time__c;
			objRecord.flightNumber = eachGuest.Flight_Number__c;
			objRecord.buffer = eachGuest.Buffer__c;
		}		 

		String checkJson = 	Json.serialize(objRecord);
		system.debug('Check this String ---> '+checkJson);
		String token;
		String clientId = '3MVG9YDQS5WtC11r0rQi024uFUaTtCDigt2cQ8L5Xz3k.K1TALA8NV6DE8ifY3nBIQ2xCBq.Q6oaeQznNz9.8';
		String clientSecret = '2845833679178439160';
		String userName = 'shruti@eternussolutions.com';
		String password = 'espl@123fgP8qxs4JAVV1S1mhYopfLMA';
		//public String url = 'https://ap4.salesforce.com/services/apexrest/';
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

		requestForSetToken.setBody(checkJson);//Send JSON body
		requestForSetToken.setMethod('POST');
		requestForSetToken.setEndpoint('https://ap4.salesforce.com/services/apexrest/validateGuest');
		HttpResponse res1 = httpConnectionSetToken.send(requestForSetToken);
		system.debug('RESPONSE_BODY----> '+res1.getbody());
		system.debug('RESPONSE_STATUS------> '+res1.getStatus());
		system.debug('RESPONSE_STATUS------> '+res1.getStatusCode());
			
		if(res1.getStatusCode() == 200){
			List<Guest__c> singleObj = [Select Validation__c,Error_Message__c From Guest__c Where ID=:id LIMIT 1];
			List<Guest__c> newList = new List<Guest__c>();
			for(Guest__c guestObj : singleObj){
				guestObj.Validation__c = 'Completed';
				guestObj.Error_Message__c = res1.getBody();
				newList.add(guestObj);				
			}
			BooleanController.check = true;
			update newList;
			
			//Guest__c guestObject = new Guest__c(ID = id);
			//guestObject.Validation__c = 'Completed';
			//guestObject.Error_Message__c = res1.getBody();
			
			//system.debug('Response Message----> '+guestObj.Error_Message__c );
			//insert guestObject;
		} 
		else {
			List<Guest__c> singleObj = [Select Validation__c,Error_Message__c From Guest__c Where ID=:id LIMIT 1];
			List<Guest__c> newList = new List<Guest__c>();
			for(Guest__c guestObj : singleObj){
				guestObj.Validation__c = 'Pending';
				guestObj.Error_Message__c = res1.getBody();
				newList.add(guestObj);				
			}
			BooleanController.check = true;
			update newList;
			
			//Guest__c guestObject = new Guest__c(ID = id);
			//guestObject.Validation__c = 'Pending';
			//guestObject.Error_Message__c = res1.getBody();
			//system.debug('Error Message----> '+guestObject.Error_Message__c );
			//insert guestObject;	
			
				   
		}
	}  
	*/

    /** SOAP IMPLEMENTATION **/

    
	public static String retId {get;set;}
    @future(callout=true)
    global static void validateGuestRecordSoap(String newGuests , String id){
        string sessionidfetch;
        List<Guest__c> listObj = (List<Guest__c>)Json.deserialize(newGuests, List<Guest__c>.class);
        system.debug('-------'+listObj);
        for(Guest__c eachGuest : listObj){
            system.debug('*******');
            if( ( eachGuest.Airline_Code__c == null || eachGuest.Airline_Code__c == '' ) ||
                ( eachGuest.Arrival_Airport_Code__c == null || eachGuest.Arrival_Airport_Code__c == '' ) ||
                ( eachGuest.Departure_Airport_Code_c__c == null || eachGuest.Departure_Airport_Code_c__c == '' ) ||
                ( eachGuest.Arrival_Terminal__c == null || eachGuest.Arrival_Terminal__c == '' ) ||
                ( eachGuest.Departure_Terminal__c == null || eachGuest.Departure_Terminal__c == '' ) || 
                ( eachGuest.Buffer__c == null ) ||
                ( eachGuest.Arrival_Time__c == null ) ||
                ( eachGuest.Departure_Time__c == null ) ||
                ( eachGuest.Flight_Number__c == null || eachGuest.Flight_Number__c == '' ) ){
                                system.debug('******* if ***');
                    List<Guest__c> singleObj = [Select Validation__c,Error_Message__c From Guest__c Where ID=:id LIMIT 1];
                    List<Guest__c> newList = new List<Guest__c>();
                    for(Guest__c guestObj : singleObj){
                        guestObj.Validation__c = 'Pending';
                        guestObj.Error_Message__c = 'Incomplete Flight Details';
                        newList.add(guestObj);				
                    }
                    BooleanController.check = true;
                    update newList;	                    
                    system.debug('Oops !! You have not entered required Flight details ');

            }
            else{
                            system.debug('****else***');
                system.debug('Oops !!');
                Record objRecord = new Record();
                for(Guest__c eachNewGuest : listObj){
                    objRecord.airLineCode = eachNewGuest.Airline_Code__c;
                    objRecord.arrivalAirportCode = eachNewGuest.Arrival_Airport_Code__c;
                    objRecord.departureAirportCode = eachNewGuest.Departure_Airport_Code_c__c;
                    objRecord.arrivalTerminal = eachNewGuest.Arrival_Terminal__c;
                    objRecord.departureTerminal = eachNewGuest.Departure_Terminal__c;
                    objRecord.arrivalTime = eachNewGuest.Arrival_Time__c;
                    objRecord.departureTime = eachNewGuest.Departure_Time__c;
                    objRecord.flightNumber = eachNewGuest.Flight_Number__c;
                    objRecord.buffer = eachNewGuest.Buffer__c;
                }
                partnerSoapSforceCom.Soap mypartnersoap=new partnerSoapSforceCom.Soap();  // Main class:partnerSoapSforceCom  Sublcass:Soap which contains login method
                partnerSoapSforceCom.LoginResult  partnerloginresult=mypartnersoap.login('shruti@eternussolutions.com','espl@123fgP8qxs4JAVV1S1mhYopfLMA');
                System.debug('partnerloginresult::::'+partnerloginresult);
                // Return type of login method is "partnerSoapSforceCom.LoginResult"
                system.debug('Generated session id is'+partnerloginresult.sessionId);  // Generating session id
                sessionidfetch=partnerloginresult.sessionId; // Storing session id          

                soapSforceComSchemasClassMyguestser.SessionHeader_element webservicesessionheader=new soapSforceComSchemasClassMyguestser.SessionHeader_element();
                webservicesessionheader.sessionId=sessionidfetch;  // Passing session id to session header element
                soapSforceComSchemasClassMyguestser.innerClass objInnerClass = new soapSforceComSchemasClassMyguestser.innerClass();
                objInnerClass.airLineCode = objRecord.airLineCode;
                objInnerClass.arrivalAirportCode=objRecord.arrivalAirportCode ;
                objInnerClass.arrivalTerminal=objRecord.arrivalTerminal;
                objInnerClass.arrivalTime=objRecord.arrivalTime;
                objInnerClass.buffer=objRecord.buffer;
                objInnerClass.departureAirportCode=objRecord.departureAirportCode;
                objInnerClass.departureTerminal=objRecord.departureTerminal;
                objInnerClass.departureTime=objRecord.departureTime;
                objInnerClass.flightNumber=objRecord.flightNumber;
                soapSforceComSchemasClassMyguestser.MyGuestServiceHandler objA=new soapSforceComSchemasClassMyguestser.MyGuestServiceHandler();
                objA.SessionHeader=webservicesessionheader; 
                retId = objA.createGuestRecord(objInnerClass);
                system.debug('Response is ---------> '+retId);

                if(retId.contains('Congralutations')) {
                    List<Guest__c> singleObj = [Select Validation__c,Error_Message__c From Guest__c Where ID=:id LIMIT 1];
                    List<Guest__c> newList = new List<Guest__c>();
                    for(Guest__c guestObj : singleObj){
                        guestObj.Validation__c = 'Completed';
                        guestObj.Error_Message__c = retId;
                        newList.add(guestObj);				
                    }
                    BooleanController.check = true;
                    update newList;			
                }
                else{
                    List<Guest__c> singleObj = [Select Validation__c,Error_Message__c From Guest__c Where ID=:id LIMIT 1];
                    List<Guest__c> newList = new List<Guest__c>();
                    for(Guest__c guestObj : singleObj){
                        guestObj.Validation__c = 'Pending';
                        guestObj.Error_Message__c = retId;
                        newList.add(guestObj);				
                    }
                    BooleanController.check = true;
                    update newList;
                }
            }
        }

    } 
    

}
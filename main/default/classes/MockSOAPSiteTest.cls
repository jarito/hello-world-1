@isTest
global with sharing class MockSOAPSiteTest implements WebServiceMock  {
    global String type;
	/**
	 * Here, the constructor value will decide which response is to be set
	 */
    global MockSOAPSiteTest(final String type){
             this.type = type;
    }

    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {

			System.debug('~~~~~~~~~~~~~~request:::::::'+request);
			System.debug('request: '+String.valueOf(request).split(':')[0]);  
			/**
			 * Response to be sent when all valid parameters are passed with buffer value zero
			 */ 
			if(type == 'A'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom1.login_element loginElem = (partnerSoapSforceCom1.login_element )request;
					partnerSoapSforceCom1.loginResponse_element loginResponce = new partnerSoapSforceCom1.loginResponse_element(); 
					partnerSoapSforceCom1.LoginResult LR= new partnerSoapSforceCom1.LoginResult(); 
		
					if(loginElem.username == 'shruti.kulkarni@eternussolutions.com')
					{             
						LR.sessionId = '00D280000016Hwz!ARgAQI4uwSSkAv6SdC.EBNvPOLutTnd3i9ye.p5fvjCv2SZvWpunItcjgx7lhfr.kaPL.FnRx9KbZRsajxCh0he5YgP.hL0f';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);
					} 
					else
					{
						LR.sessionId = '';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);    
					}  
				}
				else if(String.valueOf(request).split(':')[0] == 'createGuestRecord_element'){
					soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element obj = new soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element();
					List<soapSforceComSchemasClassFlightserv.innerClass> innerClassList = new List<soapSforceComSchemasClassFlightserv.innerClass>();
					soapSforceComSchemasClassFlightserv.innerClass innerClassObj = new soapSforceComSchemasClassFlightserv.innerClass();
					innerClassObj.airLineCode = 'BA213';
					innerClassObj.arrivalAirportCode = 'BOS';
					innerClassObj.arrivalTerminal = 'Terminal 1';
					innerClassObj.arrivalTime = datetime.newInstance(2018, 12, 13, 8, 52, 0) ;
					innerClassObj.departureAirportCode = 'LHR' ;
					innerClassObj.departureTerminal = 'Terminal 2';
					innerClassObj.departureTime = datetime.newInstance(2018, 12, 15, 8, 52, 0) ;
					innerClassObj.flightNumber = '2323' ;
					innerClassList.add(innerClassObj);

					obj.result = innerClassList;
					response.put('response_x', obj);
				}				
			}

			if(type == 'B'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom1.login_element loginElem = (partnerSoapSforceCom1.login_element )request;
					partnerSoapSforceCom1.loginResponse_element loginResponce = new partnerSoapSforceCom1.loginResponse_element(); 
					partnerSoapSforceCom1.LoginResult LR= new partnerSoapSforceCom1.LoginResult(); 
		
					if(loginElem.username == 'shruti.kulkarni@eternussolutions.com')
					{             
						LR.sessionId = '00D280000016Hwz!ARgAQI4uwSSkAv6SdC.EBNvPOLutTnd3i9ye.p5fvjCv2SZvWpunItcjgx7lhfr.kaPL.FnRx9KbZRsajxCh0he5YgP.hL0f';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);
					} 
					else
					{
						LR.sessionId = '';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);    
					}  
				}
				else if(String.valueOf(request).split(':')[0] == 'createGuestRecord_element'){
					soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element obj = new soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element();
					List<soapSforceComSchemasClassFlightserv.innerClass> innerClassList = new List<soapSforceComSchemasClassFlightserv.innerClass>();
					soapSforceComSchemasClassFlightserv.innerClass innerClassObj = new soapSforceComSchemasClassFlightserv.innerClass();
					innerClassObj.airLineCode = 'BA213';
					innerClassObj.arrivalAirportCode = 'BOS';
					innerClassObj.arrivalTerminal = 'Terminal 1';
					innerClassObj.arrivalTime = datetime.newInstance(2018, 12, 13, 8, 52, 0) ;
					innerClassObj.departureAirportCode = 'LHR' ;
					innerClassObj.departureTerminal = 'Terminal 2';
					innerClassObj.departureTime = datetime.newInstance(2018, 12, 15, 8, 52, 0) ;
					innerClassObj.flightNumber = '2323' ;
					innerClassList.add(innerClassObj);

					obj.result = innerClassList;
					response.put('response_x', obj);
				}				
			}

			if(type == 'C'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom1.login_element loginElem = (partnerSoapSforceCom1.login_element )request;
					partnerSoapSforceCom1.loginResponse_element loginResponce = new partnerSoapSforceCom1.loginResponse_element(); 
					partnerSoapSforceCom1.LoginResult LR= new partnerSoapSforceCom1.LoginResult(); 
		
					if(loginElem.username == 'shruti.kulkarni@eternussolutions.com')
					{             
						LR.sessionId = '00D280000016Hwz!ARgAQI4uwSSkAv6SdC.EBNvPOLutTnd3i9ye.p5fvjCv2SZvWpunItcjgx7lhfr.kaPL.FnRx9KbZRsajxCh0he5YgP.hL0f';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);
					} 
					else
					{
						LR.sessionId = '';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);    
					}  
				}
				else if(String.valueOf(request).split(':')[0] == 'createGuestRecord_element'){
					soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element obj = new soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element();
					List<soapSforceComSchemasClassFlightserv.innerClass> innerClassList = new List<soapSforceComSchemasClassFlightserv.innerClass>();
					soapSforceComSchemasClassFlightserv.innerClass innerClassObj = new soapSforceComSchemasClassFlightserv.innerClass();
					innerClassObj.airLineCode = 'BA213';
					innerClassObj.arrivalAirportCode = 'BOS';
					innerClassObj.arrivalTerminal = 'Terminal 1';
					innerClassObj.arrivalTime = datetime.newInstance(2018, 12, 13, 8, 52, 0) ;
					innerClassObj.departureAirportCode = 'LHR' ;
					innerClassObj.departureTerminal = 'Terminal 2';
					innerClassObj.departureTime = datetime.newInstance(2018, 12, 15, 8, 52, 0) ;
					innerClassObj.flightNumber = '2323' ;
					innerClassList.add(innerClassObj);

					soapSforceComSchemasClassFlightserv.innerClass innerClassObject = new soapSforceComSchemasClassFlightserv.innerClass();
					innerClassObject.airLineCode = 'BA2131';
					innerClassObject.arrivalAirportCode = 'BOS';
					innerClassObject.arrivalTerminal = 'Terminal 1';
					innerClassObject.arrivalTime = datetime.newInstance(2018, 12, 13, 8, 52, 0) ;
					innerClassObject.departureAirportCode = 'LHR' ;
					innerClassObject.departureTerminal = 'Terminal 2';
					innerClassObject.departureTime = datetime.newInstance(2018, 12, 15, 8, 52, 0) ;
					innerClassObject.flightNumber = '2323' ;
					innerClassList.add(innerClassObject);

					obj.result = innerClassList;
					response.put('response_x', obj);
				}				
			}

			if(type == 'D'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom1.login_element loginElem = (partnerSoapSforceCom1.login_element )request;
					partnerSoapSforceCom1.loginResponse_element loginResponce = new partnerSoapSforceCom1.loginResponse_element(); 
					partnerSoapSforceCom1.LoginResult LR= new partnerSoapSforceCom1.LoginResult(); 
		
					if(loginElem.username == 'shruti.kulkarni@eternussolutions.com')
					{             
						LR.sessionId = '00D280000016Hwz!ARgAQI4uwSSkAv6SdC.EBNvPOLutTnd3i9ye.p5fvjCv2SZvWpunItcjgx7lhfr.kaPL.FnRx9KbZRsajxCh0he5YgP.hL0f';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);
					} 
					else
					{
						LR.sessionId = '';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);    
					}  
				}
				else if(String.valueOf(request).split(':')[0] == 'createGuestRecord_element'){
					soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element obj = new soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element();
					List<soapSforceComSchemasClassFlightserv.innerClass> innerClassList = new List<soapSforceComSchemasClassFlightserv.innerClass>();
					soapSforceComSchemasClassFlightserv.innerClass innerClassObj = new soapSforceComSchemasClassFlightserv.innerClass();
					innerClassObj.airLineCode = 'BA213';
					innerClassObj.arrivalAirportCode = 'BOS';
					innerClassObj.arrivalTerminal = 'Terminal 1';
					innerClassObj.arrivalTime = datetime.newInstance(2018, 12, 13, 8, 52, 0) ;
					innerClassObj.departureAirportCode = 'LHR' ;
					innerClassObj.departureTerminal = 'Terminal 2';
					innerClassObj.departureTime = datetime.newInstance(2018, 12, 15, 8, 52, 0) ;
					innerClassObj.flightNumber = '2323' ;
					innerClassList.add(innerClassObj);

					soapSforceComSchemasClassFlightserv.innerClass innerClassObject = new soapSforceComSchemasClassFlightserv.innerClass();
					innerClassObject.airLineCode = 'BA2131';
					innerClassObject.arrivalAirportCode = 'BOS';
					innerClassObject.arrivalTerminal = 'Terminal 1';
					innerClassObject.arrivalTime = datetime.newInstance(2018, 12, 13, 8, 52, 0) ;
					innerClassObject.departureAirportCode = 'LHR' ;
					innerClassObject.departureTerminal = 'Terminal 2';
					innerClassObject.departureTime = datetime.newInstance(2018, 12, 15, 8, 52, 0) ;
					innerClassObject.flightNumber = '2323' ;
					innerClassList.add(innerClassObject);

					obj.result = innerClassList;
					response.put('response_x', obj);
				}				
			}

			if(type == 'E'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom1.login_element loginElem = (partnerSoapSforceCom1.login_element )request;
					partnerSoapSforceCom1.loginResponse_element loginResponce = new partnerSoapSforceCom1.loginResponse_element(); 
					partnerSoapSforceCom1.LoginResult LR= new partnerSoapSforceCom1.LoginResult(); 
		
					if(loginElem.username == 'shruti.kulkarni@eternussolutions.com')
					{             
						LR.sessionId = '00D280000016Hwz!ARgAQI4uwSSkAv6SdC.EBNvPOLutTnd3i9ye.p5fvjCv2SZvWpunItcjgx7lhfr.kaPL.FnRx9KbZRsajxCh0he5YgP.hL0f';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);
					} 
					else
					{
						LR.sessionId = '';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);    
					}  
				}
				else if(String.valueOf(request).split(':')[0] == 'createGuestRecord_element'){
					soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element obj = new soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element();
					List<soapSforceComSchemasClassFlightserv.innerClass> innerClassList = new List<soapSforceComSchemasClassFlightserv.innerClass>();
					soapSforceComSchemasClassFlightserv.innerClass innerClassObj = new soapSforceComSchemasClassFlightserv.innerClass();
					innerClassObj.airLineCode = 'BA213';
					innerClassObj.arrivalAirportCode = 'BOS';
					innerClassObj.arrivalTerminal = 'Terminal 1';
					innerClassObj.arrivalTime = datetime.newInstance(2018, 12, 13, 8, 52, 0) ;
					innerClassObj.departureAirportCode = 'LHR' ;
					innerClassObj.departureTerminal = 'Terminal 2';
					innerClassObj.departureTime = datetime.newInstance(2018, 12, 15, 8, 52, 0) ;
					innerClassObj.flightNumber = '2323' ;
					innerClassList.add(innerClassObj);

					obj.result = innerClassList;
					response.put('response_x', obj);
				}				
			}

			if(type == 'F'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom1.login_element loginElem = (partnerSoapSforceCom1.login_element )request;
					partnerSoapSforceCom1.loginResponse_element loginResponce = new partnerSoapSforceCom1.loginResponse_element(); 
					partnerSoapSforceCom1.LoginResult LR= new partnerSoapSforceCom1.LoginResult(); 
		
					if(loginElem.username == 'shruti.kulkarni@eternussolutions.com')
					{             
						LR.sessionId = '00D280000016Hwz!ARgAQI4uwSSkAv6SdC.EBNvPOLutTnd3i9ye.p5fvjCv2SZvWpunItcjgx7lhfr.kaPL.FnRx9KbZRsajxCh0he5YgP.hL0f';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);
					} 
					else
					{
						LR.sessionId = '';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);    
					}  
				}
				else if(String.valueOf(request).split(':')[0] == 'createGuestRecord_element'){
					soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element obj = new soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element();
					List<soapSforceComSchemasClassFlightserv.innerClass> innerClassList;
					soapSforceComSchemasClassFlightserv.innerClass innerClassObj ;

					obj.result = innerClassList;
					response.put('response_x', obj);
				}				
			}

			if(type == 'G'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom1.login_element loginElem = (partnerSoapSforceCom1.login_element )request;
					partnerSoapSforceCom1.loginResponse_element loginResponce = new partnerSoapSforceCom1.loginResponse_element(); 
					partnerSoapSforceCom1.LoginResult LR= new partnerSoapSforceCom1.LoginResult(); 
		
					if(loginElem.username == 'shruti.kulkarni@eternussolutions.com')
					{             
						LR.sessionId = '00D280000016Hwz!ARgAQI4uwSSkAv6SdC.EBNvPOLutTnd3i9ye.p5fvjCv2SZvWpunItcjgx7lhfr.kaPL.FnRx9KbZRsajxCh0he5YgP.hL0f';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);
					} 
					else
					{
						LR.sessionId = '';
						loginResponce.result = LR;
						response.put('response_x', loginResponce);    
					}  
				}
				else if(String.valueOf(request).split(':')[0] == 'createGuestRecord_element'){
					soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element obj = new soapSforceComSchemasClassFlightserv.createGuestRecordResponse_element();
					List<soapSforceComSchemasClassFlightserv.innerClass> innerClassList;
					soapSforceComSchemasClassFlightserv.innerClass innerClassObj ;

					obj.result = innerClassList;
					response.put('response_x', obj);
				}				
			}

		}

}
/**
 * Mock class for generating response 
 */
@isTest
global with sharing class MockGuestSoapUpdate  implements WebServiceMock  {
    public String type;
	/**
	 * Here, the constructor value will decide which response is to be set
	 */
    global MockGuestSoapUpdate(final String type){
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
					partnerSoapSforceCom.login_element loginElem = (partnerSoapSforceCom.login_element )request;
					partnerSoapSforceCom.loginResponse_element loginResponce = new partnerSoapSforceCom.loginResponse_element(); 
					partnerSoapSforceCom.LoginResult LR= new partnerSoapSforceCom.LoginResult(); 
		
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
					soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element obj = new soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element();
					obj.result = 'Congratulations  !! ';
					response.put('response_x', obj);
				}				
			}

			/**
			 * Response to be sent when all valid parameters are passed with some buffer value
			 */ 
			if(type == 'B'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom.login_element loginElem = (partnerSoapSforceCom.login_element )request;
					partnerSoapSforceCom.loginResponse_element loginResponce = new partnerSoapSforceCom.loginResponse_element(); 
					partnerSoapSforceCom.LoginResult LR= new partnerSoapSforceCom.LoginResult(); 
		
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
					soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element obj = new soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element();
					obj.result = 'Congratulations !! There are 2 Flights suiting your travel requirement';
					response.put('response_x', obj);
				}				
			}

			/**
			 * Response to be sent when wrong arrival terminal is entered
			 */ 
			if(type == 'C'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom.login_element loginElem = (partnerSoapSforceCom.login_element )request;
					partnerSoapSforceCom.loginResponse_element loginResponce = new partnerSoapSforceCom.loginResponse_element(); 
					partnerSoapSforceCom.LoginResult LR= new partnerSoapSforceCom.LoginResult(); 
		
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
					soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element obj = new soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element();
					obj.result = 'You have entered Invalid Arrival Terminal in Registration Form';
					response.put('response_x', obj);
				}				
			}

			/**
			 * Response to be sent when wrong Arrival AirportCode is entered
			 */ 
			if(type == 'D'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom.login_element loginElem = (partnerSoapSforceCom.login_element )request;
					partnerSoapSforceCom.loginResponse_element loginResponce = new partnerSoapSforceCom.loginResponse_element(); 
					partnerSoapSforceCom.LoginResult LR= new partnerSoapSforceCom.LoginResult(); 
		
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
					soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element obj = new soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element();
					obj.result = 'You have entered Invalid Arrival Airport Code in Registration Form';
					response.put('response_x', obj);
				}				
			}

			/**
			 * Response to be sent when wrong Departure Terminal & Departure Airport Code is entered
			 */
			if(type == 'E'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom.login_element loginElem = (partnerSoapSforceCom.login_element )request;
					partnerSoapSforceCom.loginResponse_element loginResponce = new partnerSoapSforceCom.loginResponse_element(); 
					partnerSoapSforceCom.LoginResult LR= new partnerSoapSforceCom.LoginResult(); 
		
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
					soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element obj = new soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element();
					String showMsg = 'You have entered Invalid Departure Terminal in Registration Form' + 'AND\n' + 'You have entered Invalid Departure Airport Code in Registration Form';
					obj.result = showMsg;
					response.put('response_x', obj);
				}				
			}

			/**
			 * Response to be sent when  Departure Terminal is Missing 
			 */
			if(type == 'F'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom.login_element loginElem = (partnerSoapSforceCom.login_element )request;
					partnerSoapSforceCom.loginResponse_element loginResponce = new partnerSoapSforceCom.loginResponse_element(); 
					partnerSoapSforceCom.LoginResult LR= new partnerSoapSforceCom.LoginResult(); 
		
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
					soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element obj = new soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element();
					obj.result = 'You have entered Invalid Departure Terminal in Registration Form';
					response.put('response_x', obj);
				}				
			}
				
			/**
			 * Response to be sent when All Related Fields are Missing 
			 */
			if(type == 'G'){
				if(String.valueOf(request).split(':')[0] == 'login_element')
				{ 
					partnerSoapSforceCom.login_element loginElem = (partnerSoapSforceCom.login_element )request;
					partnerSoapSforceCom.loginResponse_element loginResponce = new partnerSoapSforceCom.loginResponse_element(); 
					partnerSoapSforceCom.LoginResult LR= new partnerSoapSforceCom.LoginResult(); 
		
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
					soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element obj = new soapSforceComSchemasClassMyguestser.createGuestRecordResponse_element();
					obj.result = 'Incomplete Flight Details';
					response.put('response_x', obj);
				}				
			}

	}			
}
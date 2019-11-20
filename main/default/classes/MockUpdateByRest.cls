@isTest
global with sharing class MockUpdateByRest implements HttpCalloutMock{
    public String type;
	/**
	 * Here, the constructor value will decide which response is to be set
	 */
    global MockUpdateByRest(final String type){ 
             this.type = type;
    }

	global HTTPResponse respond(HTTPRequest req) {
		system.debug('Request ---> '+req);
		system.debug('EndPoint-----> '+(req.getEndpoint()));
		HttpResponse res ;
		if(type == 'A'){
			if(req.getEndpoint().endsWith('token')){
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				res.setBody('{"example":"test"}');
				res.setStatusCode(200);
			}
			else if(req.getEndpoint().endsWith('validateGuest')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString = 'Congralutations ! Your Registration has been Completed Successfully ';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody('{'+JSON.serialize(checkString)+'}');
				res.setStatusCode(200);
			}
		}

		if(type == 'B'){
			if(req.getEndpoint().endsWith('token')){
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				res.setBody('{"example":"test"}');
				res.setStatusCode(200);
			}
			else if(req.getEndpoint().endsWith('validateGuest')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString = 'Congratulations !! There are 2 Flights suiting your travel requirement';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody('{'+JSON.serialize(checkString)+'}');
				res.setStatusCode(200);
			}
		}

		if(type == 'C'){
			if(req.getEndpoint().endsWith('token')){
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				res.setBody('{"example":"test"}');
				res.setStatusCode(200);
			}
			else if(req.getEndpoint().endsWith('validateGuest')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString = 'You have entered Invalid Arrival Terminal in Registration Form';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody('{'+JSON.serialize(checkString)+'}');
				res.setStatusCode(500);
			}
		}

		if(type == 'D'){
			if(req.getEndpoint().endsWith('token')){
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				res.setBody('{"example":"test"}');
				res.setStatusCode(200);
			}
			else if(req.getEndpoint().endsWith('validateGuest')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString = 'You have entered Invalid Arrival Airport Code in Registration Form';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody('{'+JSON.serialize(checkString)+'}');
				res.setStatusCode(500);
			}
		}

		if(type == 'E'){
			if(req.getEndpoint().endsWith('token')){
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				res.setBody('{"example":"test"}');
				res.setStatusCode(200);
			}
			else if(req.getEndpoint().endsWith('validateGuest')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString = 'You have entered Invalid Departure Terminal in Registration Form  AND You have entered Invalid Departure Airport Code in Registration Form';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody('{'+JSON.serialize(checkString)+'}');
				res.setStatusCode(500);
			}
		}

		if(type == 'F'){
			if(req.getEndpoint().endsWith('token')){
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				res.setBody('{"example":"test"}');
				res.setStatusCode(200);
			}
			else if(req.getEndpoint().endsWith('validateGuest')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString = 'You have entered Invalid Departure Terminal in Registration Form';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody('{'+JSON.serialize(checkString)+'}');
				res.setStatusCode(500);
			}
		}

		if(type == 'G'){
			if(req.getEndpoint().endsWith('token')){
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				res.setBody('{"example":"test"}');
				res.setStatusCode(200);
			}
			else if(req.getEndpoint().endsWith('validateGuest')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString = 'Incomplete Flight Details';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody('{'+JSON.serialize(checkString)+'}');
				res.setStatusCode(500);
			}
		}

		return res;
	} 
}
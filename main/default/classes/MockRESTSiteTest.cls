@isTest
global with sharing class MockRESTSiteTest implements HTTPCalloutMock {
    public String type;
	/**
	 * Here, the constructor value will decide which response is to be set
	 */
    global MockRESTSiteTest(final String type){ 
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
			else if(req.getEndpoint().endsWith('getFlight')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString ='[{"flightNumber":"2323","departureTime":"2018-12-15T03:22:00.000Z","departureTerminal":"Terminal 2","departureAirportCode":"LHR","arrivalTime":"2018-12-13T03:22:00.000Z","arrivalTerminal":"Terminal 1","arrivalAirportCode":"BOS","airLineCode":"BA213"}]';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody(checkString);
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
			else if(req.getEndpoint().endsWith('getFlight')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString ='[{"flightNumber":"2323","departureTime":"2018-12-15T03:22:00.000Z","departureTerminal":"Terminal 2","departureAirportCode":"LHR","arrivalTime":"2018-12-13T03:22:00.000Z","arrivalTerminal":"Terminal 1","arrivalAirportCode":"BOS","airLineCode":"BA213"}]';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody(checkString);
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
			else if(req.getEndpoint().endsWith('getFlight')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString ='[{"flightNumber":"2323","departureTime":"2018-12-15T03:22:00.000Z","departureTerminal":"Terminal 2","departureAirportCode":"LHR","arrivalTime":"2018-12-13T03:22:00.000Z","arrivalTerminal":"Terminal 1","arrivalAirportCode":"BOS","airLineCode":"BA213"},{"flightNumber":"2323","departureTime":"2018-12-15T03:22:00.000Z","departureTerminal":"Terminal 2","departureAirportCode":"LHR","arrivalTime":"2018-12-13T03:10:00.000Z","arrivalTerminal":"Terminal 1","arrivalAirportCode":"BOS","airLineCode":"BA2131"}]';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody(checkString);
				res.setStatusCode(200);
			}
		}

		if(type == 'D'){
			if(req.getEndpoint().endsWith('token')){
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				res.setBody('{"example":"test"}');
				res.setStatusCode(200);
			}
			else if(req.getEndpoint().endsWith('getFlight')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString ='[{"flightNumber":"2323","departureTime":"2018-12-15T03:22:00.000Z","departureTerminal":"Terminal 2","departureAirportCode":"LHR","arrivalTime":"2018-12-13T03:22:00.000Z","arrivalTerminal":"Terminal 1","arrivalAirportCode":"BOS","airLineCode":"BA213"},{"flightNumber":"2323","departureTime":"2018-12-15T03:22:00.000Z","departureTerminal":"Terminal 2","departureAirportCode":"LHR","arrivalTime":"2018-12-13T03:10:00.000Z","arrivalTerminal":"Terminal 1","arrivalAirportCode":"BOS","airLineCode":"BA2131"}]';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody(checkString);
				res.setStatusCode(200);
			}
		}

		if(type == 'E'){
			if(req.getEndpoint().endsWith('token')){
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				res.setBody('{"example":"test"}');
				res.setStatusCode(200);
			}
			else if(req.getEndpoint().endsWith('getFlight')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString ='[{"flightNumber":"2323","departureTime":"2018-12-15T03:22:00.000Z","departureTerminal":"Terminal 2","departureAirportCode":"LHR","arrivalTime":"2018-12-13T03:22:00.000Z","arrivalTerminal":"Terminal 1","arrivalAirportCode":"BOS","airLineCode":"BA213"}]';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody(checkString);
				res.setStatusCode(200);
			}
		}

		if(type == 'F'){
			if(req.getEndpoint().endsWith('token')){
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				res.setBody('{"example":"test"}');
				res.setStatusCode(200);
			}
			else if(req.getEndpoint().endsWith('getFlight')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString ='Oops !! There are no Flights available fitting this Criteria';
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
			else if(req.getEndpoint().endsWith('getFlight')) {
				res = new HttpResponse();
				res.setHeader('Content-Type', 'application/json');
				String checkString ='Oops !! There are no Flights available fitting this Criteria';
				system.debug('Check this String---> '+JSON.serialize(checkString));
				res.setBody('{'+JSON.serialize(checkString)+'}');
				res.setStatusCode(500);
			}
		}

	return res;	
	}	
}
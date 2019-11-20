describe('The Lightning Data Service Testing', function(){
	
	describe("A test suite that tests the LDS", function() {
	
		var originalTimeout;

		beforeEach(function() {
			originalTimeout = jasmine.DEFAULT_TIMEOUT_INTERVAL;
			jasmine.DEFAULT_TIMEOUT_INTERVAL = 10000;
		});

		afterEach(function() {
		  jasmine.DEFAULT_TIMEOUT_INTERVAL = originalTimeout;
		});
	
		it('Spec 1:Check Application Event', function(done) {
			$T.createComponent("c:SearchResult", {} , true)
			.then(function(component){
				debugger;
				$T.fireApplicationEvent("c:RecordIdEvent", {"recordList":"[ {'FirstName': 'TestFirstName1'} ]"});			
				debugger;
				expect(component.get("v.message")).toBe("Application Event Fired");
				expect(document.getElementById("welcomeMSGId").textContent).toContain("Application Event Fired");
				
				done();
				
				}).catch(function(e) {
					done.fail(e);
				});
		});	
		
	});
	
});

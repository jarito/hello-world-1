describe("Lightning Testing Service", function(){
 
     
    /*** JUST CHECKING JASMINE ***/
 
    describe("A test suite that tests the obvious", function() {
      it("spec that verifies that true is true", function() {
        expect(true).toBe(true);
      });
      it("spec that verifies that false is false", function() {
        expect(false).toBe(false);
      });
    });
 
	describe("A test suite that tests the LDS", function() {
	
		it('Spec 1:Check Application Event', function(done) {
			$T.createComponent("c:CommunitySearchPage", {} , true)
			.then(function(component){

				$T.fireApplicationEvent("c:RecordIdEvent", {"recordList":"[ {'FirstName': 'TestFirstName1'} , {'FirstName': 'TestFirstName2'} , {'FirstName': 'TestFirstName3'} ]"});			
				
				expect(component.get("v.message")).toBe("Application Event Fired");
				
				done();
				
				}).catch(function(e) {
					done.fail(e);
				});
		});	
		
	}
	  
	
});
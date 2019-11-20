({
    validateOpportunityForm: function(component) {
        var validOpportunity = true;
		debugger;
         // Show error messages if required fields are blank
        var allValid = component.find('opportunityField').reduce(function (validFields, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validFields && inputCmp.get('v.validity').valid;
        }, true);
        
        if(allValid){
            return validOpportunity;
        }
	}
})
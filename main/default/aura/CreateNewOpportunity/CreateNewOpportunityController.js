({
    doInit: function(component, event, helper) {
        component.find("opportunityRecordCreator").getNewRecord(
            "Opportunity", // objectApiName
            null, // recordTypeId
            false, // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newOpportunity");
                var error = component.get("v.newOpportunityError");
                debugger;
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                }
                else {
                    console.log("Record template initialized: " + rec.apiName);
                }
            })
        );
    },
    handleSave: function(component, event, helper) {
        if(helper.validateOpportunityForm(component)) {
            //component.set("v.simpleNewOpportunity.Id", component.get("v.recordId"));
            component.set("v.simpleNewOpportunity.AccountId", component.get("v.recordId"));
            var tempId = component.get("v.recordId");
            var checkId = component.get("v.simpleNewOpportunity.AccountId");
            component.find("opportunityRecordCreator").saveRecord(function(saveResult) {
                if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
					debugger;
                    // Success! Prepare a toast UI message
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Opportunity Saved",
                        "message": "The new opportunity was created."
                    });
					component.find("popuplib").notifyClose();
                    // Update the UI: close panel, show toast, refresh account page
                    //$A.get("e.force:closeQuickAction").fire();
                    //resultsToast.fire();

                    // Reload the view so components not using force:recordData
                    // are updated
                    //$A.get("e.force:refreshView").fire();
                }
                else if (saveResult.state === "INCOMPLETE") {
                    console.log("User is offline, device doesn't support drafts.");
                }
                else if (saveResult.state === "ERROR") {
                    debugger;
                    console.log('Problem saving opportunity, error: ' +
                                 JSON.stringify(saveResult.error));
                }
                else {
                    console.log('Unknown problem, state: ' + saveResult.state +
                                ', error: ' + JSON.stringify(saveResult.error));
                }
            });
        }
    },

    handleCancel: function(component, event, helper) {
        component.find("popuplib").notifyClose();
    },
    handleAccountId: function(component, event, helper) {
        var accId = event.getParam("MyAccountId");
        debugger;
        component.set("v.accountId",accId);
        var temp = component.get("v.accountId");    
    }
})
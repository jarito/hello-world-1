({
	doInit : function(component, event, helper) {
		var recordId = $A.get("$SObjectType.CurrentUser.Id");
		debugger;
        component.set("v.recordId" , recordId);
        var checkId = component.get("v.recordId");               
        debugger;
        component.find("recordHandler").reloadRecord();
     /*   var action = component.get("c.getAccountId");
        action.setCallback(this, function(response) {
            var state = response.getState();
            debugger;
            if (state === "SUCCESS") {
                var result = action.getReturnValue();
                component.set("v.userId" , result.Id);
                var checkId = component.get("v.userId");
				component.set("v.recordId" , result.Id);
                var checkId = component.get("v.recordId");               
                debugger;
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                debugger;
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action); */
    },
    handleSelfEvent: function(component, event, helper) {
        helper.handleSelfEvent(component, event, helper);
    },
    
	handleRecordUpdated: function(component, event, helper) {
    var eventParams = event.getParams();
    if(eventParams.changeType === "CHANGED") {
        // get the fields that changed for this record
        var changedFields = eventParams.changedFields;
        console.log('Fields that are changed: ' + JSON.stringify(changedFields));
        // record is changed, so refresh the component (or other component logic)
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": "Saved",
            "message": "The record was updated."
        });
        resultsToast.fire();

    } else if(eventParams.changeType === "LOADED") {
        console.log("account loaded:::::" + component.get("v.simpleRecord"));
        // record is loaded in the cache
    } else if(eventParams.changeType === "REMOVED") {
        // record is deleted and removed from the cache
    } else if(eventParams.changeType === "ERROR") {
        // there’s an error while loading, saving or deleting the record
    }
}
})
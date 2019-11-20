({
	doInit : function(component, event, helper) {
		//First Server Call
        var action1 = component.get("c.getAccounts");
        debugger;
        
        $A.enqueueAction(action1);
        
        action1.setCallback(this, function(response) {
            var state = response.getState();
            debugger;
            if (state === "SUCCESS") {
                // Alert the user with the value returned 
                // from the server
                var checkList = response.getReturnValue();
                component.set("v.accountList", checkList);
                var accList = component.get("v.accountList");
                debugger;
               
                //Second Server Call
                var action2 = component.get("c.getContacts");
        		debugger;
                $A.enqueueAction(action2);
                
                action2.setCallback(this, function(response) {
                    if (state === "SUCCESS") {
                        var checkListContact = response.getReturnValue();
                        component.set("v.contactList", checkListContact);
                        var contactList = component.get("v.contactList");
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
        
        
	}
    
})
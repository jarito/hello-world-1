({
	doInit : function(component, event, helper) {
        
        console.log("in doInit");
        
        var action = component.get('c.getContactId');
        action.setParams({ idCaseNum : component.get("v.recordId") });
  
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            console.log("state is: " + state);
             
            //debugger;
            if (state === "SUCCESS") {
                var temp = response.getReturnValue();
                //Set Contact Id related to the Case as recordId
                component.set('v.recordId' , temp);
                 
                console.log("v.recordId is: " + component.get("v.recordId"));
                 
                helper.doInit(component, event, helper);
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                //debugger;
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
        $A.enqueueAction(action);
        
    
        //component.set('v.recordId' , '003P000001CDqawIAD');
        /**
         * Assign case record Id to attribute named caseRecordId 
         **/
        /*component.set('v.caseRecordId',component.get("v.recordId"));
        var checkCaseId = component.get("v.caseRecordId");
        debugger;*/
        
        //helper.doInit(component, event, helper);
        },
        editContactRecord : function(component, event, helper) {
        	helper.editContactRecord(component, event, helper);
        },
        myAction : function(component, event, helper) {
            var toastEvent = $A.get("e.force:showToast"); 
            toastEvent.setParams({ 
                "message": "Your record  updated successfully !", 
                "type": "success" 
            }); 
            toastEvent.fire();
        }
})
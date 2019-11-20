({
    doInit : function(component, event, helper) {
		//Server call to fetch the contact related to the Case
        
        console.log("In helper, doInit");
        
        //debugger;
        var action = component.get('c.getFieldSetMember');
        action.setParams({ strFieldSetName : component.get("v.fieldsetName") ,
                          numColumns : component.get("v.numOfColumns") });
        
        //debugger;
        action.setCallback(this, function(response) {
            var state = response.getState();
            //debugger;
            if (state === "SUCCESS") {
                var temp = response.getReturnValue();
                //debugger;
                var parsed = JSON.parse(temp);
                //debugger;
                console.log('temp >>>> ', parsed);
                var fieldSetList = component.get('v.fieldsList');
                for(var i = 0; i < parsed.length ; i++){
                    fieldSetList.push(parsed[i].fieldAPIName);
                }                
               
                component.set('v.fieldsList',fieldSetList);
                console.log('fieldSetList >>> ', fieldSetList);
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
    }, 
    editContactRecord : function(component, event, helper) {
		var checkId = event.getSource().get('v.value');
        debugger;
        //Creating a new component dynamically
        $A.createComponent("c:ContactEditModal", { recordId : checkId },
                           function(content, status, errorMessage) {
                               if (status === "SUCCESS") {
                                   component.find('overlayLib').showCustomModal({
                                       header: "Edit Contact",
                                       body: content, 
                                       showCloseButton: true,
                                       cssClass: "mymodal",
                                   })
                               }
                               else if (status === "ERROR") {
                                    console.log("Error: " + errorMessage);
                                    // Show error message
                               }
                               else if (status === "INCOMPLETE") {
                                console.log("No response from server or client is offline.")
                                // Show offline error
                                }                               
                           });    
	}

})
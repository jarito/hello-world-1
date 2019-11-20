({
    handleEditProfile : function(component, event, helper) {
		var contactID = event.target.value;
        debugger;
        var contactIDcheck = event.getSource().get('v.value');
        debugger;
        //Creating a new component dynamically
        $A.createComponent("c:ContactEditModal", { recordId : event.getSource().get('v.value') },
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   component.find('overlayLib').showCustomModal({
                                       header: "Contact Edit",
                                       body: content, 
                                       showCloseButton: true,
                                       cssClass: "mymodal",
                                       closeCallback: function() {
                                            var recordId = $A.get("$SObjectType.CurrentUser.Id");
											debugger;
                                           	component.set("v.recordId" , recordId);
                                           	component.find("recordHandler").reloadRecord();
                                           	
                                           	
                                           /*var action = component.get('c.getCurrentUser');
                                            action.setCallback(this,function(response){
                                                var state = response.getState();
                                                debugger;
                                                if (state === "SUCCESS") {
                                                    var result = action.getReturnValue();
                                                    component.set("v.item" , result);
                                                    var checkItem = component.get("v.item");
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
                                                    } 
                                                    else {
                                                        console.log("Unknown error");
                                                    }
                                            	}
                                            });
                                            $A.enqueueAction(action);*/
                                       }
                                  })
                               }                               
                           });        
    },
    handleRecordUpdated : function(component, event, helper) {
        var eventParams = event.getParams();
        debugger;
        if(eventParams.changeType === "LOADED") {
           // record is loaded (render other component which needs record data value)
            console.log("Record is loaded successfully.");
            console.log("You loaded a record in " + 
            component.get("v.simpleRecord.Name"));
            component.set("v.logMessage", "Record has been loaded.");
            debugger;
            
        } else if(eventParams.changeType === "CHANGED") {
            console.log('Reached Here..');
            debugger;
            
            // record is changed
        } else if(eventParams.changeType === "REMOVED") {
            // record is deleted
        } else if(eventParams.changeType === "ERROR") {
            // there’s an error while loading, saving, or deleting the record
        } 
        
    },  
    
    /**
     * Following methods are written for testing purpose only
     */
    getNewRecord : function(component, event, helper) {
        var recordDataCreate = component.find("recordDataCreate");
        // call getNewRecord of force:recordData
        recordDataCreate.getNewRecord("Account", null, true, function() {
            // once we have  the record template for new record for given entity then update and save the record
            var record = component.get('v.recordTemplate');
            record.fields.Name.value = "ADSTestAccount" + (Math.round(Math.random()*10000) + 1);
            record.fields.Industry.value = "Banking";
            record.fields.Type.value = "Prospect";
            recordDataCreate.saveRecord(function(saveResult) {
                if (saveResult.state === 'SUCCESS') {
                    component.set("v._recordId", saveResult.recordId);
                    component.set('v.fetch', "true"); // this will load the Account record using force:recordData and renders it
                    component.set("v.isCallbackCalled", true);
                }
            });
        });
    },

    reloadRecord : function(component, event, helper) {
        component.find("recordDataCmp").reloadRecord(false, function(){
            // verify record is reloaded. callback will be called after recordUpdated event is fired
            component.set("v.isCallbackCalled", true);
        });
    },
    handleFilterChange: function(component, event, helper) {
        var filters = event.getParam('message');
        component.set('v.msg' , filters);
        
        var action = component.get("c.getSkillSet");
        action.setCallback(this, function(response) {
            var state = response.getState();
            debugger;
            if (state === "SUCCESS") {
                var result = action.getReturnValue();
                component.set("v.skillSet" , result);
                var checkSkillSet = component.get("v.skillSet");
                //component.set("v.userId" , result.Id);
                //var checkId = component.get("v.userId");
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
        $A.enqueueAction(action);
    },    
})
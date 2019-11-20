({
	doInit : function(component, event, helper) {
       	var recordId = $A.get("$SObjectType.CurrentUser.Id");
        component.set("v.recordId" , recordId);
        
        var value = component.get("v.counter");
        value = value + 1;
        component.set("v.counter", value);
        
        var checkId = component.get("v.recordId");               
        debugger;
        
        var checkUrl = window.location.href;
        console.log("URL on Load -->"+checkUrl);
		var keyVal = checkUrl.split('?')[1];
        if(keyVal){
            console.log("Redirected Profile..");
            var id = keyVal.split('=')[1];
            component.set("v.userId" , id)
            debugger;
            component.set("v.recordId" , id)
            var currentUser = component.get("v.ShowCurrentUser"); 
            component.set("v.ShowCurrentUser" , "false");
            var currentUser = component.get("v.ShowOtherUser");
            component.set("v.ShowOtherUser" , "true");
            debugger;
        }
        else{
            console.log("On load default profile..");
        }

        var recordId = component.get("v.recordId");
        debugger;
        if(recordId == id){
        	alert("Current User logged In .. !");
        }
        
        component.find("recordHandler").reloadRecord();
        
	/*	var action = component.get("c.getCurrentUser");
        action.setCallback(this, function(response) {
            var state = response.getState();
            debugger;
            if (state === "SUCCESS") {
                var result = action.getReturnValue();
                component.set("v.item" , result);
                var checkItem = component.get("v.item");
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
        $A.enqueueAction(action);*/
    },
    handleEditProfile : function(component, event, helper) {
        helper.handleEditProfile(component, event, helper);
    },
    handleRecordUpdated: function(component, event, helper) {
        helper.handleRecordUpdated(component, event, helper);
    },
    onChange: function(component, event, helper) {
        var checkName =  component.get("{!v.simpleRecord.Name}");
        debugger;
    },
    getNewRecord: function(component, event, helper) {
         helper.getNewRecord(component, event, helper);
    },
    reloadRecord: function(component, event, helper) {
         helper.reloadRecord(component, event, helper);
    },
    handleFilterChange: function(component, event, helper) {
 		helper.handleFilterChange(component, event, helper);
    },     
})
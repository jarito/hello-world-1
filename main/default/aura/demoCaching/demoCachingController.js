({
	getContacts : function(component, event, helper) {
        component.set("v.Columns", [
            {label:"LastName", fieldName:"LastName", type:"text"}
        ]);
		var action = component.get("c.getContactList");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var temp = response.getReturnValue();
                component.set("v.allContacts" , temp);
                var listCon = component.get("v.allContacts");
            }
        });
        $A.enqueueAction(action);
    },
    handleClick : function(component, event, helper) {
        helper.handleClick(component, event, helper);
    },
    handleRecordUpdated : function(component, event, helper) {
        helper.handleRecordUpdated(component, event, helper);
    }
})
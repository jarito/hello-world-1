({
	handleClick : function(component, event, helper) {
        var cmpEvent = component.getEvent("cmpEvent");
        cmpEvent.setParams({"message" : "Hello From PARENT !!"});
        debugger;
        cmpEvent.fire();
    },
    handleComponentEvent : function(component, event) {
        var message = event.getParam("message");
        component.set("v.parentMsg", message);
        var msg = component.get("v.parentMsg");
        debugger;
    }
})
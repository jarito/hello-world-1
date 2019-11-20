({
	handleClick : function(component, event, helper) {
        var cmpEvent = component.getEvent("cmpEvent");
        cmpEvent.setParams({"message" : "Hello From SUPER PARENT !!"});
        cmpEvent.fire();
    },
    handleComponentEvent : function(component, event) {
        var message = event.getParam("message");
        component.set("v.superParentMsg", message);
        var msg = component.get("v.superParentMsg");
        debugger;
    } 
})
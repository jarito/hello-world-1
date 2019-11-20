({
	handleClick : function(component, event, helper) {
        var cmpEvent = component.getEvent("cmpEvent");
        cmpEvent.setParams({"message" : "Hello From CHILD !!"});
        cmpEvent.fire();
    },
    handleComponentEvent : function(component, event) {
        var message = event.getParam("message");
        component.set("v.childMsg", message);
        var msg = component.get("v.childMsg");
        debugger;
    }    
})
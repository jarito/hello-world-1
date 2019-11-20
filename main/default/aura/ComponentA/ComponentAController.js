({
	updateA : function(component, event, helper) {
		component.set("v.messageA","Component A updated");
	},
    handleEvent : function(component, event, helper) {
        var msg = event.getParam("CompEvent");
        //debugger;
  		component.set("v.message",msg);
        console.log('message in A---->'+msg);
	}
})
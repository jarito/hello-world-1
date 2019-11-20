({
	updateB : function(component, event, helper) {
		component.set("v.messageB","Component B updated");		
	},
    handleEventB : function(component, event, helper) {
        var msg = event.getParam("CompEvent");
        //debugger;
  		component.set("v.messageNew",msg);
        console.log('message in B---->'+msg);
	}
})
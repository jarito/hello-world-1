({
	handleEventAppG : function(component, event, helper) {
        var msg = event.getParam("AppEvent");
        //debugger;
  		//component.set("v.messageNew",msg);
        console.log('message in G APPLICATION EVENT---->'+msg);
	}
})
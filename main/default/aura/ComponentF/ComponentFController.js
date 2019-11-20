({
    fireEvent : function(component, event, helper){
        var appEvent = component.getEvent("testComponent");
        appEvent.setParams({"CompEvent" : "Fired !!!"});
        appEvent.fire();
        let button = event.getSource();
        button.set('v.disabled',true);
        console.log('Fired !!');
    },
	handleEventAppF : function(component, event, helper) {
        var msg = event.getParam("AppEvent");
        //debugger;
  		//component.set("v.messageNew",msg);
        console.log('message in F APPLICATION EVENT---->'+msg);
	} 
})
({
	handleEventD : function(component, event, helper) {
        var msg = event.getParam("CompEvent");
        //debugger;
  		component.set("v.messageNew",msg);
        console.log('message in D---->'+msg);	
        //event.stopPropagation();

	},
    fireEventApp : function(component, event, helper){
    	var appEvent = $A.get("e.c:TestEvent");
        appEvent.setParams({"AppEvent" : "Fired Application Event !!!"});
        appEvent.fire();
        let button = event.getSource();
        button.set('v.disabled',true);
        console.log('Fired AppEvt !!');
    }    
})
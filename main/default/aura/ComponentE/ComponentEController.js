({
	handleEventE : function(component, event, helper) {
        var msg = event.getParam("CompEvent");
        //debugger; 
  		component.set("v.messageNew",msg);
        console.log('message in E---->'+msg);		
	},
	handleEventAppE : function(component, event, helper) {
        var msg = event.getParam("AppEvent");
        //debugger;
  		//component.set("v.messageNew",msg);
        console.log('message in E APPLICATION EVENT---->'+msg);
	}   
})
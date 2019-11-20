({
	updateC : function(component, event, helper) {
		component.set("v.messageC" , "C is Updated");
	},
    handleEventC : function(component, event, helper) {
        var msg = event.getParam("CompEvent");
        //debugger;
  		component.set("v.messageNew",msg);
        console.log('message in C---->'+msg);
	},
	handleEventAppC : function(component, event, helper) {
        var msg = event.getParam("AppEvent");
        //debugger;
  		//component.set("v.messageNew",msg);
        console.log('message in E APPLICATION EVENT---->'+msg);
	} 
})
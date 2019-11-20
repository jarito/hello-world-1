({
	doInit : function(component, event, helper) {
		//debugger;
        var tmp = component.get("v.recordId")
        console.log('******',tmp); 
        component.set("v.currentRecordId",tmp);   
        var rec = component.get("v.currentRecordId")
        console.log('***record id***',rec);
    },
    
    
})
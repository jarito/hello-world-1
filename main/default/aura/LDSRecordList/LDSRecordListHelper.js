({
    handleRecordUpdated : function(component, event, helper) {
        var eventParams = event.getParams();
        var recId = component.get('v.recordId');
        debugger;
        
        if(eventParams.changeType === "LOADED") {
           // record is loaded (render other component which needs record data value)
            console.log("Record is loaded successfully.");
            console.log("You loaded a record in " + 
                        component.get("v.simpleRecord.Industry"));
        } else if(eventParams.changeType === "CHANGED") {
            var action = component.get("v.record");
            debugger;
            var checkStageName = component.get("v.record.StageName");
            debugger;
            component.find("recordHandler").reloadRecord();
            console.log('Reached Here..');
            debugger;
            // record is changed
        } else if(eventParams.changeType === "REMOVED") {
            // record is deleted
        } else if(eventParams.changeType === "ERROR") {
            // there’s an error while loading, saving, or deleting the record
        } 
        
    },
    getRecordId : function(component, event, helper) {
        var ch = event.target.tagName;
        var opportunityId = event.target.getAttribute('id');
        debugger;
        
        /* Event fired to send opportunity id to generic component named MyRecordDetails, to display 
         * opportunity details
         * This event should be handled by second(right side) instance of component MyRecordDetails */ 
        var applicationEvent = $A.get("e.c:MyRecordDetailEvent");
        applicationEvent.setParams({"recordId" : opportunityId});
        applicationEvent.setParams({"objectName" : "Opportunity"});
        applicationEvent.fire();
        
        /* Event fired to send opportunity id to generic component(this component) named MyRecords, to display 
         * orders related to opportunity which user has clicked, in the second instance of this component(right side)
         * This event should be handled by second(right side) instance of the same(this) component MyRecords */         
        var appEvent = $A.get("e.c:sObjectEvent");
        appEvent.setParams({"sObjectName" : "Opportunity"});
        appEvent.setParams({"opportunityId" : opportunityId});
        appEvent.fire();
    }, 
    getOrderRecordId : function(component, event, helper) {
        var orderId = event.target.getAttribute('id');
        debugger;
       /* Event fired to send opportunity id to generic component named MyRecordDetails, to display 
        * opportunity details
        * This event should be handled by second(right side) instance of component MyRecordDetails */ 
        var applicationEvent = $A.get("e.c:MyRecordDetailEvent");
        applicationEvent.setParams({"recordId" : orderId});
        applicationEvent.setParams({"objectName" : "Order"});
        applicationEvent.fire();

        //Event fired to send Id to the same component instance on rightside, to display list of Order items
        var appEvent = $A.get("e.c:sObjectEvent");
        appEvent.setParams({"sObjectName" : "Order"});
        appEvent.setParams({"opportunityId" : orderId});
        appEvent.fire();
	}
})
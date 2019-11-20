({
	handleOpportunityId : function(component, event, helper) {
		var oppId = event.getParam("opportunityId");
        debugger;
        component.set("v.opportunityId",oppId);
        var temp = component.get("v.opportunityId");
        component.find("recordHandler").reloadRecord();
	},
	handleRecordUpdated : function(component, event, helper) {
		var eventParams = event.getParams();
        var recId = component.get('v.opportunityId');
        debugger;	 
        if(eventParams.changeType === "LOADED") {
           // record is loaded (render other component which needs record data value)
            console.log("Record is loaded successfully.");
            console.log("You loaded a record in " + 
                        component.get("v.simpleRecord.Industry"));
        } else if(eventParams.changeType === "CHANGED") {
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
	editOpportunity : function(component, event, helper) {
		var opportunityID = component.get("v.opportunityId");
        var recordId = component.get("v.opportunityId");
        debugger;
        //Creating a new component dynamically
        $A.createComponent("c:OpportunityEdit", { recordId : event.getSource().get('v.value') },
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   component.find('overlayLib').showCustomModal({
                                       header: "Opportunity  Edit",
                                       body: content, 
                                       showCloseButton: true, 
                                       cssClass: "mymodal",
                                       closeCallback: function() {
                                            var applicationEvent = $A.get("e.c:SampleEvent");
											applicationEvent.setParams({"message" : "Hello"})
    										applicationEvent.fire();
                                       }                                       
                                   })
                               }                               
                           });		
	},
	closeOpportunity : function(component, event, helper) {
		//component.find("overlayLib").notifyClose();
        //component.find("recordHandler").notifyClose();
        var modal = component.find("exampleModal");
        $A.util.removeClass(modal, 'hideDiv');
	}     
})
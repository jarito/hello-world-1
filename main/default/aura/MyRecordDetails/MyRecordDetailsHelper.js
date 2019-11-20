({
    editAccount : function(component, event, helper) {
		var accountID = component.get("v.recordId");
        component.set("v.selectedAccountId",accountID);
        debugger;
        //Creating a new component dynamically
        $A.createComponent("c:AccountEditModal", { recordId : event.getSource().get('v.value') },
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   component.find('overlayLib').showCustomModal({
                                       header: "Edit Account",
                                       body: content, 
                                       showCloseButton: true,
                                       cssClass: "mymodal",
                                       
                                   })
                               }                               
                           });        
	},	
	editOpportunity : function(component, event, helper) {
		var opportunityID = component.get("v.recordId");
        //var recordId = component.get("v.opportunityId");
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
	editOrder : function(component, event, helper) {
		var orderId = component.get("v.recordId");
        //var recordId = component.get("v.opportunityId");
        debugger;
        //Creating a new component dynamically
        $A.createComponent("c:MyOrderEdit", { recordId : event.getSource().get('v.value') },
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
											//This event is handled in component named MyRecords
                                       }                                       
                                   })
                               }                               
                           });		
	},
	acceptId : function(component, event, helper) {
		var recordId = event.getParam("recordId");
		var objName = event.getParam("objectName");
		//Object Name according to the design attribute selected
		var objectName = component.get("v.objectName");
		debugger;
		//var trial = component.get("v.trial");
		/*if(objName == 'Account'){
			component.set('v.trial' , 'Account');
		}*/

		if(objectName == 'Account' && objName == 'Account'){
			component.set("v.recordId",recordId);
			component.set("v.currentObject",objName);
			component.set("v.selectedAccountId",recordId);
			var recordId = component.get("v.recordId");	
			var checkObject = component.get("v.currentObject");
			debugger;
			//component.set("v.trial" , " done.."  );
			//var trial = component.get("v.trial");
			debugger;
			component.find("recordHandler").reloadRecord();
		}
		else if(objectName == 'Opportunity'){
			component.set("v.recordId","");
			if(objName == 'Opportunity'){
				component.set("v.recordId",recordId);
				component.set("v.currentObject",objName);
				var recordId = component.get("v.recordId");	
				var checkObject = component.get("v.currentObject");
				debugger;
				component.find("recordHandler").reloadRecord();
			}
			else if(objName == 'Order'){
				component.set("v.recordId",recordId);
				component.set("v.currentObject",objName);
				var recordId = component.get("v.recordId");	
				var checkObject = component.get("v.currentObject");
				debugger;
				component.find("recordHandler").reloadRecord();
			}			
		}		
	},
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
            component.find("recordHandler").reloadRecord();
            console.log('Reached Here..');
            debugger;
            // record is changed
        } else if(eventParams.changeType === "REMOVED") {
            // record is deleted
        } else if(eventParams.changeType === "ERROR") {
            // there’s an error while loading, saving, or deleting the record
        } 
        
    }
})
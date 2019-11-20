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
                                       header: "Account  Edit",
                                       body: content, 
                                       showCloseButton: true,
                                       cssClass: "mymodal",
                                       
                                   })
                               }                               
                           });        
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
        
    },
    acceptId : function(component, event, helper) {
        var params = event.getParam('arguments');
        var accId = params.recordId;  
        debugger;
		component.set("v.recordId", accId);
        /* Referred the link below related to reloadRecord() */
        /* https://salesforce.stackexchange.com/questions/198797/in-forcerecorddata-not-able-to-set-its-recordid-attribute-from-client-side-c/238798 */
		component.find("recordHandler").reloadRecord();        
    },
})
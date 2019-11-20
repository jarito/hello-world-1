({
    handleClick : function(component, event, helper) {
        var recordId = event.getSource().get('v.value');
        debugger; 
        //Creating a new component dynamically
        $A.createComponent("c:ContactEditModal", { recordId : event.getSource().get('v.value') },
                           function(content, status) {
                               var checkContent = content;
                               debugger;
                               if (status === "SUCCESS") {
                                    component.find('overlayLib').showCustomModal({
                                        header: "Contact  Edit",
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
        
    }
})
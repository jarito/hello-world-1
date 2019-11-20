({
    handleSaveRecord: function(component, event, helper) {
        component.find("recordHandler").saveRecord($A.getCallback(function(saveResult) {
            // NOTE: If you want a specific behavior(an action or UI behavior) when this action is successful 
            // then handle that in a callback (generic logic when record is changed should be handled in recordUpdated event handler)
            var st = saveResult.state; 
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                console.log("Record changes are saved successfully.....");
                // handle component related logic in event handler
            } else if (saveResult.state === "INCOMPLETE") {
                console.log("User is offline, device doesn't support drafts.....");
            } else if (saveResult.state === "ERROR") {
                console.log('Problem saving record, error:--- ' + JSON.stringify(saveResult.error));
            } else {
                console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
            }
        }));

        var temp = component.find("hideThis");
        $A.util.addClass(temp, 'hideDiv');
        debugger;
    },
  handleRecordUpdated : function(component, event, helper) {

    var changeType = event.getParams().changeType;

    if (changeType === "ERROR") { /*handle error; do this first!..... */ }
    else if (changeType === "LOADED") { /* handle record load */ }
    else if (changeType === "REMOVED") { /*handle record removal*/  }
    else if (changeType === "CHANGED") { 
      // handle record change; reloadRecord will cause you to lose your current record, including any changes you’ve made 
      component.find("recordHandler").reloadRecord();}
    }
})
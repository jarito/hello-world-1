({
	fellowRecordList : function(component, event, helper) {
		var picklist1 = component.get("v.picklist1");
        var picklist2 = component.get("v.picklist2");
        var picklist3 = component.get("v.picklist3");
        var componentList = component.get("v.componentList");
        debugger;
        var checkobj = component.get("v.defaultFilter.ValueEntered");
        debugger;
        picklist3.push(checkobj);
        component.set("v.picklist3" , picklist3)
        var compList = component.get("v.picklist3");
        debugger;
        var picklist3 = component.get("v.picklist3");
        debugger;
        if(componentList.length >= 1){
            for(var i = 0 ; i < componentList.length ; i++){
               picklist3.push(componentList[i].ValueEntered); 
            }
        
            component.set("v.picklist3" , picklist3)
            var componentList = component.get("v.picklist3");
            debugger;
        }
        
        var action = component.get("c.fellowRecordsListApex");
        action.setParams({"picklist1" : picklist1,
                          "picklist2" : picklist2,
                          "picklist3" : picklist3
                         });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                alert("Response Received !!");
				var resultList = response.getReturnValue();
                var appEvent = $A.get("e.c:RecordIdEvent");
				appEvent.setParams({"recordList" : resultList})
    			appEvent.fire();
                component.set("v.message" , "Application Event Fired");
                var checkMsg = component.get("v.message");
                debugger;
            }
            else if (state === "INCOMPLETE") {
            }
            else if (state === "ERROR") {
            	var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                                    errors[0].message);
                    }
                } 
                else{
                        console.log("Unknown error");
                    }
            }
        });
        $A.enqueueAction(action);
    }
})
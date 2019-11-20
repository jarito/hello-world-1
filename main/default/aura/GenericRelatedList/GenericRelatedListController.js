({
	init : function(component, event, helper) {        
        
        var action = component.get('c.getContactId');
        action.setParams({ idCaseNum : component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var temp = response.getReturnValue();
                //Set Contact Id related to the Case as recordId
                component.set('v.contactId' , temp);
                helper.handleRelatedListContent(component, event, helper);
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
        
        //Get label from ObjectName selected from design attribute
        var objectName = component.get('v.objectName');
        var label = objectName.replace('__r' , '');
        var labelLowerCase = label.toLowerCase().slice(0, -1);
        component.set('v.objectIconName' , labelLowerCase);
	
	},	
	handleCreateNewCase : function(component, event, helper) {
		helper.handleCreateNewCase(component, event, helper);
	},
    handleViewall : function(component, event, helper){
        helper.handleViewall(component, event, helper);
    },
    updateColumnSorting: function (component, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        // assign the latest attribute with the sorted column fieldName and sorted direction
        component.set("v.fieldNameForSort", fieldName);
        component.set("v.order", sortDirection);
        helper.sortData(component, fieldName, sortDirection);
    },
})
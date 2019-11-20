({
	doInit : function(component, event, helper) {
        console.log('init...');
        var action = component.get('c.getSelectedRecords');
        action.setParams({recId : recId});
        action.setCallback(this,function(response){
            var state = response.getState();
            debugger;
            if(response.getState() === 'SUCCESS'){
            var retObj = response.getReturnValue();
                debugger;
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                debugger;
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
	},
})
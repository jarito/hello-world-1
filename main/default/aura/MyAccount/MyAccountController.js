({
   doInit : function(component, event, helper){
     /*    component.set("v.Columns", [
            {label:"Name", fieldName:"Name", type:"text"},
            {label:"Website", fieldName:"Website", type:"url"},
            {label:"City", fieldName:"BillingCity", type:"string"}
        ]); 
        console.log('Columns-->'+component.get("v.Columns"));
        var action = component.get("c.getAccounts");
        debugger;
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS"){
                var temp = response.getReturnValue();
                debugger;
                component.set("v.accountList" , temp );
            }
         });
         $A.enqueueAction(action);
   */ },
    doSearch : function(component, event, helper) {
		var inputCmp = component.find("inputCmp");
        //debugger;
        var inputVal = inputCmp.get("v.value");
        //debugger;
        component.set("v.accountName" , inputVal);
        //debugger;
	},
    getAccounts : function(component, event, helper) {
        helper.getAccounts(component, event, helper);
    },
    itemSelected : function(component, event, helper) {
        helper.itemSelected(component, event, helper);
    },
    handleRecordUpdated : function(component, event, helper) {
        helper.handleRecordUpdated(component, event, helper);
    },
    editAccount : function(component, event, helper) {
        helper.editAccount(component, event, helper);
    }

    

})
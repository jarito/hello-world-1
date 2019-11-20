({
	doInit : function(component, event, helper) {
		var action = component.get("c.getAccounts");
        action.setCallback(this,function(response){
            var state = response.getState();
            var temp = response.getReturnValue();
            //debugger;
            component.set("v.accountList" , temp);
            var checkList = component.get("v.accountList");
			//debugger;
        });
        $A.enqueueAction(action);
	},
    callAuraMethod : function(component, event, helper) {
            var checkList = component.get("v.accountList");
        	console.log('111------>'+checkList);
            var parentCmp = component.find("childCmp");
       		console.log('211------>'+parentCmp);
            //debugger;
            parentCmp.demoMethod(checkList);
 	}
})
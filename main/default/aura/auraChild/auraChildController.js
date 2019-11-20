({
	childMethod : function(component, event, helper) {
        component.set("v.Columns", [
            {label:"Name", fieldName:"Name", type:"text"},
            {label:"Industry", fieldName:"Industry", type:"Picklist"},
            {label:"Website", fieldName:"Website", type:"url"}
        ]);
		var params = event.getParam('arguments');
        var listAccounts = params.accountList;
        //debugger;
        component.set("v.listOfAccounts" , listAccounts);
        var checkList = component.get("v.listOfAccounts");
        console.log('3--->'+checkList); 
	}
})
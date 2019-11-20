({
	afterRender: function (component, helper) {
    	var recordId = component.get("v.userId");
        component.set("v.recordId" , recordId);
        var checkId = component.get("v.recordId"); 
        var checkName = component.get("v.simpleRecord.Name");
        debugger;
        this.superAfterRender();
    // interact with the DOM here
	}
})
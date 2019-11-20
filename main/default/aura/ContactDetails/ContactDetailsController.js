({
	doInit : function(component, event, helper) {
        /**
         * Assign case record Id to attribute named caseRecordId 
         **/
        component.set('v.caseRecordId',component.get("v.recordId"));
        var checkCaseId = component.get("v.caseRecordId");
        debugger;
        
        /**
         * Server call to fetch the contact related to the Case
         **/
	}
})
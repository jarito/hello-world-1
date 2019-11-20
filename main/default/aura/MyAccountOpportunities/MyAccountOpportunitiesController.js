({
	handleAccountId : function(component, event, helper) {
		var accId = event.getParam("MyAccountId");
        debugger;
        component.set("v.accountId",accId);
        var temp = component.get("v.accountId");
        var action = component.get('c.getOpportunityList');
        action.setParams({accountId : temp});
        action.setStorable();
        action.setCallback(this,function(response){
                //this.handleResponse(response,component,helper); 
                var state = response.getState();
                if(response.getState() === 'SUCCESS'){
                var retObj = response.getReturnValue();
                console.log('Opportunity List is--> '+retObj);
                //debugger;
                component.set("v.opportunityList" , retObj);
            	}
            });
        $A.enqueueAction(action);         
        
	},
    handleClick : function(component, event, helper) {
        helper.handleClick(component, event, helper);
    },
    getRecordId : function(component, event, helper) {
        helper.getRecordId(component, event, helper);
    },
    handleEvent : function(component, event, helper) {
        helper.handleEvent(component, event, helper);
    },
    createNewRecord : function(component, event, helper) {
        helper.createNewRecord(component, event, helper);
    }    
    
})
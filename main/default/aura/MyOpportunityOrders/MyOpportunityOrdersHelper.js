({
	handleOpportunityId : function(component, event, helper) {
        component.set("v.Columns", [
            {label:"OrderNumber", fieldName:"OrderNumber", type:"String"},
            {label:"TotalAmount", fieldName:"TotalAmount", type:"Currency"},
            {label:"AccountName", fieldName:"AccountId", type:"Text"}
        ]);
        var temp = component.set("v.Columns");
        var oppId = event.getParam("opportunityId");
		component.set("v.opportunityId",oppId);
        debugger;
        var opportunityId = component.get("v.opportunityId");
  		var action = component.get('c.getOrderList');
        action.setParams({opportunityId : opportunityId});
        action.setStorable();
        action.setCallback(this,function(response){
        	//this.handleResponse(response,component,helper); 
        	var state = response.getState();
            debugger;
    	    if(response.getState() === 'SUCCESS'){
            //var retObj = JSON.parse(response.getReturnValue());
            var retObj = response.getReturnValue();
            console.log('sobjList is--> '+retObj);
            //debugger;
            component.set("v.orderList" , retObj);
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
    toggle: function(component, event, helper) {
        var orderList = component.get("v.orderList"), 
        index = event.getSource().get("v.value");
        orderList[index].expanded = !orderList[index].expanded;
        component.set("v.orderList", orderList);
    }
})
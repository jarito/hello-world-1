({
	getOrderItem : function(component, event, helper) {
        var action = component.get('c.getOrderProduct');
        action.setCallback(this,function(response){
            var state = response.getState();
            debugger;
            if(response.getState() === 'SUCCESS'){
                var retObj = response.getReturnValue();
                debugger;
                console.log('orderItem  is--> '+retObj);
                //debugger;
                component.set("v.orderItem" , retObj);
                var itemObj = component.get("v.orderItem");
                component.set("v.recordId",itemObj.Id);
                var checkId = component.get("v.recordId");
                debugger;
            }
        });
        $A.enqueueAction(action); 
	}
})
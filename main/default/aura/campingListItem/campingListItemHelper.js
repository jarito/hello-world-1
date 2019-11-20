({
	getValues : function(component) {
		var action = component.get('c.getItems');
		debugger;
        action.setCallback(this, function(response) {
        debugger;   
        //store state of response
        var state = response.getState();
        if (state === "SUCCESS") {
            var temp =response.getReturnValue();
            console.log("---------Camping Item Name-------"+temp.Name);
          	component.set('v.item', temp);
            
        } 
      });
	$A.enqueueAction(action);        
	}
})
({
    createExpense: function(component, account) {
        // Copy the expense to a new object
        // THIS IS A DISGUSTING, TEMPORARY HACK
        //var newAccount= JSON.parse(JSON.stringify(account));
 		//debugger;
        
        var action = component.get("c.saveAccount");
        console.log('after method called ');
        action.setParams({
            "account": account
        });
    
        action.setCallback(this, function(response){
            var state = response.getState();
    		debugger;
            if (component.isValid() && state === "SUCCESS") {
                var theAccounts = component.get("v.accounts");
 				debugger;
                var newAccount = response.getReturnValue(); 
                debugger;
                theAccounts.push(newAccount);
                component.set("v.accounts", theAccounts);
                var checkAcountlist = component.get("v.accounts");
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

    }
})
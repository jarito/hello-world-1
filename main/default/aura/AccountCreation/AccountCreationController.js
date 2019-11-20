({
    clickCreate: function(component, event, helper) {
        var validAccount = component.find('expenseform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validAccount){
            // Create the new expense
            var account = component.get("v.newAccount");
            debugger;
            console.log("Create Account: " + JSON.stringify(account));
            helper.createExpense(component, account);
        }
    }
})
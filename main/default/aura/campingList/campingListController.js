/*({

    clickCreateItem : function(component, event, helper) {

        //  check for validation

        var checkField = component.find("itemform").reduce(function (validSoFar, inputCmp) {

            // Displays error messages for invalid fields

            inputCmp.showHelpMessageIfInvalid();

            return validSoFar && inputCmp.get('v.validity').valid;

        }, true);

        if (checkField)

        {

            //  gets refernce to view's newItem attribute

            var newItemRef = component.get("v.newItem");

            console.log("Create Camping Item: " + JSON.stringify(newItemRef));

            // **** begin helper class code ****

            // note that i originally created helper class to perform the logic below

            // but it appears as though the challenge is expecting you NOT to use helper class

            // which would be why i was getting challenge error while using it

            var theItems = component.get("v.items");

            // Copy the expense to a new object

            // THIS IS A DISGUSTING, TEMPORARY HACK

            var newItem = JSON.parse(JSON.stringify(newItemRef));   

            theItems.push(newItem);

            component.set("v.items", theItems);

            //  *******  end helper class code *********

             

            //  this will reset the view's newItem object

            //  to a be a blank sobject of type Camping_Item__c

            //  credit to: Shobhit Saxena

            component.set("v.newItem",

                          {'sobjectType' : 'Camping_Item__c',

                           'Name' : '',

                           'Quantity__c' : 0,

                           'Price__c' : 0,

                           'Packed__c' : false});

        }

    }

})*/
({

    // Load items from Salesforce

    doInit: function(component, event, helper) {

    // Create the action
    var action = component.get("c.getItems");
 
    // Add callback behavior for when response is received
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
            component.set("v.items", response.getReturnValue());
        }
        else {
            console.log("Failed with state: " + state);
        }
    });
 
    // Send action off to be executed

    $A.enqueueAction(action);

},

    handleAddItem: function(component, event, helper) {
    //   var newItem = event.getParam("item");
    //helper.addItem(component, newItem);
    var action = component.get("c.saveItem");
            action.setParams({"item": newItem});
            action.setCallback(this, function(response){
                var state = response.getState();
                if (component.isValid() && state === "SUCCESS") {
                    // all good, nothing to do.
            var items = component.get("v.items");
            items.push(response.getReturnValue());
            component.set("v.items", items);
                }
            });
            $A.enqueueAction(action);
                }
})
({
      getFoodItemList: function(component) {
        var action = component.get('c.getFooditems');
        var temp = component.get("v.recordId");
          debugger;
        console.log('Current record ID'+temp);
        action.setParams({ recordId :component.get("v.recordId")});
		
        action.setCallback(this, function(response) {
           
        //store state of response
        var state = response.getState();
        if (state === "SUCCESS") {
             var temp =response.getReturnValue();
            console.log("Contact Street---"+temp.contactObj.MailingStreet);
            debugger;
          //set response value in wrapperList attribute on component.
          //component.set('v.foodItems', response.getReturnValue());
          component.set('v.foodItems', temp.foodItemsList);
          component.set('v.contactInfo',temp.contactObj);
            debugger;
          component.set('v.companyInfo',temp.companyObj);
        } 
        var sendContactObject = component.get('v.contactInfo');
        var sendCompanyObject = component.get('v.companyInfo');    
        var appEvent = $A.get("e.c:EventForObject");
        appEvent.setParams({"contactObject" : sendContactObject});
        appEvent.setParams({"companyObject" : sendCompanyObject});
        appEvent.fire();          

        
      });
         
          
        // Set up the callback
        /*
          var self = this;
        action.setCallback(this, function(actionResult) {
         component.set('v.foodItems', actionResult.getReturnValue());
        });
        */
        $A.enqueueAction(action);
      },
    
      removeFoodItem : function(component, index) {
          var removeItem = component.get("v.foodItems");
          removeItem.splice(index, 1);
          component.set("v.foodItems", removeItem);
      }    
    
})
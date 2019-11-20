({
    doInit : function(component, event, helper) {
		//debugger;
        var tempVar = component.get("v.recordId")
        console.log('***ID IN CART***',tempVar); 
    },
    
    callAuraMethod : function(component, event, helper) {
        //Call Child aura method
        var contactObj = component.get('v.contactInfoCart');
        var companyObj = component.get('v.companyInfoCart');
        var childComponent = component.find("childCmp");
        childComponent.mapMethod(contactObj,companyObj);
    },
    
	getContactDetails : function(component, event, helper) {
        var contactObjectToSend = event.getParam("contactObject");
        console.log('***CART Contact***',contactObjectToSend);
        debugger;
        var companyObjectToSend = event.getParam("companyObject");
        console.log('***CART Company***',companyObjectToSend); 
        component.set('v.contactInfoCart', contactObjectToSend);
        component.set('v.companyInfoCart', companyObjectToSend);
        var checkCon = component.get('v.contactInfoCart');
        console.log('***Contact Street IN CART***',checkCon.MailingStreet);
        var checkCompany = component.get('v.companyInfoCart');
        console.log('***Contact Street IN CART***',checkCompany.PostalCode);
        
    },
    
	handleApplicationEvent : function(component, event, helper) {
        var itemToAdd = event.getParam("foodItemRecieved");
        alert('***'+itemToAdd);
        var tempTotal = component.get('v.total');
        console.log('****',tempTotal);
        var itemList=component.get('v.foodItemsInCart');
        if(itemList && tempTotal){
            itemList.push(itemToAdd);
            component.set('v.foodItemsInCart', itemList);
            console.log('****',itemToAdd.Price__c);
            component.set('v.total', tempTotal+itemToAdd.Price__c);
        }
        else{
            itemList.push(itemToAdd);
            component.set('v.foodItemsInCart', itemToAdd);
            console.log('****',itemToAdd.Price__c);
            component.set('v.total',itemToAdd.Price__c);
        }
        
    },
    
    removeItem : function(component, event, helper) {
        var appEventcart = $A.get("e.c:FoodItemEventForCart");
        /*var index = event.target.getAttribute("data-arrivalCart");
        var allItems =  component.get("v.foodItemsInCart");
        if(index != -1){
          allItems.splice(index, 1); 
        }*/
        var targetItem = event.getSource().get("v.name");
        alert('----'+targetItem);
        var itemList = component.get("v.foodItemsInCart");
        var selectedRecord = {};
        for(var i = 0 ; i < itemList.length ; i++){
            if(targetItem ==  itemList[i].Id){
                selectedRecord = itemList[i].Id;
                 alert('--record to be added--'+selectedRecord);
            }
        }
        itemList.splice(selectedRecord, 1);
        component.set("v.foodItemsInCart", itemList);
		appEventcart.setParams({"foodItemRemove" : selectedRecord});
        appEventcart.fire();
        
        
    }
})
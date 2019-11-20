({
	doInit : function(component, event, helper) {
		//var recId = component.get("v.recordId")
        //debugger;
        //console.log('This is record ID in Component 1-----',tmp);
        helper.getFoodItemList(component);
        
        	
	},
    
    addItem : function(component, event, helper){
        //var index = event.target.getAttribute("data-arrival");
        //var selectedItem = component.get("v.foodItems")[index];
        var targetItem = event.getSource().get("v.name");
        alert('----'+targetItem);
        console.debug("***",targetItem)
        
        var itemList = component.get("v.foodItems");
        alert("***--"+itemList.length)
        var selectedRecord = {};
        for(var i = 0 ; i < itemList.length ; i++){
            if(targetItem ==  itemList[i].Id){
                selectedRecord = itemList[i];
                 alert('--record to be added--'+selectedRecord);
            }
        }
		//helper.removeFoodItem(component, index);
		//
        var appEvent = $A.get("e.c:FoodItemEvent");
        appEvent.setParams({"foodItemRecieved" : selectedRecord});
        appEvent.fire();
        let button = event.getSource();
        button.set('v.disabled',true);
    },
    
    ckeckDeletedItem : function(component, event, helper){
        var itemId = event.getParam("foodItemRemove");
        var show = component.find("buttonId");
        for(var i = 0 ; i<show.length ; i++){
            var tempId = show[i].get("v.name");
            if(itemId == tempId){
                show[i].set('v.disabled',false);

            }
        }
        
        
        alert('****Button *****'+show);
        alert('**itemId**'+itemId);
        
    }
})
({
    addFilter: function (component, event, helper) {
        var count = component.get("v.count");
        count += 1;
        component.set("v.count" , count);
        var checkCount = component.get("v.count");
        var componentList = component.get("v.componentList");
        var checkLength = componentList.length;
        debugger;
        if(checkCount <= 5){
           //Add New Account Record
            componentList.push({
                'sobjectType': 'Account',
                'FieldName': '',
                'CriteriaName': '',
                'ValueEntered': ''
            }); 
            component.set("v.count" , count);
            component.set("v.componentList", componentList);
        }
        if(checkCount > 5){
            alert("You can not add more tha 5 filters !!")
        }
        
         var componentList = component.get("v.componentList");
        debugger;
    },
    clearFilters: function (component, event, helper) {
        var componentList = component.get("v.componentList");
        debugger;
        component.set("v.componentList" , "");
        var componentList = component.get("v.componentList");
        debugger;
    },
    handleDeleteRow: function(component, event, helper) {
        //Get the account list
        var componentList = component.get("v.componentList");
        //Get the target object
        debugger;
        var index = event.getSource().get('v.value');
        debugger;
        componentList.splice(index, 1);
        component.set("v.componentList", componentList);
        var componentList = component.get("v.componentList");
        debugger;
    },
})
({
    doInit: function (component, event, helper) {
        var defaultFilter = component.get("v.defaultFilter");
		debugger;
        component.set('v.defaultFilter', {
                                            sobjectType : 'Account',
                                            FieldName : '',
                                            CriteriaName : '',
                                            ValueEntered: '',
										 });
        var defaultFilter = component.get("v.defaultFilter.ValueEntered");
        var val = defaultFilter.ValueEntered;
        debugger;
    },
    handleChange: function (component, event, helper) {
        // This will contain the string of the "value" attribute of the selected option
        var selectedOptionValue = event.getParam("value");
        alert("Option selected with value: '" + selectedOptionValue + "'");
        var picklist1 = component.get("v.picklist1");
        var sizeList = picklist1.length;
        for(var i = 0 ; i <= sizeList; ++i){
            if(picklist1[i] != selectedOptionValue){
               
                picklist1.push(selectedOptionValue);
        		component.set("v.picklist1" , picklist1);
                break;
            }
            else{
                alert( selectedOptionValue + " is already selected, select some other field !");
                break;
            }
        }
        var checkPicklist1 = component.get("v.picklist1");
        debugger;
    },
	criteriaHandleChange: function (component, event, helper) {
        // This will contain the string of the "value" attribute of the selected option
        var selectedCriteria = event.getParam("value");
        alert("Option selected with criteria: '" + selectedCriteria + "'");
        var picklist2 = component.get("v.picklist2");
        picklist2.push(selectedCriteria);
        component.set("v.picklist2" , picklist2);
        var checkPicklist1 = component.get("v.picklist2");
        debugger;
    },
    handleBlur: function (component, event, helper) {
        // This will contain the string of the "value" attribute of the selected option
        var selectedOrg = component.find("filterInput")
        debugger;
        var picklist3 = component.get("v.picklist3");
        debugger;
        picklist3.push(selectedOrg.get("v.value"))
        
       /* var val1 = selectedOrg[0].get("v.value");
        var picklist3 = component.get("v.picklist3");
        for(var i = 0 ; i < selectedOrg.length ; i++){
            picklist3.push(selectedOrg[i].get("v.value"))
        }*/
        component.set("v.picklist3" , picklist3);
        var checkPicklist3 = component.get("v.picklist3");
        debugger;
    },
    addFilter: function (component, event, helper) {
        helper.addFilter(component, event, helper);
    },
    clearFilters: function (component, event, helper) {
        helper.clearFilters(component, event, helper);
    },
    handleDeleteRow: function (component, event, helper) {
        helper.handleDeleteRow(component, event, helper);
    }
    
})
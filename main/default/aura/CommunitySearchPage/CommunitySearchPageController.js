({
    handleChange: function (component, event, helper) {
        // This will contain the string of the "value" attribute of the selected option
        var selectedOptionValue = event.getParam("value");
        alert("Option selected with value: '" + selectedOptionValue + "'");
        var picklist1 = component.get("v.picklist1");
        picklist1.push(selectedOptionValue);
        component.set("v.picklist1" , picklist1);
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
    
    //Used when filters are used within same component
	searchFellows: function (component, event, helper) {
        // This will contain the string of the "value" attribute of the selected option
        var selectedOrg = component.find("filterInput")
        var val1 = selectedOrg[0].get("v.value");
        var picklist3 = component.get("v.picklist3");;
        for(var i = 0 ; i < selectedOrg.length ; i++){
            picklist3.push(selectedOrg[i].get("v.value"))
        }
        component.set("v.picklist3" , picklist3);
        var checkPicklist3 = component.get("v.picklist3");
        debugger;
        
        helper.fellowRecordList(component, event, helper);
    } , 
    
    //used when filters are used with different filter component
    filterComponentMethod: function (component, event, helper) {
		helper.fellowRecordList(component, event, helper);
    } ,

	mySector: function (component, event, helper) {
        // This will contain the string of the "value" attribute of the selected option
        var selectedSector = component.find("sector").get("v.value");
        component.set("v.selectedSector" , selectedSector);
        var checkSector = component.get("v.selectedSector");
        debugger;
    },
	selectedOrg: function (component, event, helper) {
        // This will contain the string of the "value" attribute of the selected option
        var selectedOrg = component.find("org").get("v.value");
        component.set("v.selectedOrg" , selectedOrg);
        var checkSector = component.get("v.selectedOrg");
        debugger;
        
    },
    
})
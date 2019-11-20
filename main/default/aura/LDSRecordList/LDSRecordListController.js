({
    doInit : function(component, event, helper) {
        var objectType = component.get("v.sObjectType");
        debugger;
    },
    handleRecordUpdated : function(component, event, helper) {
        helper.handleRecordUpdated(component, event, helper);
    },
    getRecordId : function(component, event, helper) {
        helper.getRecordId(component, event, helper);
    },
    getOrderRecordId : function(component, event, helper) {
        helper.getOrderRecordId(component, event, helper);
    },   
    handleActiveComponent : function(component, event, helper) {
        helper.handleActiveComponent(component, event, helper);
    },
    handleChange : function(component, event, helper) {
        var checkObj = component.get("v.simpleRecord"); 
        var checkId = component.get("v.recordId");
        var checkCode =   component.get("v.simpleRecord.Product2.ProductCode"); 
        var record = component.get("v.record");
        debugger;
        var fieldName = component.get("v.fieldName");
        debugger;  
        if(fieldName == 'ProductCode'){
            component.set("v.isProductCodeField",true);
            var checkBool = component.get("v.isProductCodeField");
            debugger;
        } 
        component.find("recordHandler").reloadRecord();
        debugger;
    }
})
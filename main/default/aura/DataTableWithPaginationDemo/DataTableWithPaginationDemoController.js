({
    doInit : function(component, event, helper) {        
        helper.getColumnAndAction(component);
        helper.getAccounts(component, helper);
    },
     
    handleNext : function(component, event, helper) { 
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber+1);
        helper.getAccounts(component, helper);
    },
     
    handlePrev : function(component, event, helper) {        
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber-1);
        helper.getAccounts(component, helper);
    },
    
    updateSelectedText: function (component, event) {
        var selectedRows = event.getParam('selectedRows');
        debugger;
        var getAllSelectedRows = component.get("v.selectedRowList");
        debugger;
        component.find("accDT").set("v.selectedRows",component.get("v.selection"));
        debugger;
    }
 
})
({
    handleSubmit : function(component,event,helper) {
        component.find("editForm").submit();
        debugger;
    },
    handleSuccessMessage : function(component,event,helper) {
        
        component.find('popuplib').showCustomPopover({
            body: "Opportunity Is Updated",
            referenceSelector: ".mypopover",
            cssClass: "slds-popover slds-nubbin_left"
        }).then(function (overlay) {
            setTimeout(function(){ 
                //close the popover after 3 seconds
                overlay.close(); 
            }, 3000);
        });
        debugger;
        component.find("popuplib").notifyClose();
    },
    handleCancel : function(component,event,helper) {
        component.find("popuplib").notifyClose();
    }
})
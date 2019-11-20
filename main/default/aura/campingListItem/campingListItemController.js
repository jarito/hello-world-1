/*({
	doInit : function(component, event, helper) {
		helper.getValues(component);
	},
    packItem: function(component, event, helper){
        console.log("Value before click------"+component.get("v.item"));
        debugger;
		var temp = component.get("v.item");
        temp.Packed__c = true;
        temp.Quantity__c = 5;
        component.set("v.item",temp);
        console.log("Value after click"+component.get("v.item"));
        let btnClicked = event.getSource();
        var msg = btnClicked.get("v.label");
        component.set("v.message",msg);
        debugger;
        btnClicked.set('v.disabled',true);
		        
    } 
})*/

({

    packItem : function(component, event, helper) {

        var pack = component.get("v.item");

        pack.Packed__c = true;

        component.set("v.item",pack);

        var btnClicked = event.getSource();

        btnClicked.set("v.disabled",true);

    }

})
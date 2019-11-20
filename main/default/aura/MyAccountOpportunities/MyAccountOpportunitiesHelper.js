({
	handleAccountId : function(component, event, helper) {
		var accId = event.getParam("MyAccountId");
        debugger;
        component.set("v.accountId",accId);
        var temp = component.get("v.accountId");
	},
    handleClick : function(component, event, helper) {
        $A.createComponent("c:OpportunityEdit", { recordId : event.getSource().get('v.value') },
                           function(content, status) {
                               var checkContent = content;
                               debugger;
                               if (status === "SUCCESS") {
                                   component.find('overlayLib').showCustomModal({
                                       header: "Opportunity Edit",
                                       body: content, 
                                       showCloseButton: true,
                                       cssClass: "mymodal",
                                       closeCallback: function() {
                                           //$A.get('e.force:refreshView').fire();
                                           //Server call to get updated Opportunities
                                            var accountId = component.get("v.accountId");
                                            debugger;
    										var action = component.get('c.getOpportunityList');
                                            action.setParams({accountId : accountId});
                                            action.setCallback(this,function(response){
                                                var state = response.getState();
                                                if(response.getState() === 'SUCCESS'){
                                                var retObj = response.getReturnValue();
                                                console.log('Opportunity List is--> '+retObj);
                                                //debugger;
                                                component.set("v.opportunityList" , retObj);
                                            	}
                                            });
                                            $A.enqueueAction(action);
                                       }
                                   })
                               }                               
                           });
    },
	getRecordId : function(component, event, helper) {
		var temp = component.get("v.accountId");
        debugger;
        //Get index of the record which is being clicked
        var idx = event.target.getAttribute('data-index');
        var opportunityRecord = component.get("v.opportunityList")[idx];
        component.set("v.opportunityRecord" , opportunityRecord);
        var oppId = opportunityRecord.Id;
        component.set("v.opportunityId" , oppId);
        var applicationEvent = $A.get("e.c:OpportunityRecordId");
		applicationEvent.setParams({"opportunityId" : oppId})
    	applicationEvent.fire();
        var appEvent = $A.get("e.c:OpportunityIdOrder");
		appEvent.setParams({"opportunityId" : oppId})
    	appEvent.fire();        
        
	},
    handleEvent : function(component, event, helper) {
     	var oppMessage = event.getParam("message");
        var accountId = component.get("v.accountId");
        debugger;
    	var action = component.get('c.getOpportunityList');
        action.setParams({accountId : accountId});
        action.setCallback(this,function(response){
            var state = response.getState();
            if(response.getState() === 'SUCCESS'){
            var retObj = response.getReturnValue();
                console.log('Opportunity List is--> '+retObj);
                //debugger;
                component.set("v.opportunityList" , retObj);
            }
        });
       $A.enqueueAction(action);     
    },
    createNewRecord : function(component, event, helper) {  
        var applicationEvent = $A.get("e.c:AccountRecordId");
		applicationEvent.setParams({"MyAccountId" : component.get("v.accountId")})
    	applicationEvent.fire();
        $A.createComponent("c:CreateNewOpportunity", { recordId : component.get("v.accountId") },
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   component.find('overlayLib').showCustomModal({
                                       header: "New Opportunity",
                                       body: content, 
                                       showCloseButton: true,
                                       cssClass: "mymodal",
                                       closeCallback: function() {
                                           //$A.get('e.force:refreshView').fire();
                                           //Server call to get updated Opportunities
                                            var accountId = component.get("v.accountId");
                                            debugger;
    										var action = component.get('c.getOpportunityList');
                                            action.setParams({accountId : accountId});
                                            action.setCallback(this,function(response){
                                                var state = response.getState();
                                                if(response.getState() === 'SUCCESS'){
                                                var retObj = response.getReturnValue();
                                                console.log('Opportunity List is--> '+retObj);
                                                //debugger;
                                                component.set("v.opportunityList" , retObj);
                                            	}
                                            });
                                            $A.enqueueAction(action);
                                       }
                                   })
                               }                               
                           });       
    }   
})
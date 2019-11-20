({
	handleAccountId : function(component, event, helper) {
		var accId = event.getParam("MyAccountId");
        component.set("v.accountId",accId);
        var objectName = component.get("v.objectName");
        debugger;
        if(objectName == 'Order'){ 
            component.set("v.orderList",null);
            component.set("v.orderItemsList",null);
            var checkList = component.get("v.orderList");
            var checkList = component.get("v.orderItemsList");
            debugger;
        }
        if(objectName == 'Opportunity'){
            var recId = component.get("v.accountId");	
            debugger;
            var action = component.get('c.findRecords');
            action.setParams({recId : recId});
            action.setCallback(this,function(response){
                var state = response.getState();
                if(response.getState() === 'SUCCESS'){
                var retObj = response.getReturnValue();
                    console.log('Opportunity List is--> '+retObj);
                    //debugger;
                    component.set("v.opportunityList" , retObj);
                }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    debugger;
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " +
                                     errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }            
            });
           $A.enqueueAction(action);
        } 
	},
	toggle: function(component, event, helper) {
        var items = component.get("v.opportunityList"), 
        index = event.getSource().get("v.value");
        items[index].expanded = !items[index].expanded;
        component.set("v.opportunityList", items);
    },
	opportunityDetailPage : function(component, event, helper) {
        var baseURL = 'https://shruti-kulkarni-dev-ed.lightning.force.com/lightning/r/Opportunity/';
        var baseView = '/view';
        var recId = event.getSource().get("v.value");
        var finalUrl = baseURL+recId+baseView;
        window.open(finalUrl,'_blank');
    }, 
	editOpportunity : function(component, event, helper) {
        var idx = event.getSource().get('v.value');
        var opportunityClass = event.getSource().get('v.class');
        debugger;
        $A.createComponent("c:OpportunityEdit", { recordId : event.getSource().get('v.value') },
                           function(content, status) {
                               if (status === "SUCCESS") {
                                    component.find('overlayLib').showCustomModal({
                                        header: "Edit Opportunity",
                                        body: content, 
                                        showCloseButton: true,
                                        cssClass: "mymodal",
                                        closeCallback: function() {
                                            if(opportunityClass == 'closedOpportunities'){
                                                
                                                debugger;
                                            }
                                        }
                                   })
                               }                               
                           });
    },
    orderRecordDetailPage : function(component, event, helper) {
        var baseURL = 'https://shruti-kulkarni-dev-ed.lightning.force.com/lightning/r/Order/';
        var baseView = '/view';
        var recId = event.getSource().get("v.value");
        var finalUrl = baseURL+recId+baseView;
        window.open(finalUrl,'_blank');		
    },
    editOrder : function(component, event, helper) {
        var checkOppId = event.getSource().get('v.name');
        var checkOrderId = event.getSource().get('v.value');
        var sObjectName = component.get("v.objectName");
        component.set("v.opportunityId" , checkOppId );
        var oppId = component.get("v.opportunityId");
        debugger;
        if(sObjectName == 'Order' ){
            $A.createComponent("c:MyOrderEdit", { recordId : event.getSource().get('v.value') },
            function(content, status) {
                if (status === "SUCCESS") {
                    component.find('overlayLib').showCustomModal({
                        header: "Edit Order",
                        body: content, 
                        showCloseButton: true,
                        cssClass: "mymodal",
                        closeCallback: function() {
                            var applicationEvent = $A.get("e.c:SampleEvent");
                            applicationEvent.setParams({"message" : "Hello"})
                            applicationEvent.fire(); 
                            
                            var appEvent = $A.get("e.c:sObjectEvent");
                            appEvent.setParams({"sObjectName" : "updateOpportunities"});
                            appEvent.setParams({"opportunityId" : checkOppId});
                            appEvent.fire();
                        }
                    })
                }                               
            });            
        }
        else{
            $A.createComponent("c:MyOrderEdit", { recordId : event.getSource().get('v.value') },
            function(content, status) {
                if (status === "SUCCESS") {
                    component.find('overlayLib').showCustomModal({
                        header: "Edit Order",
                        body: content, 
                        showCloseButton: true,
                        cssClass: "mymodal",
                    })
                }                               
            });
        }


    },
    handleActiveComponent : function(component, event, helper) {
        var sObjectName = event.getParam("sObjectName");
        var recId = event.getParam("opportunityId");
        var objName = component.get("v.objectName");
        debugger;
        if(sObjectName == 'Order'){
            if(objName == sObjectName){
                var action = component.get('c.getOrderItems');
                action.setParams({recId : recId});
                action.setCallback(this,function(response){
                    var state = response.getState();
                    debugger;
                    if(response.getState() === 'SUCCESS'){
                        var retObj = response.getReturnValue();
                        component.set("v.orderItemsList" , retObj);
                        component.set("v.orderList" , null);     
                        var checkList =component.get("v.orderItemsList");
                        debugger;
                    }
                    else if (state === "ERROR") {
                        var errors = response.getError();
                        debugger;
                        if (errors) {
                            if (errors[0] && errors[0].message) {
                                console.log("Error message: " +
                                         errors[0].message);
                            }
                        } else {
                            console.log("Unknown error");
                        }
                    }
        
                });
                $A.enqueueAction(action);                 
            }
        }        
        if(objName != sObjectName){
            if(objName == 'Order'){
            //var recId = component.get("v.opportunityId");
                component.set("v.orderItemsList" , null);
                var action = component.get('c.findRecords');
                action.setParams({recId : recId});
                action.setCallback(this,function(response){
                    //this.handleResponse(response,component,helper); 
                    var state = response.getState();
                    debugger;
                    if(response.getState() === 'SUCCESS'){
                    //var retObj = JSON.parse(response.getReturnValue());
                    var retObj = response.getReturnValue();
                    component.set("v.orderList" , retObj);    
                    component.set("v.recList" , retObj);    
                    var checkList =component.get("v.orderList");
                    console.log('sobjList is--> '+retObj);
                    var checkObj = component.get("v.objectName");
                    debugger;
                    
                    }
                    else if (state === "ERROR") {
                        var errors = response.getError();
                        debugger;
                        if (errors) {
                            if (errors[0] && errors[0].message) {
                                console.log("Error message: " +
                                        errors[0].message);
                            }
                        } else {
                            console.log("Unknown error");
                        }
                    }
        
                });
                $A.enqueueAction(action); 
            }           
        }
        else{
            component.set("v.trial","Hello");
            debugger;
        }
    },
    orderItemDetailPage : function(component, event, helper) {
        var baseURL = 'https://shruti-kulkarni-dev-ed.lightning.force.com/lightning/r/OrderItem/';
        var baseView = '/view';
        var recId = event.getSource().get("v.value");
        var finalUrl = baseURL+recId+baseView;
        window.open(finalUrl,'_blank');		
    },  
    editOrderItem : function(component, event, helper) {
        var checkOrderId = event.getSource().get('v.name');
        var checkOrderItemId = event.getSource().get('v.value');
        var checkOrderItemClass = event.getSource().get('v.class');
        var sObjectName = component.get("v.objectName");
        debugger;
        if(sObjectName == 'Order' ){
            if(checkOrderItemClass == 'orderTable'){
                var oppId = component.get("v.opportunityId"); 
                debugger;
                $A.createComponent("c:MyOrderItemEdit", { recordId : event.getSource().get('v.value') },
                function(content, status) {
                    if (status === "SUCCESS") {
                        component.find('overlayLib').showCustomModal({
                            header: "Edit Order Item",
                            body: content, 
                            showCloseButton: true,
                            cssClass: "mymodal",
                        })
                    }                               
                });                 
            }
            else if(checkOrderItemClass = 'orderItemTable'){
                $A.createComponent("c:MyOrderItemEdit", { recordId : event.getSource().get('v.value') },
                function(content, status) {
                    if (status === "SUCCESS") {
                        component.find('overlayLib').showCustomModal({
                            header: "Edit Order Item",
                            body: content, 
                            showCloseButton: true,
                            cssClass: "mymodal",
                        })
                    }                               
                });                
            }            
        }
    }, 
    toggleOrders: function(component, event, helper) {
        var oppId = event.getSource().get('v.name'); 
        debugger;
        component.set("v.opportunityId",oppId)
        var items = component.get("v.orderList"), 
        index = event.getSource().get("v.value");
        items[index].expanded = !items[index].expanded;
        component.set("v.orderList", items);
    },  
    ToggleCollapse : function(component, event, helper) {
        var action = component.get('c.getClosedOpportunities');
        var accountId = component.get("v.accountId");	
        debugger;
        action.setParams({accountId : accountId});
        action.setCallback(this,function(response){
        	//this.handleResponse(response,component,helper); 
        	var state = response.getState();
            debugger;
    	    if(response.getState() === 'SUCCESS'){
            //var retObj = JSON.parse(response.getReturnValue());
            var retObj = response.getReturnValue();
            component.set("v.closedOpportunityList" , retObj);     
            var checkList =component.get("v.closedOpportunityList");
            debugger;
            
        	}
            else if (state === "ERROR") {
                var errors = response.getError();
                debugger;
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }

        });
        $A.enqueueAction(action);        
        
        //Toggle section
        var existingText = component.get("v.collpaseText"); 
        var container = component.find("containerCollapsable") ;
        debugger;
        if(existingText === "Hide Closed Opportunities"){
            component.set("v.collpaseText","Show Closed Opportunities");
            $A.util.toggleClass(container, 'hide');
            debugger;  
        }else{
            component.set("v.collpaseText","Hide Closed Opportunities");
            $A.util.toggleClass(container, 'hide');  
            debugger;
        }		
    },  
    toggleClosedOpportunities: function(component, event, helper) {
        var items = component.get("v.closedOpportunityList"), 
        index = event.getSource().get("v.value");
        items[index].expanded = !items[index].expanded;
        component.set("v.closedOpportunityList", items);
    }, 
    showSpinner: function(component, event, helper) {
        // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
    },
    hideSpinner : function(component,event,helper){
        // make Spinner attribute to false for hide loading spinner    
        component.set("v.Spinner", false);
    }  	
})
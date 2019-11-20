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
	},
	getRecordId : function(component, event, helper) {
        var ch = event.target.tagName;
        var opportunityId = event.target.getAttribute('id');
        debugger;
        //Fetching Record ID using Index of Record*****
        //var idx = event.target.getAttribute('data-index');
        //var opportunityRecord = component.get("v.opportunityList")[idx];
        //component.set("v.opportunityRecord" , opportunityRecord);
        //var opportunityId = opportunityRecord.Id;
        //component.set("v.opportunityId" , opportunityId);
        //var checkOppId = component.get("v.opportunityId");
        //debugger;
        var applicationEvent = $A.get("e.c:OpportunityRecordId");
		applicationEvent.setParams({"opportunityId" : opportunityId})
        applicationEvent.fire();
        
        /* Event fired to send opportunity id to generic component named MyRecordDetails, to display 
         * opportunity details
         * This event should be handled by second(right side) instance of component MyRecordDetails */ 
        var applicationEvent = $A.get("e.c:MyRecordDetailEvent");
        applicationEvent.setParams({"recordId" : opportunityId});
        applicationEvent.setParams({"objectName" : "Opportunity"});
        applicationEvent.fire();
        
        /* Event fired to send opportunity id to generic component(this component) named MyRecords, to display 
         * orders related to opportunity which user has clicked, in the second instance of this component(right side)
         * This event should be handled by second(right side) instance of the same(this) component MyRecords */         
        var sObjectName = component.get("v.objectName");
        debugger;
        var appEvent = $A.get("e.c:sObjectEvent");
        appEvent.setParams({"sObjectName" : sObjectName});
        appEvent.setParams({"opportunityId" : opportunityId});
        appEvent.fire();
        
	        
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
        //Handle this part to update opportunities(left) and related orders(right) 
        //when Order is edited from component on right side
        if(sObjectName == 'updateOpportunities'){
            if(objName == 'Opportunity'){
                var accountId = component.get("v.accountId");
                debugger;
                component.set("v.orderItemsList" , null);
                var action = component.get('c.findRecords');
                action.setParams({recId : accountId});
                action.setCallback(this,function(response){
                    //this.handleResponse(response,component,helper); 
                    var state = response.getState();
                    debugger;
                    if(response.getState() === 'SUCCESS'){
                    //var retObj = JSON.parse(response.getReturnValue());
                    var retObj = response.getReturnValue();
                    component.set("v.opportunityList" , retObj);    
                    component.set("v.recList" , retObj);    
                    var checkList =component.get("v.opportunityList");
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
    handleClick : function(component, event, helper) {
        var idx = event.getSource().get('v.name');
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
                                           //$A.get('e.force:refreshView').fire();
                                           //Server call to get updated Opportunities
                                            var recId = component.get("v.accountId");
                                            debugger;
    										var action = component.get('c.findRecords');
                                            action.setParams({recId : recId});
                                            action.setCallback(this,function(response){
                                                var state = response.getState();
                                                debugger;
                                                if(response.getState() === 'SUCCESS'){
                                                var retObj = response.getReturnValue();
                                                console.log('Opportunity List is--> '+retObj);
                                                //debugger;
                                                component.set("v.opportunityList" , retObj);
                                                component.set("v.trial" , "Hello");   
                                            	}
                                            });
                                            $A.enqueueAction(action);

                                            var recId = component.get("v.accountId");
                                            debugger;

    										var action = component.get('c.getClosedOpportunities');
                                            action.setParams({accountId : recId});
                                            action.setCallback(this,function(response){
                                                var state = response.getState();
                                                debugger;
                                                if(response.getState() === 'SUCCESS'){
                                                var retObj = response.getReturnValue();
                                                console.log('closedOpportunityList List is--> '+retObj);
                                                //debugger;
                                                component.set("v.closedOpportunityList" , retObj);  
                                            	}
                                            });
                                            $A.enqueueAction(action);                                            
                                       }
                                   })
                               }                               
                           });
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
                        closeCallback: function() {
                            //$A.get('e.force:refreshView').fire();
                            //Server call to get updated Opportunities
                             var recId = component.get("v.accountId");
                             debugger;
                             var action = component.get('c.findRecords');
                             action.setParams({recId : recId});
                             action.setCallback(this,function(response){
                                 var state = response.getState();
                                 debugger;
                                 if(response.getState() === 'SUCCESS'){
                                 var retObj = response.getReturnValue();
                                 console.log('Order List is--> '+retObj);
                                 //debugger;
                                 component.set("v.opportunityList" , retObj);
                                 component.set("v.trial" , "Hello");   
                                 }
                             });
                             $A.enqueueAction(action);
                        }
                    })
                }                               
            });
        }


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
                            closeCallback: function() {
                                var action = component.get('c.findRecords');
                                action.setParams({recId : oppId});
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
                            closeCallback: function() {
                                var action = component.get('c.getOrderItems');
                                action.setParams({recId : checkOrderId});
                                action.setCallback(this,function(response){
                                    var state = response.getState();
                                    if(response.getState() === 'SUCCESS'){
                                    var retObj = response.getReturnValue();
                                        console.log('orderItemsList List is--> '+retObj);
                                        debugger;
                                        component.set("v.orderItemsList" , retObj);
                                    }
                                });
                               $A.enqueueAction(action);
                            }
                        })
                    }                               
                });                
            }            
        }
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
        
        if(existingText === "Hide Closed Opportunities"){
             component.set("v.collpaseText","Show Closed Opportunities");
            $A.util.toggleClass(container, 'hide');  
        }else{
            component.set("v.collpaseText","Hide Closed Opportunities");
            $A.util.toggleClass(container, 'hide');  
        }		
	},
	handleSectionToggle : function(component, event, helper) {
        var openSections = event.getParam('openSections');
		debugger;
        var currentOpportunityId = openSections.reverse();
        var recId = currentOpportunityId[0];
        debugger;
  		var action = component.get('c.getOrderList');
        action.setParams({recId : recId});
        action.setCallback(this,function(response){
        	//this.handleResponse(response,component,helper); 
        	var state = response.getState();
            debugger;
    	    if(response.getState() === 'SUCCESS'){
              	component.set("v.trial" , "Hello");
                //var retObj = JSON.parse(response.getReturnValue());
                var retObj = response.getReturnValue();
                component.set("v.orderList" , retObj);     
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
				       
    },
    handleEvent : function(component, event, helper) {
       var oppMessage = event.getParam("message");
       var sObjectName = component.get('v.objectName');
       debugger;
        if(sObjectName == 'Opportunity'){
            var accountId = component.get("v.accountId");
            debugger;
            var action = component.get('c.findRecords');
            action.setParams({recId : accountId});
            action.setCallback(this,function(response){
                var state = response.getState();
                if(response.getState() === 'SUCCESS'){
                var retObj = response.getReturnValue();
                    console.log('Opportunity List is--> '+retObj);
                    debugger;
                    component.set("v.opportunityList" , retObj);
                }
            });
           $A.enqueueAction(action);
        }
        if(sObjectName == 'Order'){
            var checkOppId = component.get("v.opportunityId");
            debugger;

        }
     
   },    
    toggle: function(component, event, helper) {
        var items = component.get("v.opportunityList"), 
        index = event.getSource().get("v.value");
        items[index].expanded = !items[index].expanded;
        component.set("v.opportunityList", items);
    },
    toggleClosedOpportunities: function(component, event, helper) {
        var items = component.get("v.closedOpportunityList"), 
        index = event.getSource().get("v.value");
        items[index].expanded = !items[index].expanded;
        component.set("v.closedOpportunityList", items);
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
    createNewRecord : function(component, event, helper) {  
       // var applicationEvent = $A.get("e.c:AccountRecordId");
		//applicationEvent.setParams({"MyAccountId" : component.get("v.accountId")})
    	//applicationEvent.fire();
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
                                            var recId = component.get("v.accountId");
                                            debugger;
    										var action = component.get('c.findRecords');
                                            action.setParams({recId : recId});
                                            action.setCallback(this,function(response){
                                                var state = response.getState();
                                                debugger;
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
	recordDetailPage : function(component, event, helper) {
        var baseURL = 'https://shruti-kulkarni-dev-ed.lightning.force.com/lightning/r/Opportunity/';
        var baseView = '/view';
        var recId = event.getSource().get("v.value");
        var finalUrl = baseURL+recId+baseView;
        window.open(finalUrl,'_blank');
    }, 
	orderRecordDetailPage : function(component, event, helper) {
        var baseURL = 'https://shruti-kulkarni-dev-ed.lightning.force.com/lightning/r/Order/';
        var baseView = '/view';
        var recId = event.getSource().get("v.value");
        var finalUrl = baseURL+recId+baseView; 
        window.open(finalUrl,'_blank');		
    },
    orderItemDetailPage : function(component, event, helper) {
        var baseURL = 'https://shruti-kulkarni-dev-ed.lightning.force.com/lightning/r/OrderItem/';
        var baseView = '/view';
        var recId = event.getSource().get("v.value");
        var finalUrl = baseURL+recId+baseView;
        window.open(finalUrl,'_blank');		
    },
	getOrderRecordId : function(component, event, helper) {
        var orderId = event.target.getAttribute('id');
        debugger;
       /* Event fired to send opportunity id to generic component named MyRecordDetails, to display 
        * opportunity details
        * This event should be handled by second(right side) instance of component MyRecordDetails */ 
        var applicationEvent = $A.get("e.c:MyRecordDetailEvent");
        applicationEvent.setParams({"recordId" : orderId});
        applicationEvent.setParams({"objectName" : "Order"});
        applicationEvent.fire();

        //Event fired to send Id to the same component instance on rightside, to display list of Order items
        var appEvent = $A.get("e.c:sObjectEvent");
        appEvent.setParams({"sObjectName" : "Order"});
        appEvent.setParams({"opportunityId" : orderId});
        appEvent.fire();
	}    
})
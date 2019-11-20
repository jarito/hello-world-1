({
	doInit : function(component, event, helper) {
        console.log('init...');
		debugger;
	},
    handleAccountId : function(component, event, helper) {
		helper.handleAccountId(component, event, helper);
	},
	getRecordId : function(component, event, helper) {
		helper.getRecordId(component, event, helper);
	},    
	handleClick : function(component, event, helper) {
		helper.handleClick(component, event, helper);
	},
    editOrder : function(component, event, helper) {
		helper.editOrder(component, event, helper);
	},	
	handleEvent : function(component, event, helper) {
        helper.handleEvent(component, event, helper);
    },
	ToggleCollapse : function(component, event, helper) {
		helper.ToggleCollapse(component, event, helper);
	},
	handleSectionToggle : function(component, event, helper) {
		helper.handleSectionToggle(component, event, helper);
	},
	toggle : function(component, event, helper) {
		helper.toggle(component, event, helper);
	},
	toggleClosedOpportunities : function(component, event, helper) {
		helper.toggleClosedOpportunities(component, event, helper);
	},
	toggleOrders : function(component, event, helper) {
		helper.toggleOrders(component, event, helper);
	},
	createNewRecord : function(component, event, helper) {
		helper.createNewRecord(component, event, helper);
	},
 	handleActiveComponent : function(component, event, helper) {
		helper.handleActiveComponent(component, event, helper);
	},
	recordDetailPage : function(component, event, helper) {
		helper.recordDetailPage(component, event, helper);
	},
	orderRecordDetailPage : function(component, event, helper) {
		helper.orderRecordDetailPage(component, event, helper);
	}, 	 	   
	getOrderRecordId : function(component, event, helper) {
		helper.getOrderRecordId(component, event, helper);
	},
	orderItemDetailPage : function(component, event, helper) {
		helper.orderItemDetailPage(component, event, helper);
	},
	editOrderItem : function(component, event, helper) {
		helper.editOrderItem(component, event, helper);
	}	
})
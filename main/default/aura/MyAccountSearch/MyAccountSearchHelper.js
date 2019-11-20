({
	getAccounts : function(component, event, helper) {
		//var target = event.target;
        //var searchText = event.target.value;
        var whichOne = event.getSource().getLocalId();         
     	var mycmp = component.find(whichOne);
		//debugger;
        var inputVal = mycmp.get("v.value");
        //debugger;
            component.set("v.accColumns", [
            {label:"Name", fieldName:"Name", type:"text"},
            {label:"Website", fieldName:"Website", type:"url"},
            {label:"Type", fieldName:"Type", type:"Picklist"},
            {label:"Industry", fieldName:"Industry", type:"Picklist"},
            {label:"City", fieldName:"BillingCity", type:"string"}
        ]); 
        console.log('Columns----->'+component.get("v.Columns"));
        var action = component.get('c.getAccountLists');
        action.setParams({searchText : inputVal});
        action.setCallback(this,function(response){
        	//this.handleResponse(response,component,helper); 
        	var state = response.getState();
    	    if(response.getState() === 'SUCCESS'){
            //var retObj = JSON.parse(response.getReturnValue());
            var retObj = response.getReturnValue();
            console.log('sobjList is--> '+retObj);
            //debugger;
            component.set("v.accountList" , retObj);
        }
        });
        $A.enqueueAction(action);
	},
    itemSelected : function(component, event, helper) {
        var target = event.target;  
        debugger;
        var SelIndex = helper.getIndexFrmParent(target,helper,"data-selectedIndex");  
        if(SelIndex){
            var serverResult = component.get("v.accountList");
            debugger;
            var selItem = serverResult[SelIndex];
            debugger;
            if(selItem){
               component.set("v.selItem",selItem);
               //component.set("v.last_ServerResult",serverResult);
            } 
			var accountId = selItem.Id; 
            var accName = selItem.Name;
            component.set("v.accountName" , selItem.Name);
			/** Event is fired to send AccountId and objectName to component MyRecordDetails 
			  * to display details of selected account
			  */
            var applicationEvent = $A.get("e.c:MyRecordDetailEvent");
            applicationEvent.setParams({"recordId" : accountId});
            applicationEvent.setParams({"objectName" : "Account"});
			applicationEvent.fire();

			/** Event is fired to send AccountId to component MyRecords to display related 
			  * opportunities selected account
			  */
            var applicationEvent = $A.get("e.c:AccountRecordId");
            applicationEvent.setParams({"MyAccountId" : accountId});
			applicationEvent.fire(); 
			          
            component.set("v.accountID",accountId);
            var accId = component.get("v.accountID");
            debugger;
            component.set("v.accountList",null);          
        }         
    },
    getIndexFrmParent : function(target,helper,attributeToFind){
        //User can click on any child element, so traverse till intended parent found
        var SelIndex = target.getAttribute(attributeToFind);
        debugger;
        while(!SelIndex){
            target = target.parentNode ;
			SelIndex = helper.getIndexFrmParent(target,helper,attributeToFind);           
        }
        console.log('Check-->'+SelIndex);
        return SelIndex;
    }
})
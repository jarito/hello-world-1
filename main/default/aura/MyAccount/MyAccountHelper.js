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
            var applicationEvent = $A.get("e.c:MyRecordDetailEvent");
            applicationEvent.setParams({"recordId" : accountId});
            applicationEvent.setParams({"objectName" : "Account"});
            applicationEvent.fire();
            var applicationEvent = $A.get("e.c:AccountRecordId");
            applicationEvent.setParams({"MyAccountId" : accountId});
            applicationEvent.fire();           
            //component.set("v.recId",accountId);
            component.set("v.accountID",accountId);
             var accId = component.get("v.accountID");
            component.set("v.recordId",accId);
            component.set("v.newAccountError","This is Error Message");
            var checkId = component.get("v.recordId");
            console.log('Account id ------->'+checkId) ;
            debugger;
            component.set("v.accountList",null);

			//var childCmp = component.find("childCmp");
            //childCmp.sendId(checkId);

            
            //Server call to fetch all the related opportunities of the selected account\
            component.set("v.Columns", [
                        {label:"Name", fieldName:"Name", type:"text"},
                        {label:"StageName", fieldName:"StageName", type:"Picklist"},
                        {label:"Amount", fieldName:"Amount", type:"currency", cellAttributes: { alignment: 'left' }},
                		{label:"CloseDate", fieldName:"CloseDate", type:"Date"}
                    ]);           
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
    },
    handleRecordUpdated: function(component, event, helper) {
        var eventParams = event.getParams();
        debugger;
        if(eventParams.changeType === "LOADED") {
           // record is loaded (render other component which needs record data value)
            console.log("Record is loaded successfully.");
            console.log("You loaded a record in " + 
                        component.get("v.simpleRecord.Industry"));
        } else if(eventParams.changeType === "CHANGED") {
            // record is changed
        } else if(eventParams.changeType === "REMOVED") {
            // record is deleted
        } else if(eventParams.changeType === "ERROR") {
            // there’s an error while loading, saving, or deleting the record
        }
    },
    editAccount : function(component, event, helper) {
		var accountID = component.get("v.accountID");
        //component.set("v.selectedAccountId",accountID);
        debugger;
    },
    handleClick : function(component, event, helper) {
        $A.createComponent("c:OpportunityEdit", { recordId : event.getSource().get('v.value') },
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   component.find('overlayLib').showCustomModal({
                                       header: "Opportunity Edit",
                                       body: content, 
                                       showCloseButton: true,
                                       cssClass: "mymodal",
                                   })
                               }                               
                           });
    }
})
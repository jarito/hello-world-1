({
	getSearchList : function(component, event, helper) {
        
        component.set('v.columns', [
            {label: 'Contact First Name', 	fieldName: 'FirstName',   				type: 'text'},
            {label: 'Contact Last Name',  	fieldName: 'LastName',    				type: 'text'},
            {label: 'Email', 			  	fieldName: 'Email__c',    				type: 'Email'},
            {label: 'Current Country',    	fieldName: 'Current_Country__c',  		type: 'text'},
            {label: 'Current City',       	fieldName: 'Current_City__c',      		type: 'text'},
            {label: 'Phone',              	fieldName: 'Phone',     				type: 'Phone'},
        ]);
        
		var searchResultList = event.getParam("recordList");
        component.set("v.searchResultList" , searchResultList)
        var checkResultList = component.get("v.searchResultList");
        component.set("v.message", "Application Event Fired");
		var checkMsg = component.get("v.message");
        debugger;		
	}
})
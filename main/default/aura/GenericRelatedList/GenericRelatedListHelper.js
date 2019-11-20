({    
    handleViewall : function(component, event, helper){
        var contactId = component.get('v.contactId');
        //var contactId = '003P000001CDqawIAD';
        var initialURL = '/lightning/r/'+contactId+'/related/';
        
        var childRelName = component.get('v.objectName');
        var redirectURL = initialURL+childRelName+'/view';
        console.log('<<redirectURL>>',redirectURL);
        window.open(redirectURL,'_blank');
    },
    
    handleCreateNewCase : function(component, event, helper) {
        //alert('Create new record');
        var checkObj = component.get('v.objectName');
        /*if(checkObj == 'Case') {
            alert('SObject type >> Case');
        }
        else if(checkObj == 'Lead') {
            alert('SObject type >> Lead');
        }*/
        
        $A.createComponent("c:CreateNewRecord", { objectName : checkObj,
                                                 contactId : component.get('v.contactId')},
					   function(content, status, errorMessage) {
						   if (status === "SUCCESS") {
							   component.find('overlayLib').showCustomModal({
								   header: "New "+checkObj,
								   body: content, 
								   showCloseButton: true,
								   cssClass: "mymodal",
								   closeCallback: function() {
									   //$A.get('e.force:refreshView').fire();
								   }
							   })
						   }
                           else if (status === "ERROR") {
                               	console.log("Error: " + errorMessage);
                               	// Show error message
                           }
                           else if (status === "INCOMPLETE") {
                           	   	console.log("No response from server or client is offline.")
                           		// Show offline error
                           }  
					   });
        
    }, 
    handleRelatedListContent : function(component, event, helper) {
        var action = component.get('c.getRecordListAndFieldSet');
        var selectedObj = component.get('v.objectName');
        var fieldSetInput = component.get('v.fieldsetName');
        var checkFieldAPI = component.get('v.fieldNameForSort');
        var checkOrder = component.get('v.order');
        debugger;

        action.setParams({  sObjectName : selectedObj,
                            fieldSetInput : fieldSetInput,
                            contactId : component.get('v.contactId'),
                            maxRecords : component.get('v.maxRecords'),
                            fieldNameForSort : component.get('v.fieldNameForSort'),
                            order : component.get('v.order')
                        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var res =response.getReturnValue();
                
                // Updated today
                var checkRes = res.lstDataTableWrapper;
                debugger;
                var lstParsedStr = [];
                var maxRecords = component.get('v.maxRecords');
                var maxCounter = 0;
                checkRes.forEach(function(targetLine) {
                    if(maxCounter < maxRecords) {
                        var parsedStr = JSON.parse(targetLine.resValue);
                        lstParsedStr.push(parsedStr);
                    }
                    maxCounter++;
                });

                component.set('v.dataTableList' , lstParsedStr);
                var checkDTlist = component.get('v.dataTableList');
                debugger;

                var cols = res.lstColumnDisplay;
                var lstCols = [];
                var i = 0;
                var j = 0;
                cols.forEach(function(colLine) {
                    debugger;
                    var parsedStr = JSON.parse(colLine);
                    if(parsedStr.fieldName == 'Id') {
                        parsedStr.type = 'url';
                        j = i+1;
                        if(cols[j] != undefined) {
                            parsedStr.label = JSON.parse(cols[j]).label;
                            parsedStr["typeAttributes"] =  {label: { fieldName: JSON.parse(cols[j]).fieldName }, target:'_blank'};
                            var colj = JSON.parse(cols[j]).fieldName;
                            debugger;
                        }
                    }
                    if(colLine != cols[j]) {
                        lstCols.push(parsedStr);
                    }
                    i++;
                });
                component.set("v.columns", lstCols);
                var chkColumns = component.get("v.columns");
                debugger;
                // End Updated today
                component.set('v.relationshipName',res.relationshipName);
                console.log('Rel >>> ',component.get('v.relationshipName'));
                
                component.set('v.cardTitle', res.objectLabel);
                console.log('Object Label >>> ',component.get('v.cardTitle'));
                
                component.set('v.iconUrl', res.objectIcon);
                console.log('Object Icon >>> ',component.get('v.iconUrl'));
                
                component.set('v.recordList',res.recordList);
                //component.set('v.fieldSetListDisplay',res.fieldSetListDisplay);
                //component.set('v.fieldSetListQuery',res.fieldSetListQuery);
                //component.set('v.lstNewRecordFieldAPIName',res.lstNewRecordFieldAPIName);
                //component.set('v.lstNewRecordFieldLabel',res.lstNewRecordFieldLabel);
                component.set('v.displayLink', res.moreRows);
                /*
                var recordList = res.recordList;                
                var mainMap = res.resultantMap;
                var innerList = [];
                var outerList = [];
                */
                /*for(var i = 0 ; i < recordList.length ; i++) {
                    var ckeckId = recordList[i].Id;
                    innerMap.push(mainMap[recordList[i].Id]);
                }*/
                /*
                var i = 0;
                var maxRecords = component.get('v.maxRecords');
                console.log('maxRecords'+maxRecords);
                for ( var key in mainMap ) {
                    if(i < maxRecords) {
                        var checkKey = mainMap[key];
                        //innerMap.push(mainMap[key]);
                        innerList = [];
                        for ( var keys in checkKey ) {
                            var checkValue = checkKey[keys];
                            if(checkValue == 'null') {
                                checkValue = checkValue.replace(null,''); 
                                console.log('In NUll - checkValue >>> ',checkValue);
                            }
                            else if(checkValue != null) {
                                checkValue = checkValue.replace(/[""]/g, "");
                                //checkValue = checkValue.replace(/[^a-zA-Z0-9\s]/g, "").replace(/\s\s/g, " ");
                                console.log('In Not NULL - checkValue >>> ',checkValue);
                            }
                            var recIdKey = key.replace(/[""]/g, "");
                            innerList.push({value:checkValue, key:keys, recId:recIdKey});
                        }
                        outerList.push(innerList);
                        i++;
                    }
                }
                
                component.set('v.outerList',outerList);
                var checkOuterList = component.get('v.outerList'); 
                debugger;
                component.set('v.resultantMap',res.resultantMap);
                */
                //var checkList = component.get('v.recordList');
                //var checkFields = component.get('v.fieldSetList');
                //var checkfieldSetListDisplay = component.get('v.fieldSetListDisplay');
                //var checkfieldSetListQuery = component.get('v.fieldSetListQuery');
                //var checkResultantMap = component.get('v.resultantMap');
            }
            else if (state === "ERROR") {
                var errors = response.getError();
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
    sortData: function (cmp, fieldName, sortDirection) {
        var data = cmp.get("v.dataTableList");
        var reverse = sortDirection !== 'asc';
        //sorts the rows based on the column header that's clicked
        data.sort(this.sortBy(fieldName, reverse))
        cmp.set("v.dataTableList", data);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
            function(x) {return x[field]};
        //checks if the two rows should switch places
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    }
})
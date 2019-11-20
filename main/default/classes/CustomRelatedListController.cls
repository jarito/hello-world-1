public class CustomRelatedListController extends VisualEditor.DynamicPickList {
	@AuraEnabled
    public static Id getContactId(Id idCaseNum) {
        Case objCase = [Select Id, ContactId from Case where Id = : idCaseNum LIMIT 1];
        return objCase.ContactId;
    }
    
    public override VisualEditor.DataRow getDefaultValue() {
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Case', 'Cases');
        return defaultValue;
    }

    public override VisualEditor.DynamicPickListRows getValues() {
		VisualEditor.DynamicPickListRows pickListValues = new VisualEditor.DynamicPickListRows();
        List<Schema.ChildRelationship> lstchildrelationships = Schema.getGlobalDescribe().get('Contact').getDescribe().getChildRelationships();
        String displayLable;
        for(Schema.ChildRelationship obj : lstchildrelationships) {
            Schema.DescribeSObjectResult childObjectResult = obj.getChildSObject().getDescribe(); //API name of child 
            String objType = String.valueOf(obj.getChildSObject()); //convert Sobject to string
            String labelName = childObjectResult.getLabel();
            String relationshipLabel = obj.getRelationshipName();
            SObjectField relField = obj.getField();            
            //separting __c from custom field API name
            if(String.valueOf(relField).contains('__c')){
                displayLable = labelName+' - '+String.valueOf(relField).replace('__c','').replace('_',' ');
            }
            else{
               displayLable = labelName+' - '+String.valueOf(relField);
            }
            VisualEditor.dataRow pickListRowValue = new VisualEditor.dataRow(displayLable,relationshipLabel);
            if(pickListRowValue.getValue() != null){
                pickListValues.addRow(pickListRowValue);
            }           
        }        
        return pickListValues;
    }
    
    public static String getIconUrl(String objAPIName)
    {
    	String iconUrl;
    	
     	List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();    	
		for(Schema.DescribeTabSetResult tsr : tabSetDesc) 
		{
			List<Schema.DescribeTabResult> tabs = tsr.getTabs();		
			for(Schema.DescribeTabResult tr : tabs)
			{
				if (tr.getSobjectName() == objAPIName)
				{
					List<Schema.DescribeIconResult> icons = tr.getIcons();					
					for (Schema.DescribeIconResult ir : icons)
					{	 
						if (ir.getContentType() == 'image/svg+xml')
						{
							iconUrl = ir.getUrl();
							break;
						}
					}		           
				}			
			}			
		}
		
			
		if (iconUrl != null && iconUrl.contains('custom')) 
		{
			Integer s = iconUrl.indexOf('/custom/') + '/custom/'.length();
			Integer e = iconUrl.length() - 4;
			
			iconUrl = 'custom:' + iconUrl.substring(s, e);
		}
		
		if (iconUrl != null && iconUrl.contains('standard')) 
		{
			Integer s = iconUrl.indexOf('/standard/') + '/standard/'.length();
			Integer e = iconUrl.length() - 4;
			
			iconUrl = 'standard:' + iconUrl.substring(s, e);		
		}
		 
    	return iconUrl;	
	}

  

    @AuraEnabled
    public static CustomRelatedListController.WrapperClass getRecordListAndFieldSet(String sObjectName , String contactId, String fieldSetInput, String maxRecords, String fieldNameForSort, String order) {
        System.debug('fieldNameForSort >>>> '+fieldNameForSort+'  >>>> order >>>'+order);
        
        //Getting selected value from picklist
        Schema.SObjectType objectType;
        String objTypeStr;        
        String objLabel; 
        String objIcon;
        Boolean moreRows = false;
        
        List<Schema.ChildRelationship> lstchildrelationships = Schema.getGlobalDescribe().get('Contact').getDescribe().getChildRelationships(); 
        for(Schema.ChildRelationship obj : lstchildrelationships) {
         String test = obj.getRelationshipName();     
         
 	         if(test!=null && test.equals(sObjectName))
 	         {
 	      	 	objectType = obj.getChildSObject();
            	objTypeStr = String.valueOf(objectType);
               	objLabel = objTypeStr.replace('__c','').replace('_',' ');      
                objIcon = getIconUrl(objTypeStr);
                 
                Map <String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objTypeStr).getDescribe().fields.getMap();
                List<String> fieldAPINames = new List<String>();
                for(Schema.SObjectField sfield : fieldMap.Values()){
                    fieldAPINames.add(sfield.getDescribe().getName());
                }
                if(!fieldAPINames.contains(fieldNameForSort)){
                    fieldNameForSort = 'Id';
                }
               	break;
             } 
        }
        
        // Field Set retrived through Design Attribute- starts here              
        List<FieldSetMemberWrapperClass> wrapperList = new List<FieldSetMemberWrapperClass>();
        Schema.SObjectType childObjDescribe = Schema.getGlobalDescribe().get(objTypeStr);
        List<String> fieldSetListDisplay = new List<String>();
        List<String> lstColumnDisplay = new List<String>();
        List<String> fieldSetListQuery = new List<String>();
        fieldSetListQuery.add('Id');
        lstColumnDisplay.add('{ "label" : "Id" , "fieldName" : "Id", "type" : "text", "sortable" : true, "cellAttributes" : { "alignment" : "left" }}');
        String fieldNames = '';
        String defaultFieldName;
        if(fieldSetInput != null && childObjDescribe!=null && childObjDescribe.getDescribe().fieldSets.getMap().get(fieldSetInput)!=null) {
            for(Schema.FieldSetMember fieldMember : childObjDescribe.getDescribe().fieldSets.getMap().get(fieldSetInput).getFields()){
                FieldSetMemberWrapperClass wrapper = new FieldSetMemberWrapperClass();
                wrapper.isRequired = fieldMember.getRequired();
                wrapper.fieldType = String.valueOf(fieldMember.getType());
                wrapper.fieldLabel = fieldMember.getLabel();
                fieldSetListDisplay.add(fieldMember.getLabel()); //get fields labels to display on related list
                wrapper.fieldAPIName = fieldMember.getFieldPath();
                if(!fieldMember.getFieldPath().equalsIgnoreCase('Id')) {
                    if(!String.valueOf(fieldMember.getType()).equalsIgnoreCase('reference')) {
                        fieldSetListQuery.add(fieldMember.getFieldPath()); // get fields API names to feed into query.   
                    } else {
                        Schema.DescribeFieldResult descResult = fieldMember.getSObjectField().getDescribe();
                        System.debug('descResult.getRelationshipName()'+descResult.getRelationshipName());
                        fieldSetListQuery.add(descResult.getRelationshipName()+'.Name');
                    }
                }
                Schema.DisplayType objFieldType = fieldMember.getType();
                String strFieldType = 'text';
                if(String.valueOf(objFieldType).equalsIgnoreCase('string') || String.valueOf(objFieldType).equalsIgnoreCase('picklist') || 
                    String.valueOf(objFieldType).equalsIgnoreCase('address') || String.valueOf(objFieldType).equalsIgnoreCase('base64') ||
                    String.valueOf(objFieldType).equalsIgnoreCase('textarea') || String.valueOf(objFieldType).equalsIgnoreCase('reference') ||
                    String.valueOf(objFieldType).equalsIgnoreCase('encryptedstring') || String.valueOf(objFieldType).equalsIgnoreCase('multipicklist') ||
                    String.valueOf(objFieldType).equalsIgnoreCase('time')) {
                    strFieldType = 'text';
                } else if(String.valueOf(objFieldType).equalsIgnoreCase('date')) {
                    strFieldType = 'date-local';
                } else if(String.valueOf(objFieldType).equalsIgnoreCase('datetime')) {
                    strFieldType = 'date';
                } else if(String.valueOf(objFieldType).equalsIgnoreCase('double') || String.valueOf(objFieldType).equalsIgnoreCase('integer') ||
                    String.valueOf(objFieldType).equalsIgnoreCase('long')) {
                    strFieldType = 'number';
                } else {
                    strFieldType = String.valueOf(objFieldType).toLowerCase();
                }

                if(!String.valueOf(fieldMember.getType()).equalsIgnoreCase('reference')) {
                    lstColumnDisplay.add('{ "label" : "'+fieldMember.getLabel()+'" , "fieldName" : "'+fieldMember.getFieldPath()+'", "type" : "'+ strFieldType +'", "sortable" : true, "cellAttributes" : { "alignment" : "left" }}');
                } else {
                    Schema.DescribeFieldResult descResult = fieldMember.getSObjectField().getDescribe();
                    System.debug('descResult.getRelationshipName()'+descResult.getRelationshipName());

                    lstColumnDisplay.add('{ "label" : "'+fieldMember.getLabel()+'" , "fieldName" : "'+descResult.getRelationshipName()+'.Name'+'", "type" : "'+ strFieldType +'", "sortable" : true, "cellAttributes" : { "alignment" : "left" }}');
                }
                
                if(String.valueOf(fieldMember.getType()) == 'PICKLIST' || 
                   String.valueOf(fieldMember.getType()) == 'MULTIPICKLIST'){
                       wrapper.pickListValues = childObjDescribe.getDescribe().fields.getMap().get(fieldMember.getFieldPath())
                           .getDescribe().getPicklistValues();
                   }
                wrapperList.add(wrapper);
            }   
            System.debug('sObjectName in IF>>>>> '+sObjectName);
        }
        else {
            defaultFieldName = getNameUniqueField(objectType);
            List<String> splitResult = defaultFieldName.split(',');
            fieldSetListDisplay.add(splitResult[1]);
            fieldSetListQuery.add(splitResult[0]);
            System.debug('defaultFieldName >>>>> '+defaultFieldName);
            System.debug('splitResult >>>>> '+splitResult);
            System.debug('fieldSetListDisplay >>>>> '+fieldSetListDisplay+'  >>> fieldSetListQuery >>> '+fieldSetListQuery);
            System.debug('sObjectName in ELSE>>>>> '+sObjectName);
            
        }
        //Field Set retrived through Design Attribute - Ends here
        // Query formation starts here
        for(String str : fieldSetListQuery) 
        {
            if (fieldNames!=null && fieldNames != '' && fieldNames.length() > 0) fieldNames = fieldNames + ' , ' +  str;
            else fieldNames = str;
        } 
        
        // Query Formation ends here



		//Field Set retrived through Design Attribute - Ends here
        //String queryToExecute = 'SELECT Id, (SELECT '+fieldNames+' FROM '+sObjectName+' LIMIT '+(Integer.valueOf(maxRecords) + 1)+') FROM Contact WHERE Id = : contactId';
        String queryToExecute = 'SELECT Id, (SELECT '+fieldNames+' FROM '+sObjectName+ ' ORDER BY '+fieldNameForSort+' '+order+' LIMIT '+(Integer.valueOf(maxRecords) + 1)+') FROM Contact WHERE Id = : contactId ';
        System.debug('queryToExecute Final>>>>> '+queryToExecute);
        List<Object> lstRecords = new List<Object>();
        List<Contact> lstContactRecords = Database.Query(queryToExecute); 
        System.debug('lstContactRecords >>>>> '+lstContactRecords);
        for(Contact objContact : lstContactRecords) {
            String str = JSON.serialize(objContact);        
            Map<String, Object> parentMap = (Map<String, Object>)JSON.deserializeUntyped(str);        
            Map<String, Object> childMap = (Map<String, Object>) parentMap.get(sObjectName);        
            if (childMap!=null) 
            {
            	List<Object> childRecordsList = (List<Object>) childMap.get('records');
            	lstRecords.addAll(childRecordsList);
                
                if(childRecordsList.size() > Integer.valueOf(maxRecords)) {
                    moreRows = true;
                }

            }
        }
                
        System.debug('lstRecords>>>>>  '+lstRecords);
        Map<String,String> innerMap;
        Map<String,Map<String,String>> resultantMap = new Map<String,Map<String,String>>();
        for(Object obj : lstRecords) {
            innerMap = new Map<String,String>();
            Map<String,Object> data = ( Map<String,Object>)obj;
            system.debug('data>>>>>>'+data);
            for(String str : fieldSetListQuery) {
                System.debug('str.split'+str.split('\\.'));
                if(!str.split('\\.').isEmpty() && str.split('\\.').size() > 1) {
                    List<String> lstKeys = str.split('\\.');
                    String strKey = lstKeys.get(0);
                    String strVal = lstKeys.get(1);

                    Map<String, Object> innerObjMap = (Map<String, Object>)data.get(strKey);
                    System.debug('innerObjMap>>>>>'+innerObjMap);
                    if(innerObjMap != null && !innerObjMap.isEmpty() && innerObjMap.containsKey(strVal)) {
                        innerMap.put(str, JSON.serialize(innerObjMap.get(strVal)));
                    } else {
                        innerMap.put(str, '');
                    }
                } else {
                    innerMap.put(str, JSON.serialize(data.get(str)));
                }
            }
            System.debug('innerMap>>>>>'+innerMap);
            resultantMap.put(JSON.serialize(data.get('Id')), innerMap);
        }


        //Updates of today starts here
        List<DataTableWrapper> objdTableList = new List<DataTableWrapper>();
        DataTableWrapper objWrp;
        String wrpInstanceString;
        for(Object obj : lstRecords) {
            Map<String,Object> data = ( Map<String,Object>)obj;
            wrpInstanceString = '{';
            for(String str : fieldSetListQuery) {
                if(str.equalsIgnoreCase('Id')) {
                    
                    wrpInstanceString += '"'+str+'":'+JSON.serialize('/lightning/r/'+ sObjectName +'/'+ data.get(str) + '/view')+',';
                } else if(!str.split('\\.').isEmpty() && str.split('\\.').size() > 1) {
                    List<String> lstKeys = str.split('\\.');
                    String strKey = lstKeys.get(0);
                    String strVal = lstKeys.get(1);

                    Map<String, Object> innerObjMap = (Map<String, Object>)data.get(strKey);
                    System.debug('innerObjMap>>>>>'+innerObjMap);
                    if(innerObjMap != null && !innerObjMap.isEmpty() && innerObjMap.containsKey(strVal)) {
                        wrpInstanceString += '"'+str+'":'+JSON.serialize(innerObjMap.get(strVal))+',';
                    } else {
                        wrpInstanceString += '"'+str+'":"",';
                    }
                } else {
                    wrpInstanceString += '"'+str+'":'+JSON.serialize(data.get(str))+',';
                }
            }
            wrpInstanceString = wrpInstanceString.removeEnd(',');
            wrpInstanceString = wrpInstanceString + '}';
            System.debug('String >>>>> '+wrpInstanceString);
            objWrp = new DataTableWrapper();
            objWrp.resValue = wrpInstanceString;
            objdTableList.add(objWrp);
            System.debug('List of Wrapper >>>>>'+objdTableList);
        }        

        //Updates of today ends here

        
        //Create a of list of fields with API Name and Label respectively for creating new records - starts here
        List<String> lstNewRecordFieldAPIName = new List<String>();
        List<String> lstNewRecordFieldLabel = new List<String>();
        Schema.DescribeSObjectResult ObjResult = objectType.getDescribe();
        Map<String, Schema.SObjectField> mapFields = ObjResult.Fields.getMap();
        for(Schema.SObjectField objField : mapFields.values()) {
            if(!objField.getDescribe().isNillable() && !objField.getDescribe().isDefaultedOnCreate()) {
                lstNewRecordFieldAPIName.add(objField.getDescribe().getName());
                lstNewRecordFieldLabel.add(objField.getDescribe().getLabel());
            }
        }
        System.debug('lstNewRecordFieldAPIName BEFORE MERGE>>>> '+lstNewRecordFieldAPIName);
        System.debug('lstNewRecordFieldLabel BEFORE MERGE>>>>> '+lstNewRecordFieldLabel); 
        lstNewRecordFieldAPIName.addAll(fieldSetListQuery);
        lstNewRecordFieldLabel.addAll(fieldSetListDisplay);
        System.debug('lstNewRecordFieldAPIName AFTER MERGE>>>> '+lstNewRecordFieldAPIName);
        System.debug('lstNewRecordFieldLabel AFTER MERGE>>>>> '+lstNewRecordFieldLabel);
        //Create a of list of fields with API Name and Label respectively for creating new records - starts here
        
        WrapperClass objWrapperClass = new WrapperClass(); 
        objWrapperClass.lstDataTableWrapper = objdTableList;
        objWrapperClass.fieldSetListDisplay = fieldSetListDisplay;
        objWrapperClass.fieldSetListQuery = fieldSetListQuery;
        objWrapperClass.lstNewRecordFieldAPIName = lstNewRecordFieldAPIName;
        objWrapperClass.lstNewRecordFieldLabel = lstNewRecordFieldLabel;
        objWrapperClass.recordList = lstRecords;        
        objWrapperClass.relationShipName = sObjectName;
        objWrapperClass.objectLabel = objLabel;
        objWrapperClass.objectIcon = objIcon;
        objWrapperClass.resultantMap = resultantMap;
        objWrapperClass.moreRows = moreRows;
        objWrapperClass.lstColumnDisplay = lstColumnDisplay;
        return objWrapperClass; 
    }

    //Method to find Name Field or Unique Field of a specific object
    public static String getNameUniqueField(Schema.sObjectType objectType) {
        String strResult = null;
        String strLabel = null;
        String strName = null;
        Schema.DescribeSObjectResult ObjResult = objectType.getDescribe();
        Map<String, Schema.SObjectField> mapFields = ObjResult.Fields.getMap();
        for(Schema.SObjectField objField : mapFields.values()) {
            if(objField.getDescribe().isNameField()) {
                strName = objField.getDescribe().getName();
                strLabel = objField.getDescribe().getLabel();
                strResult = strName + ',' + strLabel;
                break;
            }
        }
    	if(strResult != null)
        return strResult;
    
        for(Schema.SObjectField objField : mapFields.values()) {
            if(objField.getDescribe().isAutoNumber())	{
                strName = objField.getDescribe().getName();
                strLabel = objField.getDescribe().getLabel();
                strResult = strName + ',' + strLabel;
                break;
            }
        }
    	if(strResult != null)
        return strResult;
        
        for(Schema.SObjectField objField : mapFields.values()) {
            if(objField.getDescribe().isUnique())	{
                strName = objField.getDescribe().getName();
                strLabel = objField.getDescribe().getLabel();
                strResult = strName + ',' + strLabel;
                break;
            }
        } 
        System.debug('Final String Concatnated >>> '+strResult);
        return strResult;
    }

    public class DataTableWrapper {
        @AuraEnabled public String resValue;
        public DataTableWrapper(){}
        public DataTableWrapper( String resValueParam) {
            resValue = resValueParam;
        }
    }
    
    public class FieldSetMemberWrapperClass {
        @AuraEnabled public Boolean isRequired 						  { get; set; }
        @AuraEnabled public String fieldType 						  { get; set; }
        @AuraEnabled public String fieldLabel 						  { get; set; }
        @AuraEnabled public String fieldAPIName 					  { get; set; }
        @AuraEnabled public List<Schema.PicklistEntry> pickListValues { get; set; }
	}
	
    public class WrapperClass{
        @AuraEnabled public List <DataTableWrapper> lstDataTableWrapper;
        @AuraEnabled public List <String> fieldSetListDisplay;
        @AuraEnabled public List <String> fieldSetListQuery;
        @AuraEnabled public List <String> lstNewRecordFieldAPIName;
        @AuraEnabled public List <String> lstNewRecordFieldLabel;
        @AuraEnabled public List <String> lstColumnDisplay;
        @AuraEnabled public List <Object> recordList;
        @AuraEnabled public String relationShipName;
        @AuraEnabled public String objectLabel;
        @AuraEnabled public String objectIcon;        
        @AuraEnabled public Map<String,Map<String,String>> resultantMap;
        @AuraEnabled public Boolean moreRows;
        public WrapperClass(){}	
        public WrapperClass(List <DataTableWrapper> lstDataTableWrapperParam , List <String> fieldSetListDisplayParam ,List <String> fieldSetListQueryParam, List <String> lstColumnDisplayParam, List <Object> recordListParam, String relationShipNameParam, String objectLabelParam, String objectIconParam, Map<String,Map<String,String>> resultantMapParam , List <String> lstNewRecordFieldAPINameParam, List <String> lstNewRecordFieldLabelParam, Boolean moreRowsParam){  
           lstDataTableWrapper = lstDataTableWrapperParam;
           fieldSetListDisplay = fieldSetListDisplayParam;
           fieldSetListQuery = fieldSetListQueryParam;
           recordList = recordListParam;
           relationShipName = relationShipNameParam;
           objectLabel = objectLabelParam;
           objectIcon = objectIconParam;
           resultantMap = resultantMapParam;
           lstNewRecordFieldAPIName = lstNewRecordFieldAPINameParam;
           lstNewRecordFieldLabel = lstNewRecordFieldLabelParam;
           lstColumnDisplay = lstColumnDisplayParam;
           moreRows = moreRowsParam;
        } 
    }



}
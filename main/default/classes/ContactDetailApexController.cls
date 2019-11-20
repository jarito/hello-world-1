public class ContactDetailApexController extends VisualEditor.DynamicPickList{

    @AuraEnabled
    public static Id getContactId(Id idCaseNum) {
        Case objCase = [Select Id, ContactId from Case where Id = : idCaseNum LIMIT 1];
        return objCase.ContactId;
    }
    
    @AuraEnabled
    public static String getFieldSetMember(String strFieldSetName, Integer numColumns){
        System.debug('In APEX');
        List<FieldSetMemberWrapperClass> wrapperList = new List<FieldSetMemberWrapperClass>();
        Schema.SObjectType sObj = Schema.getGlobalDescribe().get('Contact');
        
        for(Schema.FieldSetMember fieldMember : sObj.getDescribe().fieldSets.getMap().get(strFieldSetName).getFields()){
            FieldSetMemberWrapperClass wrapper = new FieldSetMemberWrapperClass();
            wrapper.isRequired = fieldMember.getRequired();
            wrapper.fieldType = String.valueOf(fieldMember.getType());
            wrapper.fieldLabel = fieldMember.getLabel();
            wrapper.fieldAPIName = fieldMember.getFieldPath();
            if(String.valueOf(fieldMember.getType()) == 'PICKLIST' || 
               				String.valueOf(fieldMember.getType()) == 'MULTIPICKLIST'){
                wrapper.pickListValues = sObj.getDescribe().fields.getMap().get(fieldMember.getFieldPath())
                    									   .getDescribe().getPicklistValues();
            }
            wrapperList.add(wrapper);
        }
        
        if(Math.mod(wrapperList.size(), numColumns) != 0) {
            Integer intNumFields = 1;
            do{
                FieldSetMemberWrapperClass wrapper = new FieldSetMemberWrapperClass();
                wrapper.fieldLabel = '.';
                wrapper.fieldAPIName = 'Blank_Field'+intNumFields+'__c';
                intNumFields++;
                wrapperList.add(wrapper);
            } while(Math.mod(wrapperList.size(), numColumns) != 0);
        }
        System.debug('#### wrapperList '+wrapperList);
        
        return JSON.serialize(wrapperList);
    }

    public override VisualEditor.DataRow getDefaultValue() {
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Case', 'Case');
        return defaultValue;
    }

    public override VisualEditor.DynamicPickListRows getValues() { 
        VisualEditor.DynamicPickListRows pickListValues = new VisualEditor.DynamicPickListRows();
        SObjectType objObjectType = Schema.getGlobalDescribe().get('Contact');
        //It gives object properties or describe results
        Schema.DescribeSObjectResult   describeresult = objObjectType.getDescribe();
        List<Schema.ChildRelationship>   lstchildrelationships =describeresult.getChildRelationships();
        for(Schema.ChildRelationship obj : lstchildrelationships) {
            
            Schema.SObjectType objectType = obj.getChildSObject();
            String objType = String.valueOf(objectType);
            Schema.DescribeSObjectResult objDescribeResult = objectType.getDescribe();
            String labelName = objDescribeResult.getLabel();
            
            VisualEditor.dataRow pickListRowValue = new VisualEditor.dataRow(labelName , objDescribeResult.getName());
            pickListValues.addRow(pickListRowValue);
            system.debug('labelName >> '+labelName);
            system.debug('objectType >> '+objectType);
            system.debug('objDescribeResult.getName() >> '+objDescribeResult.getName());
        }
        return pickListValues;
    }
   
    public class FieldSetMemberWrapperClass{
        
        @AuraEnabled
        public Boolean isRequired 						 { get; set; }
        @AuraEnabled
        public String fieldType 						 { get; set; }
        @AuraEnabled
        public String fieldLabel 						 { get; set; }
        @AuraEnabled
        public String fieldAPIName 					     { get; set; }
        @AuraEnabled 
        public List<Schema.PicklistEntry> pickListValues { get; set; }
        
    }

}
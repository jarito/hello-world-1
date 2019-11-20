/** 
 * Class which maps the fields of Custom object ManageEvent and creates a new event 
 * based on record of custom object ManageEvent 
 */
global  class DynamicObjectCreation implements Database.Batchable<sObject> {
   /**
	* This method collects the record of Custom object ManageEvent and passes it to execute method
	* It returns a list of records to execute method
	*/
	global Database.QueryLocator start(Database.BatchableContext bc){	
		return database.getQueryLocator( [Select 
												Json__c,
												Object__c,
												Processed__c
										  From
										 		ManageEvent__c
										  Where
										  		Processed__c = FALSE
									   ] );
	}

   /**
	* This method collects the record of Custom object ManageEvent from Start method and contains 
	* the processing logic. 
	* It creates new Object Dynamically based on the value of field 'Object__c' on ManageEvent custom 
	* Object. 
	* Field 'Object__c' contains the name of the object which is to be created dynamically. 
	* The fields for the new object are decided based on the value of custom field named 'Json__c'
	* on ManageEvent Custom object. 
	* This field 'Json__c' contains the value in Json format which is nothing but key-value pair 
	* indicating field and its value. 
	* All the compulsory fields of respective objects must be present as input in 'Json__c' 
	* @param	List eventList  
	*/
	global void execute(Database.BatchableContext bc , List<ManageEvent__c> eventList  ){
		Map<String,String> mapOfNewObjectFields = new Map<String,String>();
	   /**
		* In the for loop below, the value in Json format in 'Json__c' field from ManageEvent
		* is deserialized and stored in a Map named 'mapOfNewObjectFields' declared above
		*/	
		for(ManageEvent__c eachEvent : eventList){
			mapOfNewObjectFields = (Map<String,String>)JSON.deserialize(eachEvent.Json__c , Map<String,String>.class );
		 	system.debug('-------Map------'+mapOfNewObjectFields.KeySet());
		}
	   /**
		* A list a created to hold the list of newly created dynamic sObjects
		*/
		List<sObject> sObjectList = new List<sObject>();
	    sObject sObjectInstance; 
		List<ManageEvent__c> manageObject = new List<ManageEvent__c>();
		for(ManageEvent__c eachField : eventList){
			
			String objectName = eachField.Object__c;
			eachField.Processed__c = TRUE ;
			System.debug('eachField---'+eachField.Processed__c);
			manageObject.add(eachField);
			System.debug('manageObject---'+manageObject);
		   /** 
			* Object Name mentioned in field 'Object__c' is retrived using standard method of Schema
			* class and new sObject is created using method 'newSObject()' dynamically.
			* Now, using the method 'put', the field and the value is specified for the new sObject. 
			*/
			sObjectInstance = Schema.getGlobalDescribe().get(objectName).newSObject();
			for(String fieldName : mapOfNewObjectFields.KeySet()){
				if(mapOfNewObjectFields.get(fieldName) != ''){
					String field = fieldName;
					String value = mapOfNewObjectFields.get(fieldName);
					sObjectInstance.put(field,value);
				}
			}
			sObjectList.add(sObjectInstance);
		}
	   /**
		* Actual list of sObjects is inserted here
		*/
		if(!sObjectList.isEmpty() /*&& !manageObject.isEmpty()*/){
			insert sObjectList;
			update manageObject;		
		}		
	}

	global void finish(Database.BatchableContext bc){
		
	}
}
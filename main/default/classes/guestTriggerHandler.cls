global  class guestTriggerHandler {
	global  void checkDuplicateEmail(List<Guest__c> listNewGuests, Map<Id,Guest__c> oldGuests){
        /* Map of Email Id and Guest__c object */
        Map<String , Guest__c> mapGuestsEmail = new Map<String , Guest__c>();
        for(Guest__c eachGuest : listNewGuests ){
            if((eachGuest.Email__c != null)  &&
               ( System.Trigger.isInsert || 
                (eachGuest.Email__c != oldGuests.get(eachGuest.Id).Email__c ))){
                    
                for(Guest__c guestObj : listNewGuests ){
                    if( ! mapGuestsEmail.containsKey(guestObj.Email__c)){
                        mapGuestsEmail.put(guestObj.Email__c,guestObj);
                    }
                }
                
                /*List of Email Ids which match with the Email IDs of inserted Guests */
                List<Guest__c> listOfGuests = [Select 
                                                	Email__c 
                                                From 
                                                	Guest__c 
                                                Where 
                                                	Email__c IN : mapGuestsEmail.keySet()];        
                
                /*If instance 'guestObject' gets some value from map and length of the List named 
                listOfGuests is greater than zero, implies their already exists a guest 
                with this Email Id and hence it will throw an error
                */ 
                for(Guest__c guestVar : listOfGuests){
                    Guest__c guestObject = mapGuestsEmail.get(guestVar.Email__c);
                    guestObject.Email__c.addError('A Guest with this email address already exists ');
                }
            }            
        }
	}
}
trigger GuestValidationTrigger on Guest__c (after update) {
    String newGuests = json.serialize(Trigger.NEW);
    //public static boolean check = false;
   //List<Guest__c> listObj = (List<Guest__c>)Json.deserialize(newGuests, List<Guest__c>.class);
    String guestID; 
    for(Guest__c eachGuest : Trigger.NEW){
        guestID = eachGuest.Id ; 
        //system.debug('LastName--->'+eachGuest.Last_Name__c);
        //system.debug('LastName--->'+eachGuest.Name);
    }
    if(!BooleanController.check){
        //GuestValidationTriggerHandler.validateGuestRecord(newGuests , guestID);
        //GuestValidationTriggerHandler.validateGuestRecordSoap(newGuests , guestID);
    }
}
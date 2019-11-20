trigger guestTrigger on Guest__c (before insert , before update) {
    guestTriggerHandler objGuestTriggerHandler = new guestTriggerHandler();
    objGuestTriggerHandler.checkDuplicateEmail(Trigger.New,Trigger.OldMap);
}
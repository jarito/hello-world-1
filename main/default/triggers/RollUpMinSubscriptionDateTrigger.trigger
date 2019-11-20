trigger RollUpMinSubscriptionDateTrigger on SBQQ__Subscription__c (after update) {
    if(Trigger.isAfter) {
        if(Trigger.isUpdate) { 
            System.debug('Update ***');
            RollUpMinSubscriptionDateHandler  objDateHandler = new RollUpMinSubscriptionDateHandler(); 
            objDateHandler.updateRenewedDate(Trigger.New);
        }
    }
}
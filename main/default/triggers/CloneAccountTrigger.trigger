/*This Trigger will become active or execute when new Account record will be inserted*/
trigger CloneAccountTrigger on Account (before delete) {
    system.debug('Inside Trigger');
    //if(TriggerSetting__c.getInstance().Run_Trigger__c){
        //CloneAccountTriggerHandler objectCloneAccountTriggerHandler = new CloneAccountTriggerHandler();
        //objectCloneAccountTriggerHandler.CloneNewAccount(Trigger.New);
    //}

}
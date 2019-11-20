trigger TestTrigger on Contact (before update) {
       system.debug('------------------------'+Trigger.New);
       
    system.debug('------------------------');

 
   // system.debug('------------------------'+Trigger.OldMap);

}
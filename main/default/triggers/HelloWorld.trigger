trigger HelloWorld on Account (before delete) {
 
    system.debug('------------------------');   
    system.debug(Trigger.New);
 system.debug('------------new map------------');   
    system.debug(Trigger.NewMap);
     system.debug('-----------OLD-------------');   
    system.debug(Trigger.Old);
     system.debug(Trigger.OldMap);
}
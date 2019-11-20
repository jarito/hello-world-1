trigger SystemDebug on Contact (after delete) {
	//system.debug(Trigger.New);
    system.debug(Trigger.Old);
   //system.debug(Trigger.NewMap);
    system.debug(Trigger.OldMap);
    
}
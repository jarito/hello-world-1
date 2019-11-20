trigger testNewMap on Lead (before delete) {
 		system.debug(Trigger.New);
        system.debug('================================');

        system.debug(Trigger.OldMap);

}
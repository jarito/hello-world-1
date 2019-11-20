trigger AvoidDuplicateContact on Contact (before insert,before update) {
	AvoidDuplicateContactHandler objAvoidDuplicate = new AvoidDuplicateContactHandler();
    /*if((Trigger.isBefore && Trigger.isInsert) ||(Trigger.isBefore && Trigger.isUpdate)  ){        
    	objAvoidDuplicate.checkDuplicate(Trigger.New,Trigger.OldMap);
        objAvoidDuplicate.AssociateAccountToContact(Trigger.New,Trigger.OldMap);
    }*/
    //objAvoidDuplicate.checkDuplicate(Trigger.New,Trigger.OldMap);
    //objAvoidDuplicate.AssociateAccountToContact(Trigger.New,Trigger.OldMap);

}
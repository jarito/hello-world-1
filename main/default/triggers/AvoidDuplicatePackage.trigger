trigger AvoidDuplicatePackage on Package__c (before insert) {
	AvoidDuplicatePackageHandler objectAvoidDuplicatePackageHandler = new AvoidDuplicatePackageHandler();
    objectAvoidDuplicatePackageHandler.checkDuplicate(Trigger.New);
}
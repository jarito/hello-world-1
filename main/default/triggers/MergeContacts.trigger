trigger MergeContacts on Relationship__c (after insert) {
    MergeContactsHandler objMergeContactsHandler = new MergeContactsHandler();
    objMergeContactsHandler.mergeContactsMethod(Trigger.New , Trigger.NewMap);
}
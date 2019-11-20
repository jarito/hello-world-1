/* This Trigger will get invoked when required Address details doesn't match */
trigger VerifyAddress on EFT_Transaction_Status__c (after insert) {
    VerifyAddressHandler objVerifyAddress = new VerifyAddressHandler();
    objVerifyAddress.VerifyAddressmethod(Trigger.New , Trigger.NewMap);
}
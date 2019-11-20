public class RollUpMinSubscriptionDateHandler { 
    public void updateRenewedDate(List<SBQQ__Subscription__c> lstSubscriptions) { 
        Map<Id, List<SBQQ__Subscription__c>> mapOfContractIdAndListSubscription = new Map<Id, List<SBQQ__Subscription__c>>();
        for(SBQQ__Subscription__c objSubscriptionInit : lstSubscriptions) {
            //Filling Map1
            System.debug('objSubscriptionInit.SBQQ__Contract__c >>>> '+objSubscriptionInit.SBQQ__Contract__c);
            if(mapOfContractIdAndListSubscription.containsKey(objSubscriptionInit.SBQQ__Contract__c)) {
                List<SBQQ__Subscription__c> tempSubscriptionList = mapOfContractIdAndListSubscription.get(objSubscriptionInit.SBQQ__Contract__c);
                tempSubscriptionList.add(objSubscriptionInit);
            } else { 
                List<SBQQ__Subscription__c> tempSubscriptionList = new List<SBQQ__Subscription__c>();
                tempSubscriptionList.add(objSubscriptionInit);
                mapOfContractIdAndListSubscription.put(objSubscriptionInit.SBQQ__Contract__c, tempSubscriptionList);
            }
        }    
        System.debug('Map 1 >>>  mapOfContractIdAndListSubscription >>>> '+mapOfContractIdAndListSubscription);
        
        if(!mapOfContractIdAndListSubscription.keySet().isEmpty()) {
            Map<ID, Date> mapOfContractIdAndMinRenewedDate = new Map<ID, Date>();
            for(ID objContractId : mapOfContractIdAndListSubscription.keySet()) { 
                //List<SBQQ__Subscription__c> lstSubscriptionsFromMap = mapOfContractIdAndListSubscription.get(objContractId);
                List<Date> lstRenewedDatesOfSubscriptions = new List<Date>();
                for(SBQQ__Subscription__c objSusbcriptionMap : mapOfContractIdAndListSubscription.get(objContractId)) {
                    if(objSusbcriptionMap.SBQQ__RenewedDate__c != null) {
                        lstRenewedDatesOfSubscriptions.add(objSusbcriptionMap.SBQQ__RenewedDate__c);
                    }
                } 
                if(!lstRenewedDatesOfSubscriptions.isEmpty()) {
                    lstRenewedDatesOfSubscriptions.sort();
                    mapOfContractIdAndMinRenewedDate.put(objContractId, lstRenewedDatesOfSubscriptions.get(0));
                }
            }
            System.debug('Map 2 >>>  mapOfContractIdAndMinRenewedDate >>>> '+mapOfContractIdAndMinRenewedDate);

            List<Contract> lstContractsToBeUpdated = new List<Contract>();
            for(ID objContractId : mapOfContractIdAndListSubscription.keySet()) {
                Contract objContract = new Contract();
                //Date minimumDate = mapOfContractIdAndMinRenewedDate.get(objContractId);
                objContract.Id = objContractId; 
                objContract.Minimum_Renewed_Date__c = mapOfContractIdAndMinRenewedDate.get(objContractId);
                lstContractsToBeUpdated.add(objContract);
            }

            if(!lstContractsToBeUpdated.isEmpty()) {
                Database.SaveResult[] srList = Database.update(lstContractsToBeUpdated, false);
            }
        }
    }
}
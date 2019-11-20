public with sharing class serverRecordList {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountlist() {
        return [SELECT 
                        Id, 
                        Name 
                 From 
                        Account];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey) {
        String key = '%' + searchKey + '%';
        List<Account> accountList = [Select Name From Account Where Name LIKE :key];
        for(Account accObj : accountList){
            system.debug('Record -->'+accObj.Id);
        }
        return [SELECT  Name FROM Account WHERE Name LIKE :key];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> findOpportunities(String recId) {
        List<Opportunity> opportunityList = [Select Id,
                                                    Name,
                                                    StageName,
                                                    Amount,
                                                    CloseDate,
                                                    (Select id,
                                                            OrderNumber,
                                                            TotalAmount,
                                                            Account.Name,
                                                            EffectiveDate,
                                                            Status 
                                                    From 
                                                            Orders) 
                                             From 
                                                    Opportunity 
                                             Where 
                                                    AccountId =: recId];
        for(Opportunity oppObj : opportunityList){
            system.debug('Record -->'+oppObj.Orders);
        }
        return opportunityList;
    }
}
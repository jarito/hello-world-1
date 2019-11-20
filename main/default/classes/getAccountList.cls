public class getAccountList {
	@AuraEnabled
    public static List<Account> getAccountLists(String searchText) {
        searchText='\'%' + String.escapeSingleQuotes(searchText.trim()) + '%\'';
        String query = 'Select Name,BillingCity,Type,Industry,Website From Account Where Name Like'+searchText;
        List<sObject> sobjList = Database.query(query);
        return sobjList;
    }
   
	@AuraEnabled
    public static List<Opportunity> getOpportunityList(String accountId) {
        Id accId = Id.valueOf(accountId);
        system.debug('ID is--->'+accId);
        Schema.SObjectType token = accId.getSObjectType();
        Schema.DescribeSObjectResult dr = token.getDescribe();
		String objName = dr.getName();
        system.debug('ObjectType is--->'+objName);
		List<Opportunity> opportunityList = [Select
                                            	Name,
                                            	StageName,
                                             	Amount,
                                            	CloseDate
                                             From
                                            	Opportunity
                                             Where
                                            	AccountId =: accountId];
        return opportunityList;
    }

	@AuraEnabled
    public static List<Account> getAccounts() {
        List<Account> accountList = [Select
                                    		Name,
                                    		Industry,
                                    		Website
                                     From
                                    		Account];
        return accountList;
    } 
    
	@AuraEnabled(cacheable=true)
    public static List<Order> getOrderList(String opportunityId) {
        Id accId = Id.valueOf(opportunityId);
        system.debug('ID is--->'+accId);
        Schema.SObjectType token = accId.getSObjectType();
        Schema.DescribeSObjectResult dr = token.getDescribe();
		String objName = dr.getName();
        system.debug('ObjectType is--->'+objName);       
        List<Order> orderList = [Select
                                    		OrderNumber,
                                    		TotalAmount,
                                 			Account.Name
                                     From
                                    		Order
                                     Where
                                            OpportunityId =: opportunityId];
        return orderList;
    }
    /*	public static List<Account> getAccounts() {
        List<Account> accountList = [Select Name,Website,BillingCity From Account];   
    	return accountList;
	}*/
}
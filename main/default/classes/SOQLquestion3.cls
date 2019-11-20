public with sharing class SOQLquestion3 {
	/* This function created a map of Account ID and Name of respective account*/
	public soqlQuestion3() {
		Map<ID,String> mapOfAccounts = new Map<ID,String>();
		/*List of Accounts*/
		List<Account> accountList = [Select Id, Name From Account ]; 
		for(Account accountVar : accountList){
			mapOfAccounts.put(accountVar.id, accountVar.Name);
		}
		system.debug(mapOfAccounts);

		system.debug('---------------------');

		Map<ID,Account> accountMap = new Map<ID,Account>();
		/*List of Accounts*/
		List<Account> accountLists = [Select Id, Name From Account ]; 
		for(Account accountVar : accountLists){
			accountMap.put(accountVar.id, accountVar);
		}
		system.debug(accountMap);

	}
}
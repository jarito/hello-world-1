public with sharing class InactiveAccounts90days {
	/* Method which contains logic to find all inactive accounts in last 90 days */
	public InactiveAccounts90days() {
		/* List of Inactive Accounts in Last 90 days */	
		List<Account> accountList = [Select 
										Name 
									From 
										Account 
									Where 
										CreatedDate = LAST_90_DAYS 
									And 
										Active__c='No'];
		system.debug('---------Accounts before Deletion------');
		for(Account accountVar : accountList){
			system.debug(accountVar);
		}
		/* Delete all the Inactive Accounts */
		delete accountList;
		/* List of Accounts after Deletion */
		system.debug('---------No Accounts Now------'+accountList);
		List<Account> deletedAccountList = [Select 
										Name 
									From 
										Account 
									Where 
										CreatedDate = LAST_90_DAYS 
									And 
										Active__c='No'];
		system.debug('---------Accounts after Deletion------');
		for(Account accountVar : deletedAccountList){
			system.debug(accountVar);
		}	
	}
}
public with sharing class AccountsCreatedToday {
	/* List of Accounts created Today */
	public accountsCreatedToday() {
		List<Account> todaysAccountList = [Select Id,Name From Account Where CreatedDate = Today];
		for(Account account : todaysAccountList){
			system.debug(account);
		}
	}
}
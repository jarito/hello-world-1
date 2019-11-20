public with sharing class AccountDetails {
	public void getAccountDetails() {
		/* Displaying Account Details using Advanced For loop */
		system.debug('Account Details using Advanced for loop: ');
		List<Account> accts = [SELECT Id, Name FROM Account LIMIT 10];
		for (Account a : accts) {
		   System.debug(a);
		}
		/* Displaying Account Details using Traditional For loop*/
		system.debug('Account Details using Traditional for loop: ');
		List<Account> accts1 = [SELECT Id, Name FROM Account LIMIT 5];
		for (Integer a = 0  ; a < accts1.size() ; a++) {
		   System.debug(accts1[a]);
		}

		/*Displaying Account Details using While loop*/
		system.debug('Account Details using While loop: ');
		List<Account> accts2 = [SELECT Id, Name FROM Account LIMIT 2];
		Integer i = 0;
		while ( i < accts2.size()) {
		    System.debug(accts2[i]);
			i++;
		}
	}
}
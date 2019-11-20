public with sharing class SOQLquestion4a {
	/*This method displays all accounts whose Enrollment year is 2010*/
	public soqlQuestion4a() {
		List <Account> accountList =   [Select 	
											Id, 
											Name, 
											Enrollment_Year__c 
										From 
											Account 
										Where Enrollment_Year__c  = '2010'];
		for(Account accountVar : accountList){
    	system.debug(accountVar);
		}
	}
}
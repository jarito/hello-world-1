public with sharing class SOQLquestion4b {
	/* This method displays all Account whose Enrollment year is 2013 or 2014*/
	public soqlQuestion4b() {
		List <Account> accountList =   [Select 
											Id, 
											Name, 
											Enrollment_Year__c 
										From 
											Account 
										Where 
											Enrollment_Year__c  Includes ('2013','2014')];
		for(Account accountVar : accountList){
    	system.debug(accountVar);
		}
	}
}
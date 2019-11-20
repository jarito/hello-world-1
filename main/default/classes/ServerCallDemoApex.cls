public class ServerCallDemoApex {
	@AuraEnabled
    public static List<Account> getAccounts(){
		List<Account> accountList = [SELECT Id, 
                                     		Name, 	
                                     		Website 
                                     FROM ACCOUNT 
                                     LIMIT 10];
        return accountList;
    }
    
    @AuraEnabled(cacheable = true)
    public static List<Contact> getContacts(){
		List<Contact> contactList = [SELECT Id, 
                                     		LastName, 	
                                     		FirstName, 
                                     		Account.Name 
                                     FROM Contact 
                                     LIMIT 10];
        return contactList;
    }    
}
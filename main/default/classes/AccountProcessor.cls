public class AccountProcessor {
    @future
    public static void countContacts(Set<Id> setId){
        List<Account> listAccount = [Select Id,Number_of_Contacts__c , (Select Id  From Contacts) From Account Where Id IN : SetId];
        for(Account eachAccount : listAccount){
            List<Contact> listContact = eachAccount.contacts;
            eachAccount.Number_of_Contacts__c = listContact.size();
        }
        update listAccount;
    }
}
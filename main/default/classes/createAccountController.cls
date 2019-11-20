public with sharing class createAccountController {

    @AuraEnabled
    public static Account saveAccount(Account account) {

        //Account newAccount = (Account)JSON.deserialize(Account, Account.class);
        Account newAccount = account;
        system.debug('Account Record >>>> '+newAccount);
        insert newAccount;
        return newAccount;
    }
}
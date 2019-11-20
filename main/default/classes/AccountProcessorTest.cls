@isTest
public class AccountProcessorTest {
    public static testMethod void  testAccountProcessorTest(){
        Test.startTest();
       	Account accountObject = new Account();
        accountObject.Name = 'TestAccount';
        insert accountObject;
        
        Contact contactObject1 = new Contact();
        contactObject1.LastName = 'TestContact1';
        contactObject1.AccountId = accountObject.Id;
        insert contactObject1;
 
        Contact contactObject2 = new Contact();
        contactObject2.LastName = 'TestContact2';
        contactObject2.AccountId = accountObject.Id;
        insert contactObject2;
        
        Set<Id> setAccountId = new Set<Id>();
		setAccountId.add(accountObject.Id);        
        
        AccountProcessor.countContacts(setAccountId);
        List<Account> accountList = [Select Id, Number_of_Contacts__c From Account Where Id =: accountObject.Id LIMIT 1];
        System.assertEquals(1,accountList.size());
        Test.stopTest();
    }
}
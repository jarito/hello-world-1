@isTest
public with sharing class GuestValidationTriggerHandlerTest {
    static testMethod void guestValidParameters(){
		List<Account> accountList = TestDataFactory.createSingleAccount();
        insert accountList;
        List<ID> listOfAccountIDs = new List<ID>();
        for(Account eachID : accountList)  {
            listOfAccountIDs.add(eachID.Id);
        }
        Set<ID> setOfAccountIDs = new Set<ID>(listOfAccountIDs);
        system.debug('---Account in Test class----'+accountList+'----------');        
		List<Contact> contactList = TestDataFactory.insertSingleContact(listOfAccountIDs);
        test.startTest();
        insert contactList;
        test.stopTest();
               
        system.debug('----Contact in Test class---'+contactList+'----------');
        for(Contact eachContact : contactList){
            system.assert(setOfAccountIDs.contains(eachContact.AccountId));
        }
    }	
}
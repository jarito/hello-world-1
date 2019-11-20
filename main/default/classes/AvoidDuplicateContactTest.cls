/**This class checks whether the trigger works right for
 * various scenarios
 */
@isTest
public class AvoidDuplicateContactTest {
	
    /** This Method checks whether the trigger works right for
	 *  Unique Email Id and Unique Phone Number
	 */
    static testMethod void singleContactCorrectInput(){
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
    /** This Method checks whether the trigger works right for Unique Email
	 *  Id and Unique Phone Number for 200 records
	 */
    static testMethod void bulkDomainCheck(){
        List<Account> accountList = TestDataFactory.insertTwoAccounts();
        insert accountList;
        List<ID> listOfAccountIDs = new List<ID>();
        for(Account eachID : accountList)  {
            listOfAccountIDs.add(eachID.Id);
        }
        Set<ID> setOfAccountIDs = new Set<ID>(listOfAccountIDs);
        List<Contact> contactList = TestDataFactory.insert200Contacts(listOfAccountIDs);
        test.startTest();
        insert contactList;
        test.stopTest();
        system.debug('----Contact in Test class---'+contactList+'----------');
        for(Contact eachContact : contactList){
            system.assert(setOfAccountIDs.contains(eachContact.AccountId));
        }        
    }    
    
    /** This Method checks whether the trigger works right for
	 *  Duplicate Email Id 
     */   
    static testMethod void duplicateEmailID(){
		List<Contact> listOfContacts = TestDataFactory.insertThreeContacts();
		Set<String> emailSet = new Set<String>();
        for(Contact eachContact : listOfContacts){
            emailSet.add(eachContact.Email);
        }
        
        test.startTest();
        insert listOfContacts;
        test.stopTest();
        system.assertEquals(2,emailSet.size(),'Duplicate EmailIds' );
	}
    
    /** This Method checks whether the trigger works right for
	 *  Duplicate Email Id for 200 records
     */  	
    static testMethod void bulkDuplicateEmailIds(){
        List<Contact> bulkContacts = TestDataFactory.insertBulkContacts();
        insert bulkContacts;
		Set<String> emailSet = new Set<String>();
        for(Contact eachContact : bulkContacts){
            emailSet.add(eachContact.Email);
        } 
        test.startTest();
		database.insert (bulkContacts,false);        
        test.stopTest();
        system.assertEquals(102,emailSet.size(),'Duplicate EmailIds' );
    }
        
    /** This Method checks whether the trigger works right for
	 *  Duplicate Phone 
     */ 
    static testMethod void DuplicatePhoneNumber(){
		List<Contact> listOfContacts = TestDataFactory.insertThreeContacts();
		Set<String> phoneSet = new Set<String>();
        for(Contact eachContact : listOfContacts){
            phoneSet.add(eachContact.Phone);
        }
        test.startTest();
        insert listOfContacts;
        test.stopTest();
        system.assertEquals(2,phoneSet.size(),'Duplicate EmailIds' );        
    }
    
    /** This Method checks whether the trigger works right for
	 *  Duplicate Phone for 200 records
     */    
   static testMethod void bulkDuplicatePhone(){
        List<Contact> bulkContacts = TestDataFactory.insertBulkContacts();
        insert bulkContacts;
		Set<String> phoneSet = new Set<String>();
        for(Contact eachContact : bulkContacts){
            phoneSet.add(eachContact.Email);
        } 
        test.startTest();
		database.insert (bulkContacts,false);        
        test.stopTest();
        system.assertEquals(102,phoneSet.size(),'Duplicate EmailIds' );
    }

    /** This Method checks whether the trigger works right for
	 *  blank Email ID or No Email ID
     */    
    static testMethod void noEmailId(){
		List<Contact> contactList = TestDataFactory.insertOneContactNoEmail();
        test.startTest();
        insert contactList;
        test.stopTest();

        List<Contact> checkListOfContacts = [Select LastName from Contact];
        for(Contact eachContact : checkListOfContacts){
	        system.assertEquals('', eachContact.Email,'Email ID is Null');
        }
        system.assertNotEquals(1, checkListOfContacts.size(),'Email ID is Null');
      }  

    /** This Method checks whether the trigger works right for
	 *  Invalid Email ID or No Email ID
     */        
    static testMethod void invalidEmailId(){
    	List<Contact> listOfContacts = TestDataFactory.insertOneContactInValidEmail(); 
        test.startTest();
        insert listOfContacts;
        test.stopTest();

        List<Contact> checkListOfContacts = [Select LastName from Contact];
        system.assertNotEquals(1, checkListOfContacts.size(),'Invalid Email ID');
      }    
    
}
@isTest
public class guestTriggerHandlerTest {
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
}
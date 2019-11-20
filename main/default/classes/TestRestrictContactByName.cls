@isTest
public class TestRestrictContactByName {
    static testMethod void  checkContactName(){
	    Contact insertContactObject = new Contact(LastName = 'INVALIDNAME');
    	insert insertContactObject;
        List<Contact> contactList = [Select 
                                    	LastName
                                     From
                                    	Contact];
        system.assertEquals(0,contactList.size());
        
       	Contact updateContactObject = new Contact(LastName = 'INVALIDNAME');
    	insert updateContactObject;
        List<Contact> contactListForUpdate = [Select 
                                    				LastName
                                     		  From
                                    				Contact];
        system.assertEquals(0,contactListForUpdate.size());
        
        Contact validContactName = new Contact(LastName = 'Valid');
        insert validContactName;
        List<Contact> contactListValid = [Select 
                                    			LastName
                                     	  From
                                    			Contact];
        system.assertNotEquals(0,contactListValid.size());

        Contact validContactNameUpdate = new Contact(LastName = 'Valid');
        insert validContactNameUpdate;
        List<Contact> contactListValidUpdate = [Select 
                                    				LastName
                                     	  		From
                                    				Contact];
        system.assertNotEquals(0,contactListValidUpdate.size());
        
    }
}
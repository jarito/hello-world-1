public class contactList {
	@auraEnabled(cacheable=true)
    public static List<Contact> getContactList(){
        List<Contact> listOfContacts = [Select 
                                        	Lastname
            							From
                                        	Contact]; 
        return listOfContacts;
    }
}
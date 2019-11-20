public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer contactNumber , String contactLastName){
        List<Contact> contactList = new List<Contact>();
        
        for(Integer i = 0 ; i < contactNumber ; i++){
            Contact c = new Contact(FirstName = 'Test'+i , LastName = contactLastName);
        	contactList.add(c);
        }
        
        return contactList;
    }
}
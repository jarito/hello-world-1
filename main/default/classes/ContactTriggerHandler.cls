public class ContactTriggerHandler {
    
    public void CreateNewContact(List<Contact> listNewContacts , Map<Id,Contact> mapOldContacts  ){
        List<Contact> listContactsToBeCreated =  new List<Contact>();
			for(Contact objContact : listNewContacts){
                if(objContact.LastName == 'Test'){
                    Contact objNewContact = new Contact(); 
                    objNewContact.LastName = mapOldContacts.get(objContact.ID).LastName;
                    
                    listContactsToBeCreated.add(objNewContact);
                }
            }  
        
        if(listContactsToBeCreated != null && !listContactsToBeCreated.isEmpty()){
            insert listContactsToBeCreated;
        }
    }

}
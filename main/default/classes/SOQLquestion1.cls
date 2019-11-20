public with sharing class SOQLquestion1 {
	/* This Function prints list of all the Contacts with ID and Name*/
	public soqlQuestion1() {
		List<Contact> contactList = [ Select Id, Name from Contact ];
		for(Contact contacts:ContactList){
			system.debug(contacts);
		}
	}
}
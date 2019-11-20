public with sharing class ParentChildExample {
	/*This function retrives id, Name of Contacts with Id and Name of associated account*/
	public ParentChildExample(){
		List<Contact> contactList = [Select id , Name , Accountid , Account.Name From Contact  LIMIT 10];
		for(Contact contacts:contactList){
			System.debug(contacts);
		}
	}
}
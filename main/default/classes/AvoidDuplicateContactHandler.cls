public class AvoidDuplicateContactHandler {
    public void checkDuplicate(List<Contact> listNewContacts, Map<Id,Contact> oldContacts){
        
        /* Map of Email Id and Contact object */
        Map<String , Contact> mapContactsEmail = new Map<String , Contact>();
        /* Map of Contact Phone numbers and Contact object */
        Map<String , Contact> mapContactsPhone = new Map<String , Contact>();
         
        for(Contact eachContact : listNewContacts ){
            if((eachContact.Email != null) && (eachContact.Email.contains('@')) &&
               ( System.Trigger.isInsert || 
                (eachContact.Email != oldContacts.get(eachContact.Id).Email ))){
                    
                    for(Contact contactObj : listNewContacts ){
                        //system.debug(contactObj);
                        if( ! mapContactsEmail.containsKey(contactObj.Email)){
                            mapContactsEmail.put(contactObj.Email,contactObj);
                        }
                    }
                    
                    /*List of Email Ids which match with the Email IDs of inserted contacts */
                    List<Contact> listOfContacts = [Select 
                                                    	Email 
                                                    From 
                                                    	Contact 
                                                    Where 
                                                    	Email IN : mapContactsEmail.keySet()];        
                    
                    /*If contactObject gets some value from map and length of the List named 
                    listOfContacts is greater than zero, implies their already exists a contact 
                    with this Email Id and hence it will throw an error
                    */ 
                    for(Contact contactVar : listOfContacts){
                        Contact contactObject = mapContactsEmail.get(contactVar.Email);
                        contactObject.Email.addError('A contact with this email address already exists ');
                    }
                    
                }            
        }
        
        for(Contact contactPhone : listNewContacts ){
            if((contactPhone.Phone != null) && 
               ( System.Trigger.isInsert || 
                (contactPhone.Phone != oldContacts.get(contactPhone.Id).Phone ))){
                    for(Contact contactObj : listNewContacts ){
                        //system.debug(contactObj);
                        if( ! mapContactsPhone.containsKey(contactObj.Phone)){
                            mapContactsPhone.put(contactObj.Phone,contactObj);
                        }
                    }
                    /*List of Phone numbers which match with the Phone numbers of inserted contacts */   
                    List<Contact> listOfContactsPhone = [Select 
                                                         Phone 
                                                         From 
                                                         Contact 
                                                         Where Phone IN : mapContactsPhone.keySet() ];        
                    /*If contactObject gets some value from map and length of the List named 
                    listOfContactsPhone is greater than zero, implies their already exists a contact 
                    with this Phone number and hence it will throw an error
                    */          
                    for(Contact contactVar : listOfContactsPhone){
                        Contact contactObject = mapContactsPhone.get(contactVar.Phone);
                        contactObject.Phone.addError('A contact with this Phone number address already exists ');
                    }
                }
            
        }
    }
    
    
    /*This method will associate a contact with a particular 
	account based on the email domain of the contact.   */
    public void AssociateAccountToContact (List<Contact> ListOfContacts,Map<Id,Contact> mapOfContacts){
        
        /* This is a list of domains of all the entered contacts */
        List<String> contactEmailDomainList = new List<String>();
        for(Contact contactObject : ListOfContacts ){
            if(contactObject.Email != null ){
                contactEmailDomainList.add(contactObject.Email.split('@').get(1));
                system.debug('----------'+contactEmailDomainList);                
                
                /* This is a Map of Domain names and Ids of Accounts whose 
				domain names match with the domain list of contacts */
                Map<String,Id> mapAccountWebsiteDomainId = new Map<String,Id>();
                system.debug('------CHECK!!------');
                List<Account> accountWebsiteDomainList = [Select 
                                      							Id, WebsiteDomain__c
                                      					  From
                                      							Account
                                      					  Where 
                                      							WebsiteDomain__c IN : contactEmailDomainList];
                for(Account eachAccount: accountWebsiteDomainList){
                        mapAccountWebsiteDomainId.put(eachAccount.WebsiteDomain__c, eachAccount.Id); 
                        system.debug(mapAccountWebsiteDomainId+'-------------------');
                }
                
                for(Contact contactVar : ListOfContacts){
                    if(mapAccountWebsiteDomainId.containsKey(contactVar.Email.split('@').get(1))){
                        contactVar.AccountId = mapAccountWebsiteDomainId.get(contactVar.Email.split('@').get(1));
                    }
                }
            }
        }
    }
}
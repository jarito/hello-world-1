/**
 * Handler class of Trigger named MergeContacts
 */
public with sharing class MergeContactsHandler {
	/**
	 * Method which merges two contacts based on Primary contacts Account
	 * Merging logic depends on value a field named Secondary_Person_In_Household__c present on Contact Object
	 * If this field is set, that particular comntact is considered as Primary Contact else Secondary Contact
	 * Is this field is not set on either of the contacts, the Contact which is created first is considered as Primary Contact
	 */
	public void mergeContactsMethod(List<Relationship__c> listOfRelationships , Map<ID,Relationship__c> mapOfRelationships){

		/**
		 * List of Relationship__c records queried which are also present in Trigger.New
		 */
		List<Relationship__c> listOfRel = [	Select 
													Id,
													Contact__c,
													Contact__r.AccountId,
													Contact__r.FirstName,
													Contact__r.Secondary_Person_In_Household__c,
													Contact__r.CreatedDate,
													Related_Contact__c,
													Related_Contact__r.AccountId,
													Related_Contact__r.FirstName,
													Related_Contact__r.Secondary_Person_In_Household__c,
													Related_Contact__r.CreatedDate,
													Type__c
											From 
													Relationship__c
											Where 
													Id IN : mapOfRelationships.keySet()];


		system.debug(' listOfRel---->'+listOfRel);
		List<String> ListOfContactIds = new List<String>();
		for(Relationship__c objRelation : listOfRel){
			ListOfContactIds.add(objRelation.Contact__r.Id);
			ListOfContactIds.add(objRelation.Related_Contact__r.Id);
		}
		system.debug('Contacts---->'+ListOfContactIds);

		/** 
		 * List of Contact Ids and Account Ids From Contact
		 */
		List<Contact> listOfContactsAccountIds = [	Select 
															Id,
															AccountId
													From 
															Contact
													Where
															Id IN : ListOfContactIds];
		
		List<String> listOfAccountIds = new List<String>();
		for(Contact accountObjId : listOfContactsAccountIds){
			listOfAccountIds.add(accountObjId.AccountId);
		}

		List<Account> accountList = [Select 
											Id
									 From 
											Account
									 Where
											Id IN : listOfAccountIds];

		/**
		 * All contacts associated with the Accounts which are related to relationship object through contact
		 */
		List<Contact> allContactsOfAccount = [Select	
											 		Id,
													AccountId
											  From
											  		Contact
											  Where
											  		AccountId IN : listOfAccountIds];
		system.debug('allContactsOfAccount size--->'+allContactsOfAccount.size());											  
		system.debug('All accounts related to specific accounts--->'+allContactsOfAccount);

		/**
		 * Map of Account Id and Count of Contacts associated with that account
		 */ 
		Map<String,Integer> accountContactsCount =  new Map<String,Integer>();
		for(Contact contactObject : allContactsOfAccount){
			if(accountContactsCount.containsKey(contactObject.AccountId)){
				Integer count = accountContactsCount.get(contactObject.AccountId);
				count++;
				accountContactsCount.put(contactObject.AccountId,count);
			}
			else{
				accountContactsCount.put(contactObject.AccountId , 1);
			}
		}
		system.debug('Map-->'+accountContactsCount)	;

		/**
		 * Map of Contact Id and Account 
		 */ 		
		Map<String,Account> mapOfContactAndAccount = new Map<String,Account>();
		for(Contact contactObject : listOfContactsAccountIds){
			for(Account accountObject : accountList){
				if(contactObject.AccountId == accountObject.Id){
					if(mapOfContactAndAccount.containsKey(contactObject.Id)){
						mapOfContactAndAccount.put(contactObject.Id , accountObject);
					}
					else{
						mapOfContactAndAccount.put(contactObject.Id , accountObject);
					}
				}
			}
		}
		system.debug('MapOfContactIdandAccount--->'+mapOfContactAndAccount);

		
		Map<String,List<Contact>> mapOfRelationshipAndContact = new Map<String,List<Contact>>();
		List<Contact> contactList;
		for(Relationship__c objRel : listOfRel ) { 
			for(Contact objContact : listOfContactsAccountIds ){
				if(objRel.Contact__c == objContact.Id || objRel.Related_Contact__c == objContact.Id){
					if(mapOfRelationshipAndContact.containsKey(objRel.Id)){
						List<Contact> tempList = mapOfRelationshipAndContact.get(objRel.Id);
						tempList.add(objContact);
					}
					else{
						contactList = new List<Contact>();
						contactList.add(objContact);
						mapOfRelationshipAndContact.put(objRel.Id , contactList);
					}
				}
			}
		}	
		system.debug('Map of Re	lationship and COntacts---->'+mapOfRelationshipAndContact);												
		

		/**
		 * List which would contain Contacts to be Updated
		 */
		List<Contact> listToBeUpdated = new List<Contact>();

		/**
		 * List which would contain Contacts to be Updated
		 */
		List<Account> accountsToBeDeleted = new List<Account>();

		Boolean deleteFlag = false;

		for(Relationship__c eachRecord : listOfRel){
			//for(Contact eachContact : listOfContactsAccountIds){
			for(Contact eachContact : mapOfRelationshipAndContact.get(eachRecord.Id)){	
				system.debug('Secondary_Person_In_Household__c 1 -->'+eachRecord.Contact__r.Secondary_Person_In_Household__c);
				system.debug('Secondary_Person_In_Household__c 2 -->'+eachRecord.Related_Contact__r.Secondary_Person_In_Household__c);
				
				Integer count = accountContactsCount.get(eachContact.AccountId);
				system.debug('Total Contacts : '+count);
				if(count > 1){
					if(eachRecord.Contact__r.Secondary_Person_In_Household__c){
						system.debug('Primary Contact Id -->'+eachRecord.Contact__r.Id);
						system.debug('Secondary Contact Id -->'+eachRecord.Related_Contact__r.Id);
						//Contact is Primary Contact
						if(eachContact.Id == eachRecord.Related_Contact__r.Id){
							system.debug('related Contact Id -->'+eachContact.Id);
							String accId = eachRecord.Contact__r.AccountId;
							eachContact.AccountId = accId;
							listToBeUpdated.add(eachContact);
							//update listToBeUpdated;
						}
					}
					else{
						//Related Contact is Primary Contact
						system.debug('Contact 1 Created Date -->'+eachRecord.Contact__r.CreatedDate);
						system.debug('Contact 2 Created Date -->'+eachRecord.Related_Contact__r.CreatedDate);
						if(eachRecord.Contact__r.CreatedDate < eachRecord.Related_Contact__r.CreatedDate &&
						!eachRecord.Contact__r.Secondary_Person_In_Household__c &&
						!eachRecord.Related_Contact__r.Secondary_Person_In_Household__c){
							
							system.debug('Contact 1 is Primary Contact');
							if(eachContact.Id == eachRecord.Related_Contact__r.Id){
								system.debug('related Contact Id -->'+eachContact.Id);
								String accId = eachRecord.Contact__r.AccountId;
								eachContact.AccountId = accId;
								listToBeUpdated.add(eachContact);
								//update listToBeUpdated;
							}

						}
						else{
							system.debug('Related Contact 2 is Primary Contact');
							if(eachContact.Id == eachRecord.Contact__r.Id){
								String accId = eachRecord.Related_Contact__r.AccountId;
								eachContact.AccountId = accId;
								listToBeUpdated.add(eachContact);
								//update listToBeUpdated;
							}
						}
					}
				}
				else{
					if(eachRecord.Contact__r.Secondary_Person_In_Household__c){
						system.debug('Primary Contact Id -->'+eachRecord.Contact__r.Id);
						system.debug('Secondary Contact Id -->'+eachRecord.Related_Contact__r.Id);
						//Contact is Primary Contact
						if(eachContact.Id == eachRecord.Related_Contact__r.Id){
							system.debug('related Contact Id -->'+eachContact.Id);
							String relAccId = eachRecord.Related_Contact__r.AccountId;
							String accId = eachRecord.Contact__r.AccountId;
							eachContact.AccountId = accId;
							listToBeUpdated.add(eachContact);
							Account checkAccountID = mapOfContactAndAccount.get(eachRecord.Related_Contact__r.Id);
							system.debug('Account 1 -->'+checkAccountID);

							//Account accountObj = [Select Id,Name From Account Where Id =: relAccId] ;
							//system.debug('Account 1 -->'+accountObj.Name);
							accountsToBeDeleted.add(checkAccountID);
							deleteFlag = true;
							
							//update listToBeUpdated;
							//delete accountsToBeDeleted;
								
						}
					}
					else{
						//Related Contact is Primary Contact
						system.debug('Contact 1 Created Date -->'+eachRecord.Contact__r.CreatedDate);
						system.debug('Contact 2 Created Date -->'+eachRecord.Related_Contact__r.CreatedDate);
						if(eachRecord.Contact__r.CreatedDate < eachRecord.Related_Contact__r.CreatedDate &&
						!eachRecord.Contact__r.Secondary_Person_In_Household__c &&
						!eachRecord.Related_Contact__r.Secondary_Person_In_Household__c){
							
							system.debug('Contact 1 is Primary Contact..');
							if(eachContact.Id == eachRecord.Related_Contact__r.Id){
								system.debug('related Contact Id -->'+eachContact.Id);
								String relAccId = eachRecord.Related_Contact__r.AccountId;
								String accId = eachRecord.Contact__r.AccountId;
								eachContact.AccountId = accId;
								listToBeUpdated.add(eachContact);
								Account checkAccountID = mapOfContactAndAccount.get(eachRecord.Related_Contact__r.Id);
								system.debug('Account 2 -->'+checkAccountID);
								//Account accountObj = [Select Id,Name From Account Where Id =: relAccId];
								//system.debug('Account 2 -->'+accountObj.Name); 
								accountsToBeDeleted.add(checkAccountID);
								deleteFlag = true;
								
								//update listToBeUpdated;
								//delete accountsToBeDeleted;
							}

						}
						else{
							system.debug('Related Contact 2 is Primary Contact..');
							if(eachContact.Id == eachRecord.Contact__r.Id){
								String relAccId = eachRecord.Contact__r.AccountId;
								String accId = eachRecord.Related_Contact__r.AccountId;
								eachContact.AccountId = accId;
								listToBeUpdated.add(eachContact);
								Account checkAccountID = mapOfContactAndAccount.get(eachRecord.Contact__r.Id);
								system.debug('Account 3 -->'+checkAccountID);
								//Account accountObj = [Select Id,Name From Account Where Id =: relAccId] ;
								//system.debug('Account 3 -->'+accountObj.Name);
								accountsToBeDeleted.add(checkAccountID);
								deleteFlag = true;
								//update listToBeUpdated;
								//delete accountsToBeDeleted;
							}
						}
					}
				}
			}
		}

		/*
		 * List of Contacts to be updated
		 */
		if(!listToBeUpdated.isEmpty()){
			try{
				update listToBeUpdated;
			}
			catch(DmlException e)
			{
				system.debug('Update..'+e.getMessage());
			}
		}

		/*
		 * List of Accounts to be deleted
		 */
		if(!accountsToBeDeleted.isEmpty() && deleteFlag == true){
			try{
				delete accountsToBeDeleted;
				deleteFlag = false;
			}
			catch(DmlException e)
			{
				system.debug('Delete..'+e.getMessage());
			}
		}
	}
}
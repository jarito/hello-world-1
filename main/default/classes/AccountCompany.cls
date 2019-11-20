public with sharing class AccountCompany {
	public void createAccount(){
		Account accountObj = new Account(Name = 'Eternus');
		try {
		   insert accountObj;
		} 
		catch (DmlException e) {
		   
		}
		
		ID accountId = accountObj.ID;
		Contact contactObj = new Contact(
			FirstName = 'Pooja',
			LastName = 'Patel',
			MobilePhone = '9898745621',
			AccountId = accountId
		);

		try {
		   insert contactObj;
		}
		catch (DmlException e) {
		}
		List<sObject> sObjList = [	Select 
										Account.Name, 
										COUNT(Name) 
									From Contact 
									GROUP BY Account.Name 
									HAVING Account.Name = 'Eternus'];
		for(sObject s:sObjList){
		system.debug(s);   
		}
		 
	/*	list<Contact> conList = [Select Name,Account.Name  From Contact Where Account.Name = 'Eternus'];
		for(Contact cList:conList)
		{
			system.debug(cList);
		}
				
		system.debug('List Size is '+conList.size());
		Integer listSize = conList.size();

		Account.ContactCount__c = listSize;

		*/
	}

}
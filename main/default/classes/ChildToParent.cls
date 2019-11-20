public with sharing class ChildToParent {
	public ChildToParent() {
		/* Retriving Details of parent form child */
		System.debug('---------1------------');
		for(C__c objc : [SELECT 
								id,
								Name__c,
								A_Name__r.Name 
						FROM 
								C__c 
						WHERE 
								Name__c = 'John' ])
		{
			System.debug( ' C id: ' + objc.id + ' C Name: ' + objc.Name__c + '   Parent A Name:' + objc.A_Name__r.Name );
		}
		/* Retriving Details of parent form child */
		System.debug('---------2------------');
		for(Contact objCont :[SELECT 
									id,
									Account.Name,
									Account.Industry 
							  FROM 
							  		Contact
							  WHERE 
							  		Account.Industry = 'Energy'
							  ])
		{
			System.debug('ID:' + objCont.id + '  Account Name:' + objCont.Account.Name + '  Account Industry:'+objCont.Account.Industry);
		}
		
	}
}
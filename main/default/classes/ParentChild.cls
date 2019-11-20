public with sharing class ParentChild {
	public ParentChild() {
			/* All child records with Name = John 
			are accessed using Parent to Child Relationship*/
			system.debug('------------1--------------');
			for(A__c aVariable : [SELECT 
										Name, 
										(SELECT 
											Name__c 
										FROM 
											Cs__r 
										WHERE 
											Name__c = 'John') 
								  FROM 
								  		A__c])
			{
				System.debug('---Records---' + aVariable.Cs__r );
			}
			/* All child records of Account with StageName = Closed Won
			 are accessed using Parent to Child Relationship*/	
			system.debug('------------2--------------');
			for(Account accountObject : [SELECT 
												Name, 
												(SELECT 
														Name,
														StageName 
												FROM 
														Opportunities 
												WHERE 
														StageName = 'Closed Won' ) 
								   		FROM 
								   				Account 
										Where 
												Id IN (Select 
															AccountId 
													   From 
													   		Opportunity 
													   WHERE 
													   		StageName = 'Closed Won')])
			{
				System.debug('Opportunity Records:  ' + accountObject.Opportunities );
			}
			/* All child records of Accounts with LastName = John 
			are accessed using Parent to Child Relationship*/
			system.debug('------------3--------------');
			for(Account accountVariable : [SELECT 
												Name, 
												(SELECT 
													LastName 
												 FROM 
											 		Contacts 
												 WHERE 
													LastName = 'John' ) 
								   		  FROM 
								   				 Account 
										  Where 
										  		 Id IN (Select 
												   			AccountId 
														From 
															Contact 
														WHERE 
															LastName = 'John') ])
			{
				System.debug('Opportunity Records:  ' + accountVariable.Contacts );

			}
	}
}
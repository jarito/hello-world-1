@isTest
/**
 * This test class checks whether all the scenarios of Batch are being covered
 */
public class OpportunityPerDayTest {
	/**
	 * Test method which checks the functionality for correct inputs, means there is a Primary Contact 
	 * and a Opportunity for a Account associated with that contact
	 */
	static testMethod void validInputSingle(){
		
        List<Contact> contactList = TestDataFactory.insertOneContact();
        insert contactList;
        List<ID> contactIDs = new List<ID>();
        for(Contact eachContact  : contactList){
            contactIDs.add(eachContact.Id);
        }
        List<Account> accountList = TestDataFactory.createSingleAccountBatch(contactIDs);
		insert accountList;
        List<ID> accountIDs = new List<ID>();
        for(Account eachAccount : accountList){
           accountIDs.add(eachAccount.Id);
        }
        List<Opportunity> opportunityList = TestDataFactory.createSingleOpportunityBatch(accountIDs);
        insert opportunityList;

		test.startTest();        
        OpportunityPerDay objectOpportunity = new OpportunityPerDay();
		Database.executeBatch(objectOpportunity);
		//Integer count = Limits.getEmailInvocations();
		//system.debug('Email Invocation in test class'+count);	
		test.stopTest();		

		//system.debug('-------****------'+Limits.getEmailInvocations());
		//system.assertEquals(1,count);
	}

   /**
	* This method contains One Contact, one Account associated with it and four opportunities for that account  
	*/
	static testMethod void singleAccountManyOpportunities(){
		List<Contact> contactList = TestDataFactory.insertOneContact();
        insert contactList;
        List<ID> contactIDs = new List<ID>();
        for(Contact eachContact  : contactList){
            contactIDs.add(eachContact.Id);
        }
        List<Account> accountList = TestDataFactory.createSingleAccountBatch(contactIDs);
		insert accountList;
        List<ID> accountIDs = new List<ID>();
        for(Account eachAccount : accountList){
           accountIDs.add(eachAccount.Id);
        }
        List<Opportunity> opportunityList = TestDataFactory.createFourOpportunitiesBatch(accountIDs);
        insert opportunityList;

		test.startTest();        
        OpportunityPerDay objectOpportunity = new OpportunityPerDay();
		Database.executeBatch(objectOpportunity);
		test.stopTest();		

	}	

   /**(POS)
	* This Method contains Two Contact, two Accounts associated with it and two Opportunities per Account
	* Hence email body should be generated for two Primary contacts
	*/
	static testMethod void twoAccountsTwoContactManyOpportunities(){
		List<Contact> contactList = TestDataFactory.insertTwoContactsBatch();
        insert contactList;
        List<ID> contactIDs = new List<ID>();
        for(Contact eachContact  : contactList){
            contactIDs.add(eachContact.Id);
        }
        List<Account> accountList = TestDataFactory.insertTwoAccountsBatch(contactIDs);
		insert accountList;
        List<ID> accountIDs = new List<ID>();
        for(Account eachAccount : accountList){
           accountIDs.add(eachAccount.Id);
        }
        List<Opportunity> opportunityList = TestDataFactory.twoAccountsFourOpportunitiesBatch(accountIDs);
        insert opportunityList;		

		test.startTest();        
        OpportunityPerDay objectOpportunity = new OpportunityPerDay();
		Database.executeBatch(objectOpportunity);
		test.stopTest();		

	}	

	static testMethod void bulkAccountsContactOpportunities(){
		List<Contact> contactList = TestDataFactory.insertTwoContactsBatch();
        insert contactList;
        List<ID> contactIDs = new List<ID>();
        for(Contact eachContact  : contactList){
            contactIDs.add(eachContact.Id);
        }
        List<Account> accountList = TestDataFactory.insertTwoAccountsBatch(contactIDs);
		insert accountList;
        List<ID> accountIDs = new List<ID>();
        for(Account eachAccount : accountList){
           accountIDs.add(eachAccount.Id);
        }
        List<Opportunity> opportunityList = TestDataFactory.twoAccounts200OpportunitiesBatch(accountIDs);
        insert opportunityList;
        
		test.startTest();       
        OpportunityPerDay objectOpportunity = new OpportunityPerDay();
		Database.executeBatch(objectOpportunity);
		test.stopTest();		

	}	

   /**(NEG)
	* This Method contains One Contact, two Accounts associated with it and two Opportunities per Account
	* Practically, there cannot be more than one Account for a Contact. Hence, Email body is generated for 
	* the recently created account with that contact.
	*/
	static testMethod void twoAccountsOneContactManyOpportunities(){
		List<Contact> contactList = TestDataFactory.insertOneContact();
        insert contactList;
        List<ID> contactIDs = new List<ID>();
        for(Contact eachContact  : contactList){
            contactIDs.add(eachContact.Id);
        }
        List<Account> accountList = TestDataFactory.oneContactTwoAccountsBatch(contactIDs);
		insert accountList;
        List<ID> accountIDs = new List<ID>();
        for(Account eachAccount : accountList){
           accountIDs.add(eachAccount.Id);
        }
        List<Opportunity> opportunityList = TestDataFactory.twoAccountsFourOpportunitiesBatch(accountIDs);
        insert opportunityList;			
		test.startTest();        
        OpportunityPerDay objectOpportunity = new OpportunityPerDay();
		Database.executeBatch(objectOpportunity);
		test.stopTest();		

	}	

   /**(NEG)
	* This Method contains one Account associated two Opportunities. This Account has no Primary contact 
	* Hence, Email  shouldn't be sent and Email body should not be generated.
	*/
	static testMethod void noContactForAccount(){
        List<Account> accountList = TestDataFactory.createSingleAccount();
		insert accountList;
        List<ID> accountIDs = new List<ID>();
        for(Account eachAccount : accountList){
           accountIDs.add(eachAccount.Id);
        }
		system.debug('----account---'+accountList); 
        List<Opportunity> opportunityList = TestDataFactory.createTwoOpportunitiesBatch(accountIDs);
        insert opportunityList;
        system.debug('----Opportunities and Account---'+opportunityList);
		
		test.startTest();        
        OpportunityPerDay objectOpportunity = new OpportunityPerDay();
		Database.executeBatch(objectOpportunity);
		test.stopTest();		
	}	


   /**(NEG)
	* This Method contains one contact, one Account no Opportunities.  
	* Hence, Email  shouldn't be sent and Email body should not be generated.
	*/
	static testMethod void noOpportunitiesForAccount(){
        List<Contact> contactList = TestDataFactory.insertOneContact();
        insert contactList;
        List<ID> contactIDs = new List<ID>();
        for(Contact eachContact  : contactList){
            contactIDs.add(eachContact.Id);
        }
        system.debug('-----Contacts----'+contactList);
        List<Account> accountList = TestDataFactory.createSingleAccountBatch(contactIDs);
		insert accountList;
        List<ID> accountIDs = new List<ID>();
        for(Account eachAccount : accountList){
           accountIDs.add(eachAccount.Id);
        } 
		system.debug('-----Accounts----'+accountList);
		test.startTest();        
        OpportunityPerDay objectOpportunity = new OpportunityPerDay();
		Database.executeBatch(objectOpportunity);
		test.stopTest();		
	}	

	static testMethod void scheduler(){
		SchedulerForOpportunityPerDay.scheduleMe();
	}
}
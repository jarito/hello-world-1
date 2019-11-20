@isTest
/**
 * This test class teststhe working of PM51ControllerTest controller
 */
public with sharing class PM51ControllerTest {
    /**
	 * Method to verify number of accounts matching the search input
	 */
	static testMethod void validSearchSingleMatch(){
		List<Account> accountList = TestDataFactory.createTwoAccounts();
		insert accountList;

		Test.startTest();
		ApexPages.StandardSetController accountSetController = new ApexPages.StandardSetController(accountList);
		PM51Controller objectPM51Controller = new PM51Controller(accountSetController);
		objectPM51Controller.selectedAccount = 'Test';
		objectPM51Controller.getAccountDetails();
        Test.stopTest();
		List<Account> accountListObj = [Select 
                                    		Name
                                     	From 
                                    		Account
                                     	Where
         
                                        Name like '%test%'];
		/**
		 * Assert to check whether the search results contains the search input as substring
	 	 */
        for(Account accountObj : accountListObj){
            system.assert(accountObj.Name.contains(objectPM51Controller.selectedAccount));
        }
		/**
		 * Assert to verify the serach results count
	 	 */        
        System.assertEquals(2 , objectPM51Controller.countOFSearchResult );
	}
	/**
	 * Method to verify whether the controller returns the records according to the input 
	 * search alphabet
	 */
	static testMethod void alphabeticalSearch(){
		List<Account> charAccountList = TestDataFactory.alphabeticalSearch();
		insert charAccountList;

		Test.startTest();
		ApexPages.StandardSetController accountSetController = new ApexPages.StandardSetController(charAccountList);
		PM51Controller objectPM51Controller = new PM51Controller(accountSetController);
		objectPM51Controller.hiddenVal = 'B';
		List<Account> listOfAccounts = objectPM51Controller.getAccounts();
        system.debug('List ----' +listOfAccounts );
        Test.stopTest();
		
       List<Account> listOfMatchedAccounts = [Select 
                                               		Name 
                                               From 
                                               		Account 
                                               Where 
                                               		Name 
                                               Like 'B%'];
        for(Account accountObj : listOfMatchedAccounts){
            for(Account eachAccount : listOfAccounts){
               System.assertEquals(accountObj.Name.substring(0,1), eachAccount.Name.substring(0,1)); 
            }
        }
		System.assertEquals(4 , listOfAccounts.size() );
	}

	/**
	 * Method to verify whether the controller returns the records according to the input 
	 * search alphabet
	 */
	static testMethod void bulkCheckAlphabeticalSearch(){
		List<Account> charAccountList = TestDataFactory.bulkCheckAlphabeticalSearch();
		insert charAccountList;

		Test.startTest();
		ApexPages.StandardSetController accountSetController = new ApexPages.StandardSetController(charAccountList);
		PM51Controller objectPM51Controller = new PM51Controller(accountSetController);
		objectPM51Controller.hiddenVal = 'K';
		List<Account> listOfAccounts = objectPM51Controller.getAccounts();
        system.debug('List ----' +listOfAccounts.size() );
        Test.stopTest();
		
       List<Account> listOfMatchedAccounts = [Select 
                                               		Name 
                                               From 
                                               		Account 
                                               Where 
                                               		Name 
                                               Like 'K%'];
        for(Account accountObj : listOfMatchedAccounts){
            for(Account eachAccount : listOfAccounts){
               System.assertEquals(accountObj.Name.substring(0,1), eachAccount.Name.substring(0,1)); 
            }
        }
		System.assertEquals(130 , listOfAccounts.size() );
	}    

	/**
	 * Method to verify whether the controller returns the records according to the input 
	 * search alphabet. Here ALL records are to be checked
	 */
	static testMethod void alphabeticalSearchForALLBulk(){
		List<Account> charAccountList = TestDataFactory.alphabeticalSearchForALLBulk();
		insert charAccountList;

		Test.startTest();
		ApexPages.StandardSetController accountSetController = new ApexPages.StandardSetController(charAccountList);
		PM51Controller objectPM51Controller = new PM51Controller(accountSetController);
		objectPM51Controller.hiddenVal = 'ALL';
		List<Account> listOfAccounts = objectPM51Controller.getAccounts();
        system.debug('List ----' +listOfAccounts.size() );
        Test.stopTest();

		System.assertEquals(200 , listOfAccounts.size() );
	}
}
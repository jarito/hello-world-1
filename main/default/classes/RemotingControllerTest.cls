/**
 * Test class to verify the working of Controller
 */
@isTest
public class RemotingControllerTest {
    /**
     * This method checks whether the selected account is getting deleted from the list of accounts 
     */
    static testMethod void deleteValidInput(){
        List<Account> accountList = TestDataFactory.createAccount(5);
        insert accountList;
        Test.startTest();
		ApexPages.StandardSetController accountSetController = new ApexPages.StandardSetController(accountList);
		RemotingController objectRemotingController = new RemotingController(accountSetController); 
        List<Account> resultList = RemotingController.deleteAccount(accountList[1].Id);
        system.debug('result ---- > '+resultList);
        Set<ID> resultId = new Set<ID>();
        for(Account eachId : resultList ){
            resultID.add(eachId.Id);
        }
        Test.stopTest();
        system.assert(!resultID.contains(accountList[1].Id));
        system.assertNotEquals(accountList.size(), resultList.size());
    }
}
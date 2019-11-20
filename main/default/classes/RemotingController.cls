/**
 * Controller containing logic of Remotely called method for deletion of selected account record
 */
public class RemotingController{
     public RemotingController(ApexPages.StandardSetController controller) {}
    /**
     * Remote method used for deletion of selected account record
     */
    @RemoteAction
        public static List<Account> deleteAccount(String AccountID) {
                Account accountObj = new Account();
                accountObj = [SELECT 
                                Id, 
                                Name, 
                                Phone, 
                                Type
                        FROM 
                                Account 
                        WHERE 
                                Id = :AccountID];
                delete accountObj; 
                
                List<Account> accountList = [SELECT 
                                                        Id, 
                                                        Name, 
                                                        Phone, 
                                                        Type
                                                FROM 
                                                        Account ];
                return accountList;
        }
}
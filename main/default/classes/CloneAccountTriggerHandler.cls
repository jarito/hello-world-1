/*This class will be called by a trigger when before insert event will occur on Account object.
 *Account will be cloned for every new account inserted 
*/
public class CloneAccountTriggerHandler {
    /* This variable is used to avoid Recursion of Cloning Process*/
    public static Boolean BooleanVar = True;
	public void CloneNewAccount(List<Account> listNewAccounts ){
        system.debug('Inside Trigger Method');
        List<Account> listOfAccountsToBeCloned = new List<Account>();
        if(BooleanVar){
            for(Account accountVariable : listNewAccounts ){
                Account accountObject = new Account();
                accountObject = accountVariable.clone(false,true);
                listOfAccountsToBeCloned.add(accountObject); 
                BooleanVar = False;
            }
        }
            
        if(!listOfAccountsToBeCloned.isEmpty()){
                /*List of all duplicate accounts ie cloned Accounts*/
                insert listOfAccountsToBeCloned;   
        }
    } 
}
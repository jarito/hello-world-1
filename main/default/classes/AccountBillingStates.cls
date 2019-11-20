public class AccountBillingStates{
    public void accountBillingState(){
        List<Account> accountBillingStates = [Select 
                                                    Name,BillingState 
                                              From 
                                                    Account 
                                              Where 
                                                    BillingState 
                                              NOT IN ('Maharashtra','Kerala') 
                                              Order By 
                                                    BillingState DESC NULLS LAST];
                                             
        for(Account accounts : accountBillingStates){
            system.debug(accounts);
        }
    }
}
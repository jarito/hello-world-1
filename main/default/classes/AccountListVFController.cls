public class AccountListVFController {
    public List<Account> accountList {get; set;}
    public List<Contact> contactList {get; set;}
    public string accountId {get;set;}
    public string contactId {get;set;}
    public String sign{get;set;}
    public Integer i;

    public AccountListVFController(){
        accountList = [Select 
                      		id, 
                      		Name,
                      		(Select Id, Lastname from contacts) 
                       from 
                      		Account];
        system.debug('ACcount list : '+accountList);
        
        i = 0;
        sign = '+';
    }
    
    public void getContacts(){
        system.debug('Here Account Id :' +accountId);
        if(i == 0)
            {
                contactList = [SELECT id,LastName FROM Contact where accountid =: accountId];
                system.debug('Here contactList :' +contactList);
                sign = '-';
                i = 1;
            }
        else if(i == 1)
            {
                sign = '+';
                contactList = null;
                i = 0;
            }
    }
    
    public void getObject(){
        system.debug('Here contactId Id :' +contactId);
    }
}
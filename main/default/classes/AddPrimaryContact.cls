public class AddPrimaryContact implements Queueable {

    private Contact cont;
    private String state;
    
    public AddPrimaryContact(Contact record, String sta) {
        this.cont = record;
        this.state = sta;
    }
    
    
    public void execute(QueueableContext context) {
        List<Account> accounts = [select id from account where BillingState = :state LIMIT 200];
        for (Account account : accounts) {
            Contact ct = cont.clone();
            ct.AccountId=account.id;
            upsert ct;
        }
    }    
}
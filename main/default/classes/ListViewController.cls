public class ListViewController {
    
    ApexPages.StandardSetController setCon;
    public ListViewController(ApexPages.StandardSetController controller)
    {
        setCon = controller;
    }
	@AuraEnabled (cacheable = true)
    public List<Account> getSelectedRecords(){
        // do something with the selected records
        for ( Account acc : (Account[])setCon.getSelected() )
        {
                System.debug('Account name = ' + acc.Name);
        }
        List<Account> selectedAccList = (List<Account>)setCon.getSelected();
        system.debug('Selected Accounts >>>> '+selectedAccList);
        return selectedAccList;
    }
}
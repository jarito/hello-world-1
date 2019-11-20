/**
 * Controller containing logic to search account records, delete account records and 
 * alphabetical search also
 */
global class PM51Controller{
    /**
     * Selected account is the account to be searched which is entered in search box
     * Resultant account is the account list matching with the search criteria
     * Hidden val is the variable containing the character selected for alphabetical search
     * countOfSearchResult is the count of records matching with the search criteria
     */
    public string selectedAccount {get;set;}    
    public List<Account> resultantAccount {get;set;}
    public String hiddenVal{get;set;}
    public Integer countOFSearchResult {get;set;}

    public PM51Controller(ApexPages.StandardSetController controller) {
        resultantAccount = new List<Account>();
    }
    /**
     * List containing matching results is returned
     */
    public void getAccountDetails(){
        if(selectedAccount == '' || selectedAccount == null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter atleast 3 characters'));
        }
        else{
            resultantAccount = [Select
                                    Id,
                                    Name,
                                    Phone 
                                From
                                    Account 
                                Where 
                                    Name  Like : '%'+selectedAccount+'%' ];
            
            countOFSearchResult = resultantAccount.size();
        }

    }
    /**
     * List containing all the account records matching with the alphabet selected
     */
    List<Account> accountList = new List<Account>();
    String sQuery='';
    public List<Account>  getAccounts(){
        
        if(hiddenVal=='ALL'){
            sQuery='Select Name,Phone, Website From Account ';
        }
        else{
            sQuery='Select Name,Phone, Website From Account Where Name Like \''+hiddenVal+'%\'' ;
            system.debug('----- sQuery is -----'+sQuery);
        }
        accountList = database.query(sQuery);
        return accountList ;
    }
    /**
     * Method to clear the search results without refreshing the page
     */
    public void ClearList(){
        resultantAccount.clear();
    }
    /**
     * Method indicating no page redirection
     */
    public PageReference showApexValue(){
        system.debug('----hiddenVal----'+hiddenVal);
        return null;
    }
}
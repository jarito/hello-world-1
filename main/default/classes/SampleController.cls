public class SampleController {
     
    //Get Account Records
    @AuraEnabled
    public static List<Account> getAccounts(String pageSize, String pageNumber){
        Integer psize = Integer.valueOf(pageSize);
        Integer pnumber = Integer.valueOf(pageNumber)-1;
         
        List<Account> accList = [SELECT Id, Name, AccountNumber, Industry, Phone
                                  FROM Account LIMIT :Integer.valueOf(psize) OFFSET :(psize*pnumber)];
        return accList;
    }
}
@isTest
public class InvocableApexDemoTest {
    /**
    * Test method to check whether correct end date is getting calculated for single record
	**/
    static testMethod void checkEndDateOfSingleAccount(){ 
        List<Account> lstAccounts = TestDataFactory.createAccounts(1);
        insert lstAccounts;

        List<InvocableApexDemo.AccountParameter> lstWrapper = new List<InvocableApexDemo.AccountParameter>();
        InvocableApexDemo.AccountParameter wrapperObj;
        for(Account accountObj : lstAccounts) {
            wrapperObj = new InvocableApexDemo.AccountParameter();
            wrapperObj.startDate = accountObj.Start_Date__c;
            wrapperObj.noOfBusinessDays = Integer.valueOf(accountObj.No_of_Business_Days__c);
            wrapperObj.objAccount = accountObj;
            lstWrapper.add(wrapperObj);
        }

        Test.startTest();
        InvocableApexDemo.handleAccountEndDate(lstWrapper);        
        Test.stopTest();

        List<Account> checkList = [SELECT Id
                                        , Name
                                        , Start_Date__c
                                        , No_of_Business_Days__c
                                        , End_Date__c
                                   FROM Account
                                   WHERE Id IN : lstAccounts];
        System.debug('Test checkList >>>>> '+checkList);
        Date checkendDate = date.newInstance(2019, 8, 19);
        System.AssertEquals(checkendDate, checkList[0].End_Date__c);
    }
    
    /**
    * Test method to check whether correct end date is getting calculated for multiple records (bulk)
	**/
    static testMethod void checkEndDateOfMultipleAccounts(){ 
        List<Account> lstAccounts = TestDataFactory.createAccounts(210);
        insert lstAccounts;

        List<InvocableApexDemo.AccountParameter> lstWrapper = new List<InvocableApexDemo.AccountParameter>();
        InvocableApexDemo.AccountParameter wrapperObj;
        for(Account accountObj : lstAccounts) {
            wrapperObj = new InvocableApexDemo.AccountParameter();
            wrapperObj.startDate = accountObj.Start_Date__c;
            wrapperObj.noOfBusinessDays = Integer.valueOf(accountObj.No_of_Business_Days__c);
            wrapperObj.objAccount = accountObj;
            lstWrapper.add(wrapperObj);
        }

        Test.startTest();
        InvocableApexDemo.handleAccountEndDate(lstWrapper);        
        Test.stopTest();

        List<Account> checkList = [SELECT Id
                                        , Name
                                        , Start_Date__c
                                        , No_of_Business_Days__c
                                        , End_Date__c
                                   FROM Account
                                   WHERE Id IN : lstAccounts
                                   ORDER BY End_Date__c ASC];
        Date checkendDate1 = date.newInstance(2019, 8, 19);
        Date checkendDate2 = date.newInstance(2019, 9, 26);
        Date checkendDate3 = date.newInstance(2019, 10, 7);
        
        System.AssertEquals(checkendDate1, checkList[0].End_Date__c);
        System.AssertEquals(checkendDate2, checkList[50].End_Date__c);
        System.AssertEquals(checkendDate3, checkList[150].End_Date__c);
    }
}
@isTest
public class UpdateContractCountOnOrderTest {
    /**
     * Method to test whether Contract count is updated on Order as a non zero number. Here, it should be 1.
     **/
    static testMethod void checkContractCountOnOrderOnContractUpdate() {
        List<Product2> listProducts = TestUtilityClass.createProducts(1);
        insert listProducts;
        
        Pricebook2 customPricebook =  TestUtilityClass.createPriceBook();
        insert customPricebook;
        
        List<PriceBookEntry> lstPriceBookEntry  =  TestUtilityClass.createPriceBookEntries(listProducts);
        insert lstPriceBookEntry;   
            
        List<Account> lstAccount = TestUtilityClass.createAccounts('Test Class Account', 1);
        insert lstAccount;
        
        List<Contact> lstContact = TestUtilityClass.createContacts(lstAccount);
        insert lstContact;
        
        List<Opportunity> lstOpportunity = TestUtilityClass.createOpportunities(lstAccount);
        insert lstOpportunity;
        
        List<SBQQ__Quote__c> lstQuotes = TestUtilityClass.createQuotes(lstOpportunity);
        insert lstQuotes; 
        
        List<SBQQ__QuoteLine__c> lstQuoteLines = TestUtilityClass.createQuoteLines(lstQuotes, listProducts, 1);
        insert lstQuoteLines;

        List<Order> lstOrders = TestUtilityClass.createOrders(lstAccount, lstOpportunity, lstQuotes, lstPriceBookEntry[0].Pricebook2Id, 1);
        insert lstOrders;

        List<OrderItem> lstOrderItem = TestUtilityClass.createOrderItem(listProducts, lstOrders, lstQuoteLines, lstPriceBookEntry, 1);
        insert lstOrderItem;
        
        List<Contract> lstContracts = TestUtilityClass.createContractsFromOrder(lstAccount, lstOpportunity, lstOrders, lstQuotes);
        insert lstContracts;  

        List<Contract> lstContractsToBeUpdated = new List<Contract>();
        Contract objContract = new Contract();
        objContract.Id = lstContracts[0].Id;
        objContract.Description = 'Test';
        lstContractsToBeUpdated.add(objContract);

        System.Test.startTest();
        update lstContractsToBeUpdated;
        System.Test.stopTest();

        List<Order> checkOrderList = [SELECT  
                                            Id, 
                                            No_of_Contracts__c
                                      FROM  Order
                                      WHERE Id =: lstOrders[0].Id];
        System.assertEquals(1, checkOrderList[0].No_of_Contracts__c);  
    }

    /**
     * Method to test whether Contract count is updated on Order whenever a contract is deleted. Here, it should be 0.
     **/
    static testMethod void checkContractCountOnOrderOnContractDelete() {
        List<Product2> listProducts = TestUtilityClass.createProducts(1);
        insert listProducts;
        
        Pricebook2 customPricebook =  TestUtilityClass.createPriceBook();
        insert customPricebook;
        
        List<PriceBookEntry> lstPriceBookEntry  =  TestUtilityClass.createPriceBookEntries(listProducts);
        insert lstPriceBookEntry;   
            
        List<Account> lstAccount = TestUtilityClass.createAccounts('Test Class Account', 1);
        insert lstAccount;
        
        List<Contact> lstContact = TestUtilityClass.createContacts(lstAccount);
        insert lstContact;
        
        List<Opportunity> lstOpportunity = TestUtilityClass.createOpportunities(lstAccount);
        insert lstOpportunity;
        
        List<SBQQ__Quote__c> lstQuotes = TestUtilityClass.createQuotes(lstOpportunity);
        insert lstQuotes; 
        
        List<SBQQ__QuoteLine__c> lstQuoteLines = TestUtilityClass.createQuoteLines(lstQuotes, listProducts, 1);
        insert lstQuoteLines;

        List<Order> lstOrders = TestUtilityClass.createOrders(lstAccount, lstOpportunity, lstQuotes, lstPriceBookEntry[0].Pricebook2Id, 1);
        insert lstOrders;

        List<OrderItem> lstOrderItem = TestUtilityClass.createOrderItem(listProducts, lstOrders, lstQuoteLines, lstPriceBookEntry, 1);
        insert lstOrderItem;
        
        List<Contract> lstContracts = TestUtilityClass.createContractsFromOrder(lstAccount, lstOpportunity, lstOrders, lstQuotes);
        insert lstContracts; 

        System.Test.startTest();
        delete lstContracts;
        System.Test.stopTest();

        List<Order> checkOrderList = [SELECT  
                                            Id, 
                                            No_of_Contracts__c
                                      FROM  Order
                                      WHERE Id =: lstOrders[0].Id];
        System.debug('checkOrderList >>>>> '+checkOrderList);  
        System.assertEquals(0, checkOrderList[0].No_of_Contracts__c);  
    }    
}
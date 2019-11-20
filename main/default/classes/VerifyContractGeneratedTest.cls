@isTest
public class VerifyContractGeneratedTest {
    static testmethod void checkEmailFunctioning() {
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

        List<Order> lstOrders = TestUtilityClass.createOrdersForUpdateOrderBatch(lstAccount, lstOpportunity, lstQuotes, lstPriceBookEntry[0].Pricebook2Id, 2);
        insert lstOrders;
        System.debug('lstOrders ID >>>> '+lstOrders);

        //Create Order Products
        List<OrderItem> lstOrderItem = TestUtilityClass.createOrderItem(listProducts, lstOrders, lstQuoteLines, lstPriceBookEntry, 2);
        insert lstOrderItem;
        System.debug('lstOrderItem >>>>> '+lstOrderItem);

        List<Order> activateOrderUpdate = new List<Order>();
        for(Order objOrder : lstOrders) {
            Order objOrderAct = new order();
            objOrderAct.id = objOrder.Id;        
            objOrderAct.Status = 'Activated';
            activateOrderUpdate.add(objOrderAct);
        }
        update activateOrderUpdate;

        List<Order> contractedOrderUpdate1 = new List<Order>();
        for(Order objConOrder : activateOrderUpdate) {
            Order objOrder1 = new order();
            objOrder1.id = objConOrder.Id;        
            objOrder1.SBQQ__Contracted__c = true;
            objOrder1.Batch_logic_applied__c = true;
            contractedOrderUpdate1.add(objOrder1);
        }
        update contractedOrderUpdate1;

        Set<ID> setOrderIds = new Set<ID>();
        for(Order objSetOrder : contractedOrderUpdate1) {
            setOrderIds.add(objSetOrder.Id);
        }
        System.debug('In Test Class >>> setOrderIds >>> '+setOrderIds);

        System.Test.startTest();
        VerifyContractGeneratedBatch objUpdateOrderBatch = new VerifyContractGeneratedBatch(setOrderIds);
        Database.executeBatch(objUpdateOrderBatch, 50); 
        Integer invocations = Limits.getEmailInvocations();
        System.Test.stopTest();
    }
}
@isTest
public class RollUpMinSubscriptionDateTest {
    static testmethod void checkMinRenewedDateValidCase() {
        List<Product2> listProducts = TestUtilityClass.createProducts(2);
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

        List<Order> contractedTrueOrderUpdate = new List<Order>();
        for(Order objOrderContr : activateOrderUpdate) {
            Order objOrderCon = new order();
            objOrderCon.id = objOrderContr.Id;        
            objOrderCon.SBQQ__Contracted__c = true;
            contractedTrueOrderUpdate.add(objOrderCon);
        } 
        update contractedTrueOrderUpdate;
        System.debug('contractedTrueOrderUpdate >>>> '+contractedTrueOrderUpdate);

        List<Contract> lstContracts = TestUtilityClass.createContractsFromOrder(lstAccount, lstOpportunity, contractedTrueOrderUpdate, lstQuotes, 2);
        insert lstContracts;
        System.debug('lstContracts'+lstContracts);

        List<Contract> lstContractInitial = [SELECT 
                                                  Id
                                                , Minimum_Renewed_Date__c
                                                , SBQQ__Order__c
                                             FROM Contract
                                             WHERE Id IN : lstContracts];
        
        List<SBQQ__Subscription__c> lstSubscriptions = TestUtilityClass.createSubscriptionsForDateRollUp(lstContracts, listProducts, 3);
        insert lstSubscriptions;
        System.debug('In Test >>> lstSubscriptions >>> '+lstSubscriptions);
        
        System.test.startTest();
        update lstSubscriptions;
        System.test.stopTest();

        List<Date> lstDate = new List<Date>();
        lstDate.add(Date.newInstance(2016, 10 , 10));
        lstDate.add(Date.newInstance(2017, 10 , 10));

        List<Contract> lstContractUpdated = [SELECT 
                                                  Id
                                                , Minimum_Renewed_Date__c
                                             FROM Contract
                                             WHERE Id IN : lstContracts AND 
                                                      Minimum_Renewed_Date__c IN : lstDate];
        System.debug('lstContractUpdated >>>>> '+lstContractUpdated);
        
        System.assertEquals(2, lstContractUpdated.size());
        for(Contract objContractCheck : lstContractUpdated) {
            System.assertNotEquals(null, objContractCheck.Minimum_Renewed_Date__c);
        }
    }

    static testmethod void checkMinRenewedDateInvalidCase() {
        List<Product2> listProducts = TestUtilityClass.createProducts(2);
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

        List<Order> contractedTrueOrderUpdate = new List<Order>();
        for(Order objOrderContr : activateOrderUpdate) {
            Order objOrderCon = new order();
            objOrderCon.id = objOrderContr.Id;        
            objOrderCon.SBQQ__Contracted__c = true;
            contractedTrueOrderUpdate.add(objOrderCon);
        } 
        update contractedTrueOrderUpdate;
        System.debug('contractedTrueOrderUpdate >>>> '+contractedTrueOrderUpdate);

        List<Contract> lstContracts = TestUtilityClass.createContractsFromOrder(lstAccount, lstOpportunity, contractedTrueOrderUpdate, lstQuotes, 2);
        insert lstContracts;
        System.debug('lstContracts'+lstContracts);

        List<Contract> lstContractInitial = [SELECT 
                                                  Id
                                                , Minimum_Renewed_Date__c
                                                , SBQQ__Order__c
                                             FROM Contract
                                             WHERE Id IN : lstContracts];
        
        List<SBQQ__Subscription__c> lstSubscriptions = TestUtilityClass.createSubscriptionsForDateRollUp(lstContracts, listProducts, 3);
        insert lstSubscriptions;
        System.debug('lstSubscriptions >>>>> '+lstSubscriptions);
        
        List<SBQQ__Subscription__c> lstSubscriptionsToBeUpdated = new List<SBQQ__Subscription__c>();
        for(SBQQ__Subscription__c objSubscription : lstSubscriptions) {
            SBQQ__Subscription__c objNewSubs = new SBQQ__Subscription__c();
            objNewSubs.Id = objSubscription.Id;
            objNewSubs.SBQQ__RenewedDate__c = null;
            lstSubscriptionsToBeUpdated.add(objNewSubs);
        }
        System.debug('lstSubscriptionsToBeUpdated >>>>> '+lstSubscriptionsToBeUpdated);

        
        System.test.startTest();
        update lstSubscriptionsToBeUpdated;
        System.test.stopTest();

        List<Contract> lstContractUpdated = [SELECT 
                                                  Id
                                                , Minimum_Renewed_Date__c
                                             FROM Contract
                                             WHERE Id IN : lstContracts];
        System.debug('lstContractUpdated >>>>> '+lstContractUpdated);

        for(Contract objContract : lstContractUpdated) {
            System.assertEquals(null, objContract.Minimum_Renewed_Date__c);
        }
    }
}
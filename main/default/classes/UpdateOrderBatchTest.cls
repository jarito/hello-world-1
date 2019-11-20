@isTest
public class UpdateOrderBatchTest {
    static testmethod void checkOrderContractedFieldAllFilters() {
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
        Order objOrder1 = new order();
        objOrder1.id = activateOrderUpdate[0].Id;        
        objOrder1.SBQQ__Contracted__c = true;
        contractedOrderUpdate1.add(objOrder1);
        update contractedOrderUpdate1;

        List<Order> contractedOrderUpdate2 = new List<Order>();  
        Order objOrder2 = new order();
        objOrder2.id = activateOrderUpdate[1].Id;        
        objOrder2.SBQQ__Contracted__c = false;
        contractedOrderUpdate2.add(objOrder2);
        update contractedOrderUpdate2;

        List<Order> lstOrderBefore = [SELECT 
                                            Id
                                          , Order_Status__c
                                          , SBQQ__Contracted__c
                                          , No_of_Contracts__c
                                          , Batch_logic_applied__c 
                                      FROM Order 
                                      WHERE Id =: contractedOrderUpdate1[0].Id OR 
                                            Id =: contractedOrderUpdate2[0].Id];
        System.debug('lstOrderBefore>>> '+lstOrderBefore);

        System.Test.startTest();
        UpdateOrderBatch objUpdateOrderBatch = new UpdateOrderBatch();
        Id batchJobId = Database.executeBatch(objUpdateOrderBatch, 200); 
        System.Test.stopTest();

        List<Order> lstOrderAfter = [SELECT 
                                          Id
                                        , Order_Status__c
                                        , SBQQ__Contracted__c
                                        , No_of_Contracts__c
                                        , Batch_logic_applied__c 
                                     FROM Order 
                                     where Id =: contractedOrderUpdate1[0].Id OR 
                                           Id =: contractedOrderUpdate2[0].Id];
        System.debug('SBQQ__Contracted__c After>>> '+lstOrderAfter[0].SBQQ__Contracted__c);
        
        System.assertEquals(2, lstOrderAfter.size());
        for(Order objTestOrder : lstOrderAfter) {
            System.assertEquals(true, objTestOrder.Batch_logic_applied__c);
        }
    }

    
    static testmethod void checkOrderContractedFieldOneOrderStatusDraft() {
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
        Order objOrder1 = new order();
        objOrder1.id = activateOrderUpdate[0].Id;        
        objOrder1.SBQQ__Contracted__c = true;
        objOrder1.Order_Status__c = 'Rejected';
        contractedOrderUpdate1.add(objOrder1);
        update contractedOrderUpdate1;

        List<Order> contractedOrderUpdate2 = new List<Order>();  
        Order objOrder2 = new order();
        objOrder2.id = activateOrderUpdate[1].Id;        
        objOrder2.SBQQ__Contracted__c = false;
        contractedOrderUpdate2.add(objOrder2);
        update contractedOrderUpdate2;

        List<Order> lstOrderBefore = [SELECT 
                                            Id
                                          , Order_Status__c
                                          , SBQQ__Contracted__c
                                          , No_of_Contracts__c
                                          , Batch_logic_applied__c 
                                      FROM Order 
                                      WHERE (Id =: contractedOrderUpdate1[0].Id OR 
                                            Id =: contractedOrderUpdate2[0].Id) AND
                                            Batch_logic_applied__c = false];
        System.debug('lstOrderBefore>>> '+lstOrderBefore);

        System.Test.startTest();
        UpdateOrderBatch objUpdateOrderBatch = new UpdateOrderBatch();
        Id batchJobId = Database.executeBatch(objUpdateOrderBatch, 200); 
        System.Test.stopTest();

        List<Order> lstOrderAfter = [SELECT 
                                          Id
                                        , Order_Status__c
                                        , SBQQ__Contracted__c
                                        , No_of_Contracts__c
                                        , Batch_logic_applied__c 
                                     FROM Order 
                                     where (Id =: contractedOrderUpdate1[0].Id OR 
                                           Id =: contractedOrderUpdate2[0].Id)
                                           AND Batch_logic_applied__c = true];
        System.debug('SBQQ__Contracted__c After>>> '+lstOrderAfter[0].SBQQ__Contracted__c);
        
        System.assertEquals(1, lstOrderAfter.size());
        for(Order objTestOrder : lstOrderAfter) {
            System.assertEquals(true, objTestOrder.Batch_logic_applied__c);
        }
    }

    static testmethod void checkOrderContractedFieldAllFiltersForMultipleRecords() {
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

        List<Order> lstOrders = TestUtilityClass.createOrdersForUpdateOrderBatch(lstAccount, lstOpportunity, lstQuotes, lstPriceBookEntry[0].Pricebook2Id, 10 );
        insert lstOrders;
        System.debug('lstOrders ID >>>> '+lstOrders);

        //Create Order Products
        List<OrderItem> lstOrderItem = TestUtilityClass.createOrderItemBulk(listProducts, lstOrders, lstQuoteLines, lstPriceBookEntry, 10);
        insert lstOrderItem;
        System.debug('lstOrderItem >>>>> '+lstOrderItem);
        System.debug('lstOrderItem Size >>>>> '+lstOrderItem.size());

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

        System.Test.startTest();
        UpdateOrderBatch objUpdateOrderBatch = new UpdateOrderBatch();
        Database.executeBatch(objUpdateOrderBatch, 50); 
        System.Test.stopTest();

        List<Order> lstOrderAfter = [SELECT 
                                          Id
                                        , Order_Status__c
                                        , SBQQ__Contracted__c
                                        , No_of_Contracts__c
                                        , Batch_logic_applied__c 
                                     FROM Order 
                                     where (Id IN : activateOrderUpdate OR 
                                           Id IN : contractedTrueOrderUpdate) AND 
                                           Batch_logic_applied__c = true];
        
        System.assertEquals(10, lstOrderAfter.size());
        for(Order objTestOrder : lstOrderAfter) {
            System.assertEquals(true, objTestOrder.Batch_logic_applied__c);
        }
    }

   static testMethod void callScheduler() {
       UpdateOrderBatchScheduler c = new UpdateOrderBatchScheduler();
       String sch0 = '0 0 23 * * ?';
       system.schedule('new UpdateOrderBatchScheduler', sch0, c);
   } 
}
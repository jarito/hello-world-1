@isTest
public class TestUtilityClass {
	/**    
     * Method to create test account records.
     */ 
    public static List<Account> createAccounts(String accName, Integer count) {
        List<Account> lstAccounts = new List<Account>();
        Account objAccount;
        for(Integer iterator = 1; iterator <= count; iterator++) {
            objAccount = new Account();
            objAccount.Name = accName + iterator;
            lstAccounts.add(objAccount);
        }
        return lstAccounts;
    }
    
    /**
     * Method to create test contact records.
     */ 
    public static List<Contact> createContacts(List<Account> lstAccounts) {
        List<Contact> lstContacts = new List<Contact>();
        for(Account accountIterator : lstAccounts) {
            lstContacts.add(new Contact(LastName = 'Test',
                                        Email = 'test@demo.com',
                                        AccountId = accountIterator.Id));
        }
        return lstContacts;
    }
    
    /**
     * Method to create test opportunity records.
     */ 
    public static List<Opportunity> createOpportunities(List<Account> lstAccounts) {
        List<Opportunity> lstOpportunities = new List<Opportunity>();
        for(Account accountIterator : lstAccounts) {
            lstOpportunities.add(new Opportunity(Name = 'Test Opportunity' + accountIterator.Name,
                                                 AccountId = accountIterator.Id,
                                                 StageName = 'Suspect',
                                                 CloseDate = date.today()));
        }
        return lstOpportunities;
    }
    
    /**
     * Method to create test product records.
     */ 
    public static List<Product2> createProducts(Integer count) {
        List<Product2> lstProducts = new List<Product2>();
        for(Integer iterator = 1; iterator <= count; iterator++) {
            lstProducts.add(new Product2(Name = 'Test Product ' + count,
                                         ProductCode = 'Test ' + count,
                                         IsActive = True));
        }
        return lstProducts;
    }
    
    /**
     * Method to create test price book entry records.
     */ 
    public static List<PriceBookEntry> createPriceBookEntries(List<Product2> lstProducts) {
        Id pricebookId = Test.getStandardPricebookId();
        System.debug('Std PB >>> '+Test.getStandardPricebookId());
        List<PriceBookEntry> lstPriceBookEntries = new List<PriceBookEntry>();
        PriceBookEntry objPriceBookEntry;
        for(Product2 objProduct : lstProducts) {
            objPriceBookEntry = new PriceBookEntry();
            objPriceBookEntry.IsActive = True;
            objPriceBookEntry.Pricebook2Id = pricebookId;
            objPriceBookEntry.Product2Id = objProduct.Id;
            objPriceBookEntry.UnitPrice = 100;
            lstPriceBookEntries.add(objPriceBookEntry);
        }
        insert lstPriceBookEntries;
        
       
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='CPQ Aug2018', isActive=true);
        insert customPB;
        
        List<PriceBookEntry> lstCustomPriceBookEntries = new List<PriceBookEntry>();
        PriceBookEntry objCustomPriceBookEntry;
        for(Product2 objProduct : lstProducts) {
            objCustomPriceBookEntry = new PriceBookEntry();
            objCustomPriceBookEntry.IsActive = True;
            objCustomPriceBookEntry.Pricebook2Id = customPB.Id;
            objCustomPriceBookEntry.Product2Id = objProduct.Id;
            objCustomPriceBookEntry.UnitPrice = 100;
            lstCustomPriceBookEntries.add(objCustomPriceBookEntry);
        }
        return lstCustomPriceBookEntries;
    
    }
    
    /**
     * Method to create test quote records.
     */ 
    public static List<SBQQ__Quote__c> createQuotes(List<Opportunity> lstOpportunity){
        List<SBQQ__Quote__c> lstQuotes = new List<SBQQ__Quote__c>();
        Date dateStartDate = Date.newInstance(2019, 06 , 10);
        Date dateEndDate = dateStartDate.addYears(1);
        Date segmentEndDate = dateStartDate.addDays(60);
        
        for(Opportunity objOpportunity : lstOpportunity) {
            lstQuotes.add(new SBQQ__Quote__c(SBQQ__Opportunity2__c = objOpportunity.Id,
                                             SBQQ__Primary__c = True,
                                             SBQQ__StartDate__c = dateStartDate,
                                             SBQQ__EndDate__c = dateEndDate,
                                             SBQQ__FirstSegmentTermEndDate__c = segmentEndDate
                                             ));
        }
        return lstQuotes;
    }
    /**
     * Method to create test quote records with Account.
     */ 
    public static List<SBQQ__Quote__c> createQuotesWithAccountt(List<Opportunity> lstOpportunity, List<Account> lstAccount){
        List<SBQQ__Quote__c> lstQuotes = new List<SBQQ__Quote__c>();
        for(Opportunity objOpportunity : lstOpportunity) {
            lstQuotes.add(new SBQQ__Quote__c(SBQQ__Opportunity2__c = objOpportunity.Id,
                                             SBQQ__Account__c = lstAccount[0].Id,
                                             SBQQ__Primary__c = True));
        }
        return lstQuotes;
    }
    
    /**
     * Method to create test quote line records.
     */ 
    public static List<SBQQ__QuoteLine__c> createQuoteLines(List<SBQQ__Quote__c> lstQuotes, List<Product2> lstProducts, Integer intQuantity) {
        List<SBQQ__QuoteLine__c> lstQuoteLines = new List<SBQQ__QuoteLine__c>();
        for(SBQQ__Quote__c objQuote : lstQuotes) {
            for(Product2 objProduct : lstProducts) {
                lstQuoteLines.add(new SBQQ__QuoteLine__c(SBQQ__Product__c = objProduct.Id,
                                                         SBQQ__Quote__c = objQuote.Id,
                                                         SBQQ__Quantity__c = intQuantity));
            }
        }
        return lstQuoteLines;
    }
    
    /**
     * Method to create test contract records from Opportunities
     */ 
    public static List<Contract> createContracts(List<Account> lstAccount, List<Opportunity> lstOpportunity, List<SBQQ__Quote__c> lstQuotes){
        List<Contract> lstContracts = new List<Contract>();
        for(Account objAccount : lstAccount) {
            lstContracts.add(new Contract(AccountId = objAccount.Id,
                                          SBQQ__Opportunity__c = lstOpportunity[0].Id,
                                          SBQQ__Quote__c = lstQuotes[0].Id,
                                          Status = 'Draft',
                                          StartDate = Date.today(),
                                          ContractTerm = 12)); 
        }
        return lstContracts;
    }
    
    /**
     * Method to create test subscription records.
     */ 
    public static List<SBQQ__Subscription__c> createSubscriptions(List<Contract> lstContracts, List<Product2> lstProducts, Integer intQuantity) {
        List<SBQQ__Subscription__c> lstSubscriptions = new List<SBQQ__Subscription__c>();
        
        Date dateEndDate = Date.newInstance(2019, 10 , 10);
        Date dateStartDate = Date.newInstance(2018, 5 , 5);
        
        for(Contract objContract : lstContracts) {
            for(Product2 objProduct : lstProducts) {
                lstSubscriptions.add(new SBQQ__Subscription__c(SBQQ__Account__c = objContract.AccountId,
                                                               SBQQ__Product__c = objProduct.Id,
                                                               SBQQ__Contract__c = objContract.Id,
                                                               SBQQ__Quantity__c = intQuantity,
                                                               SBQQ__SegmentStartDate__c = dateStartDate,
                                                               SBQQ__SegmentEndDate__c = dateEndDate,
                                                               SBQQ__TerminatedDate__c = dateEndDate,
                                                               SBQQ__RenewalPrice__c = 150));    
             }                
        }
        return lstSubscriptions; 
    }
    
     /**
     * Method to create custom pricebook 
     */
      
    public static Pricebook2 createPriceBook() {
        String strPriceBookName = 'Professional Service Price Book';
        /*List<Pricebook2> lstPriceBook = [SELECT Name,IsActive  FROM Pricebook2 
                                         WHERE Name =: strPriceBookName  
                                         AND IsActive = true
                                         LIMIT 1];*/
        Pricebook2 pbObj= new Pricebook2 (Name = strPriceBookName, IsActive = true);
        return pbObj ;
    }

    /** 
     * Method to create Orders
     **/
    public static List<Order> createOrders(List<Account> lstAccounts, List<Opportunity> lstOpportunities, List<SBQQ__Quote__c> lstQuotes, Id customPriceBookId, Integer count ) {
        List<Order> lstOrders = new List<Order>();
        for(Integer i = 0; i < count ; i++ ) {
            Order objOrder = new Order();
            objOrder.AccountId = lstAccounts[0].Id;
            objOrder.SBQQ__Quote__c = lstQuotes[0].Id;
            objOrder.OpportunityId = lstOpportunities[0].Id;
            objOrder.EffectiveDate = Date.today();
            objOrder.Status = 'Draft';
            objOrder.Pricebook2Id = customPriceBookId;
            lstOrders.add(objOrder);
        }
        return lstOrders ;
    }

    /** 
     * Method to create Orders
     **/
    public static List<Order> createOrdersForUpdateOrderBatch(List<Account> lstAccounts, List<Opportunity> lstOpportunities, List<SBQQ__Quote__c> lstQuotes, Id customPriceBookId, Integer count) {
        List<Order> lstOrders = new List<Order>();
        for(Integer i = 0; i < count ; i++ ) {
            Order objOrder = new Order();
            objOrder.AccountId = lstAccounts[0].Id;
            objOrder.SBQQ__Quote__c = lstQuotes[0].Id;
            objOrder.OpportunityId = lstOpportunities[0].Id;
            objOrder.EffectiveDate = Date.today();
            objOrder.Status = 'Draft';
            objOrder.Order_Status__c = 'Shipped';
            objOrder.Pricebook2Id = customPriceBookId;
            lstOrders.add(objOrder);
        }
        return lstOrders ;
    }

    /** 
     * Method to create Order Products
     **/
    public static List<OrderItem> createOrderItem(List<Product2> lstProducts, List<Order> lstOrders, List<SBQQ__QuoteLine__c> lstQuoteLines, List<PriceBookEntry> lstPriceBookEntry,  Integer count ) {
        List<OrderItem> lstOrderItem = new List<OrderItem>();
        for(Integer i = 0; i < count ; i++ ) {
            if(i == 0) {
                OrderItem objOrderItem = new OrderItem();
                objOrderItem.Product2Id = lstProducts[0].Id;
                objOrderItem.OrderId = lstOrders[0].Id;
                objOrderItem.Quantity = 1;
                objOrderItem.SBQQ__ProductSubscriptionType__c = 'Renewable';
                objOrderItem.UnitPrice = 20000;
                objOrderItem.PricebookEntryId = lstPriceBookEntry[0].Id;
                objOrderItem.SBQQ__QuoteLine__c = lstQuoteLines[0].Id;
                lstOrderItem.add(objOrderItem);
            }
            if(i == 1) {
                OrderItem objOrderItem = new OrderItem();
                objOrderItem.Product2Id = lstProducts[0].Id;
                objOrderItem.OrderId = lstOrders[1].Id;
                objOrderItem.Quantity = 1;
                objOrderItem.SBQQ__ProductSubscriptionType__c = 'Renewable';
                objOrderItem.UnitPrice = 20000;
                objOrderItem.PricebookEntryId = lstPriceBookEntry[0].Id;
                objOrderItem.SBQQ__QuoteLine__c = lstQuoteLines[0].Id;
                lstOrderItem.add(objOrderItem);
            }
        }
        return lstOrderItem ;
    }

    /** 
     * Method to create Order Products
     **/
    public static List<OrderItem> createOrderItemBulk(List<Product2> lstProducts, List<Order> lstOrders, List<SBQQ__QuoteLine__c> lstQuoteLines, List<PriceBookEntry> lstPriceBookEntry,  Integer count ) {
        List<OrderItem> lstOrderItem = new List<OrderItem>();
        for(Order objOrder : lstOrders) { 
            OrderItem objOrderItem = new OrderItem();
            objOrderItem.Product2Id = lstProducts[0].Id;
            objOrderItem.OrderId = objOrder.Id;
            objOrderItem.Quantity = 1;
            objOrderItem.SBQQ__ProductSubscriptionType__c = 'Renewable';
            objOrderItem.UnitPrice = 20000;
            objOrderItem.PricebookEntryId = lstPriceBookEntry[0].Id;
            objOrderItem.SBQQ__QuoteLine__c = lstQuoteLines[0].Id;
            lstOrderItem.add(objOrderItem); 
        }
        return lstOrderItem ;
    }

    /**
     * Method to create test contract records from Order
     */ 
    public static List<Contract> createContractsFromOrder(List<Account> lstAccount, List<Opportunity> lstOpportunity, List<Order> lstOrders, List<SBQQ__Quote__c> lstQuotes, Integer count){
        List<Contract> lstContracts = new List<Contract>();
        Date myDate = date.newinstance(2018, 10, 10);
        for(Integer i = 0; i < count ; i++) {
            Contract objContract = new Contract();
            objContract.AccountId = lstAccount[0].Id;
            objContract.SBQQ__Opportunity__c = lstOpportunity[0].Id;
            objContract.SBQQ__Quote__c = lstQuotes[0].Id;
            objContract.SBQQ__Order__c = lstOrders[0].Id;
            objContract.Status = 'Draft';
            objContract.StartDate = myDate;
            objContract.ContractTerm = 12;
            lstContracts.add(objContract);
        }
        return lstContracts;
    }

    /**
     * Method to create test subscription records.
     */ 
    public static List<SBQQ__Subscription__c> createSubscriptionsForDateRollUp(List<Contract> lstContracts, List<Product2> lstProducts, Integer count) {
        List<SBQQ__Subscription__c> lstSubscriptions = new List<SBQQ__Subscription__c>();
        
        Date dateEndDate = Date.newInstance(2018, 10 , 10);
        Date dateStartDate = Date.newInstance(2019, 10 , 9);
        for(Integer i = 0; i < count; i++) {
            if(i == 0) {
                lstSubscriptions.add(new SBQQ__Subscription__c(SBQQ__Account__c = lstContracts[0].AccountId,
                                                        SBQQ__Product__c = lstProducts[0].Id,
                                                        SBQQ__Contract__c = lstContracts[0].Id,
                                                        SBQQ__Quantity__c = 2,
                                                        SBQQ__SegmentStartDate__c = dateStartDate,
                                                        SBQQ__SegmentEndDate__c = dateEndDate,
                                                        SBQQ__TerminatedDate__c = dateEndDate,
                                                        SBQQ__RenewalPrice__c = 150,
                                                        SBQQ__RenewedDate__c = Date.newInstance(2018, 10 , 10)));
            }
            else if(i == 1) {
                lstSubscriptions.add(new SBQQ__Subscription__c(SBQQ__Account__c = lstContracts[1].AccountId,
                                                        SBQQ__Product__c = lstProducts[1].Id,
                                                        SBQQ__Contract__c = lstContracts[1].Id,
                                                        SBQQ__Quantity__c = 2,
                                                        SBQQ__SegmentStartDate__c = dateStartDate,
                                                        SBQQ__SegmentEndDate__c = dateEndDate,
                                                        SBQQ__TerminatedDate__c = dateEndDate,
                                                        SBQQ__RenewalPrice__c = 150,
                                                        SBQQ__RenewedDate__c = Date.newInstance(2017, 10 , 10)));
            }
            else if(i == 2) {
                lstSubscriptions.add(new SBQQ__Subscription__c(SBQQ__Account__c = lstContracts[0].AccountId,
                                                        SBQQ__Product__c = lstProducts[0].Id,
                                                        SBQQ__Contract__c = lstContracts[0].Id,
                                                        SBQQ__Quantity__c = 2,
                                                        SBQQ__SegmentStartDate__c = dateStartDate,
                                                        SBQQ__SegmentEndDate__c = dateEndDate,
                                                        SBQQ__TerminatedDate__c = dateEndDate,
                                                        SBQQ__RenewalPrice__c = 150,
                                                        SBQQ__RenewedDate__c = Date.newInstance(2016, 10 , 10)));
            }            
        }  
        return lstSubscriptions; 
    }

}
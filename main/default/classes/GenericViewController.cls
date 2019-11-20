public class GenericViewController {
 @auraEnabled
    public static List<sobject> findRecords(String recId){
        String currentRecordID = recID;
        Id rId = Id.valueOf(recId);
        system.debug('ID is--->'+rId);
        Schema.SObjectType token = rId.getSObjectType();
        Schema.DescribeSObjectResult dr = token.getDescribe();
		String objectName = dr.getName();
		system.debug('objectName is--->'+objectName);        
        string queryString ='';
        List<sobject> returnList=new List<sobject>();
        if(objectName != null  && objectName == 'Opportunity' && objectName != 'Account' ){
      		queryString='select OrderNumber,TotalAmount,Account.Name,EffectiveDate,Status,OpportunityId,(Select Product2.Name,Product2.ProductCode,Quantity,UnitPrice,OrderId from OrderItems ) from Order where OpportunityId =: currentRecordID' ;
        }
        else if(objectName != null && objectName != 'Opportunity' && objectName == 'Account' ){
            queryString='select  name,StageName,Amount,CloseDate,(Select id,OrderNumber,TotalAmount,Account.Name,EffectiveDate,Status From orders)  from Opportunity where AccountId =: currentRecordID';  
        }
        system.debug('**queryString:'+queryString);
        returnList=database.query(queryString);
        system.debug('**List:'+returnList);
     return returnList;
    }
  
	@AuraEnabled
    public static List<Opportunity> getClosedOpportunities(String accountId) {
		List<Opportunity> opportunityList = [Select
                                                Id,
                                            	Name,
                                            	StageName,
                                             	Amount,
                                            	CloseDate,
                                                (Select id,OrderNumber,TotalAmount,Account.Name,EffectiveDate,Status From orders)
                                             From
                                            	Opportunity
                                             Where
                                               (StageName = 'Closed Won' or
                                             	StageName = 'Closed Lost') and
                                            	AccountId =: accountId];
        return opportunityList;
    }
    
 @auraEnabled(cacheable=true)
    public static List<sobject> getOrderList(String recId){
        String currentRecordID = recID;
        Id rId = Id.valueOf(recId);
        system.debug('ID is--->'+rId);
        Schema.SObjectType token = rId.getSObjectType();
        Schema.DescribeSObjectResult dr = token.getDescribe();
		String objectName = dr.getName();
		system.debug('objectName is--->'+objectName);        
        string queryString ='';
        List<sobject> returnList=new List<sobject>();
        if(objectName != null  && objectName == 'Opportunity' && objectName != 'Account' ){
      		queryString='select OrderNumber,TotalAmount,Account.Name,Status from Order where OpportunityId =: currentRecordID' ;
        }
        else if(objectName != null && objectName != 'Opportunity' && objectName == 'Account' ){
            queryString='select  name,StageName,Amount,CloseDate  from Opportunity where AccountId =: currentRecordID';  
        }
        system.debug('**queryString:'+queryString);
        returnList=database.query(queryString);
     return returnList;
    }  

    @auraEnabled(cacheable=true)
    public static List<Account> getAccounts(String recId){
        List<Account> accountList = [Select id, name From Account LIMIT 5];
        return accountList;
    }

    @auraEnabled
    public static List<OrderItem> getOrderItems(String recId){
        List<OrderItem> orderItemsList = [Select  id, 
                                                  Product2.Name,
                                                  Product2.ProductCode,
                                                  Quantity,
                                                  UnitPrice,
                                                  OrderId 
                                          From 
                                                  OrderItem 
                                          Where 
                                                  OrderId =: recId ];
        return orderItemsList;
    }
    @auraEnabled
    public static OrderItem getOrderProduct(){
        OrderItem orderItemsList = [Select  id, 
                                                  Product2.Name,
                                                  Product2.ProductCode,
                                                  Quantity,
                                                  UnitPrice,
                                                  OrderId 
                                          From 
                                                  OrderItem 
                                          Where 
                                                  Id = '8026F000007UzJAQA0' ];
        return orderItemsList;
    }
    
/*    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Opportunity', 'Opportunity');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();
        VisualEditor.DataRow value1 = new VisualEditor.DataRow('Opportunity', 'Opportunity');
        myValues.addRow(value1);
        VisualEditor.DataRow value2 = new VisualEditor.DataRow('Order', 'Order');
        myValues.addRow(value2);
        return myValues;
    }
*/
    
    
}
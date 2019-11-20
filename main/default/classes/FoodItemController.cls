public class FoodItemController {
      @AuraEnabled
/*    public static List <FoodItems__c> getFooditems() {
    	//List<FoodItems__c> foodItemsList = [SELECT Id, Name, Price__c FROM FoodItems__c ORDER BY Price__c ASC]; 
        return [SELECT Id, Name, Price__c FROM FoodItems__c ORDER BY Price__c ASC];
    }
*/
   public static FoodItemController.wrapperClass getFooditems( String recordId) {
      //public static List <FoodItems__c> getFooditems() {
      //
         
        wrapperClass objwrapperClass =  new  wrapperClass();
        List<FoodItems__c> foodItemsList = [SELECT Id, Name, Price__c FROM FoodItems__c ORDER BY Price__c ASC];
        Contact contactObj = [ SELECT  LastName,MailingCity ,MailingCountry ,MailingPostalCode ,MailingState ,MailingStreet  FROM Contact Where Id=:recordId][0];
		String orgId = UserInfo.getOrganizationId();
       system.debug('-----Id-----'+orgId);
        Organization  companyObj = [Select City,Country,PostalCode,State,Street From Organization Where id=:orgId][0];
      
        // return [SELECT Id, Name, Price__c FROM FoodItems__c ORDER BY Price__c ASC];
        objwrapperClass.foodItemsList = foodItemsList ;
        objwrapperClass.contactObj = contactObj ;
        objwrapperClass.companyObj = companyObj;
        system.debug('returning'+objwrapperClass);
        return objwrapperClass;
        
      }
    
    public class wrapperClass{
         @AuraEnabled public List <FoodItems__c> foodItemsList;
         @AuraEnabled public Contact contactObj;
         @AuraEnabled public Organization companyObj;
         public wrapperClass(){}	
         public wrapperClass(List <FoodItems__c> foodItemsListParm,Contact contactObjParm,Organization companyObjParm){
        //public wrapperClass(List <FoodItems__c> foodItemsListParm){    
           foodItemsList = foodItemsListParm;
           contactObj = contactObjParm;
           companyObj = companyObjParm;  
         } 
    }

}
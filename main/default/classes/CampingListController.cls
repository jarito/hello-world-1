public class CampingListController {
	@AuraEnabled
    public static List<Camping_Item__c> getItems() {
        List<Camping_Item__c> campingObj = [Select Name, Packed__c, Price__c, Quantity__c From Camping_Item__c ];
        return campingObj;
    }
    
	@AuraEnabled
    public static Camping_Item__c saveItem (Camping_Item__c CampingItem) {
		insert  CampingItem;
        return CampingItem; 
    }
    
}
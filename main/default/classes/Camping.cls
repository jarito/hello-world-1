public class Camping {
	@AuraEnabled
    public static List<Camping_Item__c> getValues() {
        List<Camping_Item__c> objCamping = new List<Camping_Item__c>();
        List<Camping_Item__c> campingObj = [Select Name, Packed__c, Price__c, Quantity__c From Camping_Item__c ];
        objCamping = campingObj;
        return objCamping;
    }
    
	@AuraEnabled
    public static Camping_Item__c saveItem (Camping_Item__c item) {
		upsert item;
        return item;
    }
}
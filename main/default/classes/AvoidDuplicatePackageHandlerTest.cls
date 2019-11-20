/**
 * This test class checks the code coverage for class AvoidDuplicatePackageHandler and 
 * checks its working for various scenarios
 */
@isTest
public class AvoidDuplicatePackageHandlerTest {
	/**
     * This method checks whether the handler correctly handles the correct input. It checks whether
     * same package is allowed for different Event-GroupCode combination  
     */
    static testMethod void validPackages(){
        /**
		 * Insertion of Event object records
		 */
		List<Event__c> eventList = TestDataFactory.createEvents(5);
        insert eventList;
        List<ID> eventIds = new List<ID>();
        for(Event__c eachId : eventList){
            eventIds.add(eachId.Id);
        }
        /**
		 * Insertion of GroupCode object records
		 */        
        List<Group_Code__c> groupCodeList = TestDataFactory.createGroupCode(6);
        insert groupCodeList;
        List<Group_Code__c> groupList = [Select Id,Name From Group_Code__c];
        List<ID> groupCodeIds = new List<ID>();
        for(Group_Code__c eachId : groupList){
            groupCodeIds.add(eachId.Id);
        }
        /**
		 * Insertion of Package object records
		 */        
        List<Package__c> packageList = TestDataFactory.createPackages(5,eventIds,groupCodeIds,'valid');
		insert packageList;
        /**
		 * Insertion of Package object record on which actual trigger is invoked
		 */
        List<Package__c> packageListNew = TestDataFactory.createPackages(1,eventIds,groupCodeIds,'validCheck'); 
        Set<String> packageNames = new Set<String>();
        for(Package__c packageVar : packageListNew){
            packageNames.add(packageVar.Name);
        }
       
       	test.startTest();     
        insert packageListNew;
        test.stopTest(); 
        system.assertEquals(1, packageNames.size());
    }
 	/**
     * This method checks whether the handler correctly handles the incorrect input. It checks whether
     * same package is allowed for same Event-GroupCode combination  
     */   
	static testMethod void invalidPackages(){
        /**
		 * Insertion of Event object records
		 */
		List<Event__c> eventList = TestDataFactory.createEvents(5);
        insert eventList;
        List<ID> eventIds = new List<ID>();
        for(Event__c eachId : eventList){
            eventIds.add(eachId.Id);
        }
        /**
		 * Insertion of GroupCode object records
		 */        
        List<Group_Code__c> groupCodeList = TestDataFactory.createGroupCode(5);
        insert groupCodeList;
        List<Group_Code__c> groupList = [Select Id,Name From Group_Code__c];
        List<ID> groupCodeIds = new List<ID>();
        for(Group_Code__c eachId : groupList){
            groupCodeIds.add(eachId.Id);
        }        
        /**
		 * Insertion of Package object records
		 */       
        List<Package__c> packageList = TestDataFactory.createPackages(5,eventIds,groupCodeIds,'valid');
		insert packageList;
        /**
		 * Insertion of Package object record on which actual trigger is invoked
		 */ 
        List<Package__c> packageListNew = TestDataFactory.createPackages(2,eventIds,groupCodeIds,'Invalid'); 
        Set<String> packageNames = new Set<String>();
        for(Package__c packageVar : packageListNew){
            packageNames.add(packageVar.Name);
        }
       	test.startTest();    
        database.insert(packageListNew,false);
        test.stopTest(); 
        system.assertEquals(1, packageNames.size());
    }    
}
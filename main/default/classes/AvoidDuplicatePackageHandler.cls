public class AvoidDuplicatePackageHandler {
    public void checkDuplicate(List<Package__c> listOfPackages){
        List<Package__c> packageList = [Select
                                       			Event__c,
                                       			Group_Code__c,
                                        		Name
                                       	From 		
                                       			Package__c];
        for(Package__c eachListObj : listOfPackages){
            for(Package__c packageObj : packageList){
                if((eachListObj.Event__c == packageObj.Event__c) && 
                   (eachListObj.Group_Code__c == packageObj.Group_Code__c)){
	                       system.debug('---Duplicate---');
    	                   eachListObj.Name.addError('Package for this Combination of Event and GroupCode already exists, please enter new Package');                           
                } 
            }
        }
    }
}
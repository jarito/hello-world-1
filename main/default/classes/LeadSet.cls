public with sharing class LeadSet {
    /* This function retrives a list of Leads and stores its IDs in a Set */
	public void getLeads() {
        system.debug('Leads stored  in Set are : ');		
        List<Lead> leadList = [SELECT Id from Lead LIMIT 5];	
        for( Lead leadId : leadList ){
        	system.debug(leadId);
        }  

        system.debug('Leads stored  in Set are : ');
        Set<Id> leadSetobj = new Set<Id>();
        for( Lead leadSetvar : leadList ){
            leadSetobj.add(leadSetVar.Id);
        }
        system.debug(leadSetobj);
    }	
}
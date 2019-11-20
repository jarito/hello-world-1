public with sharing class LeadStatus {
	/* This function finds all the leads with Status 'Working - Contacted' and 
		updates it with 'Open - Non Contacted' */
	public LeadStatus() {
		List<Lead> leadList= [Select Id, Name, Status From Lead Where Status = 'Working - Contacted'];
		for(Lead leadStatus:leadList){
			system.debug(leadStatus);
			leadStatus.Status = 'Open - Not Contacted';
		}
		try {
		   update leadList;
		}
		 catch (DmlException e) {
		}
	}
}
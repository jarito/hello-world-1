/**
 * Class to detect and remove duplicate leads
 */
global class DuplicateLead implements Database.Batchable<sObject> {
   /** 
    * This start method will return a list to execute method for further processing 
	*/
	global Database.QueryLocator start(Database.BatchableContext bc){
		return database.getQueryLocator([Select 
												Email,
												FirstName,
												Phone
										From 
												Lead
									    Where 
												Email != null OR FirstName!=null OR Phone !=null
										]);
	} 

	/** 
	 * LeadList is a List returned from start method 
	 */
	global void execute(Database.BatchableContext bc, List<Lead> leadList){
	   /** 
	    * Here Duplicates leads are determined based on Email Id as Filtering criteria. 
		* All duplicates leads are collected in  List named 'duplicateLeadEmail' and that 
		* List is deleted so as to remove  the duplicate Lead records.
		*/
		if(DuplicateCheck__c.getInstance().EmailBased__c){
   			system.debug('--------------------Email based----------------');
			List<Lead> duplicateLeadEmail = new List<Lead>();
			Set<String> uniqueLeadEmail = new Set<String>();
			for(Lead eachLead : leadList) {
				if(!uniqueLeadEmail.contains(eachLead.Email)){
					uniqueLeadEmail.add(eachLead.Email);
				}
				else{
					duplicateLeadEmail.add(eachLead);
				}
			}
			system.debug('Test Uniqye Emails'+uniqueLeadEmail);
			for(Lead leadObject : duplicateLeadEmail){
				system.debug('Leads containing duplicate email Ids' + leadObject);
			}
			delete duplicateLeadEmail;
		
		}

		/**
	    * Here Duplicates leads are determined based on Name of the Lead as Filtering criteria. 
		* All duplicates leads are collected in  List named 'duplicateLeadName' and that List is
		* deleted so as to remove  the duplicate Lead records.
		*/
		if(DuplicateCheck__c.getInstance().FirstNameBased__c){
    		system.debug('--------------------Name based----------------');
			List<Lead> duplicateLeadName = new List<Lead>();
			Set<String> uniqueLeadName = new Set<String>();
			for(Lead eachLeadName : leadList) {
				if(!uniqueLeadName.contains(eachLeadName.FirstName)){
					uniqueLeadName.add(eachLeadName.FirstName);
				}
				else{
					duplicateLeadName.add(eachLeadName);
				}
			}
			for(Lead leadObjectName : duplicateLeadName){
				system.debug('Leads containing duplicate Names Ids' + leadObjectName);
			}
			delete duplicateLeadName;
		}

	   /** 
	    * Here Duplicates leads are determined based on Phone Number of the Lead as Filtering criteria. 
		* All duplicates leads are collected in  List named 'duplicateLeadPhone' and that List is
		* deleted so as to remove  the duplicate Lead records.
		*/
		if(DuplicateCheck__c.getInstance().PhoneBased__c){
			List<Lead> duplicateLeadPhone = new List<Lead>();
			Map<String,Lead> mapLead = new Map<String,Lead>();
			for(Lead eachLeadPhone : leadList) {
				if(!mapLead.containsKey(eachLeadPhone.Phone)){
					mapLead.put(eachLeadPhone.Phone , eachLeadPhone);
				}
				else{
					duplicateLeadPhone.add(eachLeadPhone);
				}
			}
			for(Lead leadObjectPhone : duplicateLeadPhone){
				system.debug('Leads containing duplicate Phone Numbers Ids' + leadObjectPhone);
			}
			delete duplicateLeadPhone;			
		}
	}
	global void finish(Database.BatchableContext bc){
		system.debug('Reached here');
	}

}
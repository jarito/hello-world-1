public with sharing class InsertLeads {
	public void insertLeadrecords(){
		List<Lead> leadList = new List<Lead>();
		Lead leads ;
		for(Integer record = 0 ; record<100 ; record++){
			if(record<69){
				leads = new Lead(LastName='TestLead'+string.valueof(record) , 
								 City = 'Pune', 
								 Company = 'Company'+string.valueof(record),  
								 Status = 'Won'+string.valueof(record));
				leadList.add(leads);
			}
			else if(record >=69 && record <89){
				leads = new Lead(LastName='TestLead'+string.valueof(record) , 
								 City = 'Mumbai', 
								 Company = 'Company'+string.valueof(record), 
								 Status = 'Won'+string.valueof(record));
				leadList.add(leads);
			}
			else{
				leads = new Lead(LastName='',City = 'Pune',
								 Company = 'Company'+string.valueof(record),
								 Status = 'Won'+string.valueof(record));
				leadList.add(leads);
			}
			
		}
		Database.SaveResult[] result = Database.insert(leadList,false);
		
		system.debug('---Save result output----'+result);

		for(Database.SaveResult sr : result){
			if(sr.isSuccess()){
				system.debug('---Successfully inserted records---'+sr.getId());
			}
			else{
				for(Database.Error error : sr.getErrors()){
					system.debug('The Error is: '+error.getMessage());
					Logs__c logObject = new Logs__c(Error__c = +error.getMessage());
					insert logObject;
				} 
   			}
		}
	}
}
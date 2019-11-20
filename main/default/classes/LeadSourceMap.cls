public with sharing class LeadSourceMap {
	public void getMap() {
		Map<String,map<String,Integer>> mapOfStatus = new Map<String,map<String,Integer>>(); 
		Map<String,Integer> mapOfSource ; 
		/* Get Lead Status and Lead Source of all the leads */
		list<Lead> listOfLeads = [Select 
                          				LeadSource,Status 	
                          		  From
                         				Lead
								  Order By 
								  		Status];
		/*
		for(Lead leads : listOfLeads){
			if(mapOfSource.containsKey(leads.LeadSource)){
				Integer count =  mapOfSource.get(leads.LeadSource);
				count++;
				mapOfSource.put(leads.LeadSource,count);
				
			}
			else{
				mapOfSource.put(leads.LeadSource,1);
			}
		}*/

		for(Lead lead : listOfLeads){
			if(mapOfStatus.containsKey(lead.Status)){
				if(mapOfSource.containsKey(lead.LeadSource)){
					Map<String,Integer> mapTemp = mapOfStatus.get(lead.Status);
					Integer count = mapTemp.get(lead.LeadSource);
					count++;
					mapTemp.put(lead.LeadSource,count);
					mapOfStatus.put(lead.Status,mapTemp);
				}
				else{
					mapOfSource.put(lead.LeadSource,1);
					mapOfStatus.put(lead.Status,mapOfSource);
				}

			}
			else{
				/* Creates a new map for every Lead Status so as to store 
				   a map of Lead Source and Lead count */
				mapOfSource = new Map<String,Integer>();
				mapOfStatus.put(lead.Status,mapOfSource);
			}
		}
		system.debug('----Map is----'+mapOfStatus);
	}
}
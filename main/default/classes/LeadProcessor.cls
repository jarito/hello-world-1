global class LeadProcessor implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id, LeadSource From Lead');
    }
    global void execute(Database.BatchableContext bc , List<Lead> leadList){
        List<Lead> listOfLeads = new List<Lead>();
        for(Lead eachLead : leadList){
            eachLead.LeadSource = 'Dreamforce';
            listOfLeads.add(eachLead);
        }
        update listOfLeads;
    }
    global void finish(Database.BatchableContext bc ){
        
    }
}
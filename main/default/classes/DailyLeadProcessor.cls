global class DailyLeadProcessor implements Schedulable{
    global void execute(SchedulableContext sc){
        List<Lead> listOfLeads = new List<Lead>();
        List<Lead> listLeadSource = new List<Lead>([Select Id, LeadSource From Lead Where LeadSource = null]);
        for(Lead eachLead : listLeadSource){
            eachLead.LeadSource = 'DreamForce';
            listOfLeads.add(eachLead);
        }
        update listOfLeads;
    }
}
public class DistinctLeads{
    /* Method to display distinct leads */
    public DistinctLeads(){
        /* List of All Distinct Leads with their count */
        List<AggregateResult> listOfLeads = [SELECT 
                                                    LeadSource, 
                                                    COUNT(Name)
                                             FROM 
                                                    Lead
                                             GROUP BY 
                                                    LeadSource
                                             HAVING 
                                                    COUNT(Name) > 10 ];
    
        for(AggregateResult aggregateVar : listOfLeads){
            system.debug(aggregateVar);
        }
    }
}
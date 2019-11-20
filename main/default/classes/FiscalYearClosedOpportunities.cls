public with sharing class FiscalYearClosedOpportunities {
	/* Method to find all closed Opportunities this Fiscal year */
	public FiscalYearClosedOpportunities() {
		/* List of all closed opportunities which are closed this Fiscal year */
		List<AggregateResult> aggregateList = [	SELECT  
                                       					SUM(Amount),
                                       					FiscalYear
                                      			FROM 
                                       					Opportunity
                                       			Where 
                                       					FiscalYear=2018
                                       			Group by  
                                       					FiscalYear
                                      		  ] ;
		/* Map of Year and Closed Opportunities, where key is Fiscal year and value is Sum of Amount */
		Map<Integer , Decimal> sumtoFiscalYear = new Map<Integer,Decimal>() ;

		for(AggregateResult eachResult : aggregateList){  
			sumtoFiscalYear.put((Integer)eachResult.get('FiscalYear') ,((Decimal)eachResult.get('expr0')).longValue())  ; 
		}

		System.debug('----Year to Sum of Amount Map----'+sumtoFiscalYear);

	}
}
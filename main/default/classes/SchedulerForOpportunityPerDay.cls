global class SchedulerForOpportunityPerDay implements Schedulable {
    /**
     * Daily at Midnight 12am
     */
    global static String expression = '0 0 0 * * ?';
    global static String scheduleMe() {
        SchedulerForOpportunityPerDay objectScheduler = new SchedulerForOpportunityPerDay();
        return System.schedule('Opportunity Per Day', expression, objectScheduler);
    }
    /**
     * Batch named OpportunityPerDay is executed from here
     */  
   global void execute(SchedulableContext sc) {
      OpportunityPerDay objectOpportunityPerDay = new OpportunityPerDay();
      database.executebatch(objectOpportunityPerDay);
   }
}
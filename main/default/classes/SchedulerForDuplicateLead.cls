global class SchedulerForDuplicateLead implements Schedulable {
    /**
     * Every 3 hours
     */
    global static String expression = '0 0 */3 ? * *'; 
    global static String scheduleMe() {
        SchedulerForDuplicateLead objectScheduler = new SchedulerForDuplicateLead();
        return System.schedule('Duplicate Lead', expression, objectScheduler);
    }
    
    global void execute(SchedulableContext sc) {
    DuplicateLead objectDuplicateLead = new DuplicateLead();
    database.executebatch(objectDuplicateLead);
   }
}
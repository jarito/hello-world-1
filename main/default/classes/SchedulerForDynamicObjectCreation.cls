global class SchedulerForDynamicObjectCreation implements Schedulable {
    /**
     * Every hour
     */
    global static String expression = '0 0 * ? * *'; 
    global static String scheduleMe() {
        SchedulerForDynamicObjectCreation objectScheduler = new SchedulerForDynamicObjectCreation();
        return System.schedule('Dynamic Object Creation', expression, objectScheduler);
    }
    /**
     * Batch named DynamicObjectCreation is executed from here
     */   
   global void execute(SchedulableContext sc) {
      DynamicObjectCreation objectDynamicObjectCreation = new DynamicObjectCreation();
      database.executebatch(objectDynamicObjectCreation);
   }
}
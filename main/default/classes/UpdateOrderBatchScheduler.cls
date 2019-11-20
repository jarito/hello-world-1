global class UpdateOrderBatchScheduler implements System.Schedulable { 
    
    /**
     * Method which executes Batch 'UpdateOrderBatch'
     */
    global void execute(SchedulableContext ctx) {
        Database.executeBatch(new UpdateOrderBatch(), 10);
    }
}
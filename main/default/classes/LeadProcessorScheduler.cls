public class LeadProcessorScheduler implements Schedulable{
	public void execute(SchedulableContext sc) {
        LeadProcessor obj = new LeadProcessor();
        Database.executeBatch(obj);
    }
}
@isTest
public class LeadProcessorTest {
	
    public static testMethod void setup1(){
        List<Lead> listOfLeads = new List<Lead>();
        for(Integer i = 0; i<200 ;i++){
            Lead eachLead = new Lead();
            eachLead.LastName = 'Test'+i;
            eachLead.Company = 'TestCompany'+i;
            eachLead.Status = 'Test';
            listOfLeads.add(eachLead);
        }
        insert listOfLeads;
        
        test.startTest();
        LeadProcessor objectLeadProcessor = new LeadProcessor();
        ID batchId = Database.executeBatch(objectLeadProcessor);
        test.stopTest();
        system.assertEquals(200, [Select count() From Lead Where LeadSource='Dreamforce']);
    }	
}
@isTest
public class DailyLeadProcessorTest {
    public static testMethod void testM1(){
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
        DailyLeadProcessor dlp = new DailyLeadProcessor();
        String jobId = System.schedule('DailyLeadProcessor', '0 0 0 1 12 ? 2018*', dlp);
        test.stopTest();
        
        List<lead> l_lst_chk = new List<lead>([select id,leadsource from lead where leadsource != 'Dreamforce']);
		System.assertequals(0,l_lst_chk.size());
    }
}
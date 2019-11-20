@isTest
public class LeadProcessorSchedulerTest {
    public static testmethod void test1(){
        Test.startTest();
        LeadProcessorScheduler obj = new LeadProcessorScheduler();
        String CRON_EXP = '0 0 0 3 9 ? 2022';
        String jobId = System.schedule('BorrarAseguradosTest', CRON_EXP, obj);
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        Test.stopTest();
        System.debug('CronJobDetail Name >> '+CronJobDetail.Id);
        //System.assertEquals(0, ct.CronJobDetail.Name);
    }
}
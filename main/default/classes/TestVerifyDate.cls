@isTest
public class TestVerifyDate {
    static testMethod void correctDate(){

        Date date1 = date.newInstance(2018, 11, 17);
        Date date2 = date1.addDays(10);
      	Date m1 = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, m1);
        
        Date date3 = date.newInstance(2018, 11, 17);
        Date date4 = date3.adddays(32);
      	Date m2 = VerifyDate.CheckDates(date3, date4);
        System.assertNotEquals(date4, m2);     
    }
}
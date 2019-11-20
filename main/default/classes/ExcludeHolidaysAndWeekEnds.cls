public class ExcludeHolidaysAndWeekEnds {
    public void demoMethod() {
        Date startDate = date.newinstance(2019, 8, 13);
        Date endDate = startDate.addDays(2);
                
        List<Holiday> holidays = [Select Name, ActivityDate From Holiday];
        if(!holidays.isEmpty()) {
            Boolean res = checkWhetherHoliday(endDate, holidays);
            if(res) {
                System.debug('End Date is a Holiday');
            }
            else {
                System.debug('End Date is not a Holiday');
            }
        }    
    }
    public static boolean checkWhetherHoliday(Date endDate,List<Holiday> holidays) {
        Date weekStart = endDate.toStartofWeek();
        System.debug('weekStart >>>>>> '+weekStart);
        Boolean flag;
        for(Holiday hDay : holidays) {
            System.debug('Date Comparision >>>>> '+endDate.daysBetween(hDay.ActivityDate));
            if(endDate.daysBetween(hDay.ActivityDate) == 0) {
                System.debug('In Holiday Check >>>>> ');
                flag = true;
            }
            else {
				flag = false;
            }
        }
        return flag;
    }
}
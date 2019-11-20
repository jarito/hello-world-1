public class InvocableApexDemo {
     
    public class AccountParameter{
        @InvocableVariable(required=true)
        public Date startDate;
        @InvocableVariable(required=true)
        public Integer noOfBusinessDays;
        @InvocableVariable(required=true)
        public Account objAccount;
    }
    
	@InvocableMethod(label='handleAccountEndDate' description='Calculates End date based on Start date and No of Business days')
    public static void handleAccountEndDate(List<AccountParameter> accountParametersList) { 

        List<Holiday> holidays = [Select Name, ActivityDate From Holiday];
        Map<ID, Date> mapAccIDToEndDate = new Map<ID, Date>();
        for(AccountParameter objWrp : accountParametersList) {
            System.debug('Account >>> '+objWrp.objAccount.Name);
            Date resEndDate = checkWhetherHoliday(objWrp.startDate, objWrp.noOfBusinessDays , holidays);
            mapAccIDToEndDate.put(objWrp.objAccount.Id, resEndDate);
            System.debug('resEndDate >>>  '+resEndDate);
        }
        System.debug('mapAccIDToEndDate >>>  '+mapAccIDToEndDate);

        List<Account> lstAccounts = [SELECT   Id
                                            , Start_Date__c
                                            , No_of_Business_Days__c
                                     FROM Account
                                     WHERE Id IN : mapAccIDToEndDate.keySet()];
        System.debug('lstAccounts >>> '+lstAccounts);

        for(Account objAcc : lstAccounts) {
            Date setEndDate = mapAccIDToEndDate.get(objAcc.Id);
            System.debug('setEndDate Map value>>>> '+setEndDate);
            objAcc.End_Date__c = setEndDate;
        }
        System.debug('UPDATED lstAccounts >>> '+lstAccounts);

        try {
            update lstAccounts;
        }
        catch (DMLException e){
            system.debug('DML Error >>>> '+e);
        }
    }

    /** 
     * This method checks whether the calculated End date is a Week Day, Week End or a Holiday
     **/
    public static Date checkWhetherHoliday(Date startDate,Integer noOfBusinessDays, List<Holiday>  holidays) {
        Date dateForCalculation = startDate.addDays(noOfBusinessDays);
        Date weekStart;
        System.debug('startDate >>>>>> '+startDate);
        System.debug('dateForCalculation >>>>>> '+dateForCalculation);
        Boolean flagHoliday = false;
        Boolean flagWeekEnd = false;
        Integer counter = 0;
        Integer endDateCounter = 1;
        Date endDate = startDate;
        List<Date> holidayDateList = new List<Date>();

        for(Holiday hDay : holidays) {
            holidayDateList.add(hDay.ActivityDate);
        }
        System.debug('holidayDateList >>> '+holidayDateList);

        while(counter < noOfBusinessDays) {
            endDate = endDate.addDays(endDateCounter);
            System.debug('In process endDate >>> '+endDate);

            /** 
            * To check whether the End Date is a Holiday 
            **/
            if(holidayDateList.contains(endDate)) {
                System.debug('In Holiday section >>>>> Holiday >>>>>');
                flagHoliday = true;
            }
            else {
                flagHoliday = false;
                System.debug('No Holiday');
            }

            /** 
            * To check whether the End Date is a Week End 
            **/
            weekStart = endDate.toStartofWeek();
            System.debug('weekStart >>>>>> '+weekStart);
            System.debug('weekStart.daysBetween(endDate) >>>>>> '+weekStart.daysBetween(endDate));
            if(weekStart.daysBetween(endDate) ==0 || weekStart.daysBetween(endDate) == 6){ 
                flagWeekEnd = true;
            }
            else {
                flagWeekEnd = false;
                System.debug('No Week End');
            }
            
            if(flagHoliday || flagWeekEnd) {
                system.debug('Holiday or Weekend');
            }
            else {
                counter++;
                system.debug('NO Holiday AND NO Weekend');
            }
            
        }
        return endDate;
    }
    
}
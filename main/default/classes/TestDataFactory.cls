@isTest
public with sharing class TestDataFactory {
	public static Guest__c createGuestForSite(String combinations){
		Guest__c guestObj;
		if(combinations == 'searchAirportCodeOnly'){
			guestObj= new Guest__c( Name = 'Test Guest',
									Last_Name__c = 'lastname test',
									Email__c = 'a@gmail.com',
									Airline_Code__c = 'BA312',
									Flight_Number__c = '',
									Arrival_Time__c = null,
									Departure_Time__c = null
								  );
		}
		if(combinations == 'searchArrivalDateOnly'){
			guestObj= new Guest__c( Name = 'Test Guest',
									Last_Name__c = 'lastname test',
									Email__c = 'a@gmail.com',
									Airline_Code__c = '',
									Flight_Number__c = '',
									Arrival_Time__c = datetime.newInstance(2018, 12, 13, 8, 52, 0),
									Departure_Time__c = null
								  );
		}

		if(combinations == 'searchDepartureDateOnly'){
			guestObj= new Guest__c( Name = 'Test Guest',
									Last_Name__c = 'lastname test',
									Email__c = 'a@gmail.com',
									Airline_Code__c = '',
									Flight_Number__c = '',
									Arrival_Time__c = null,
									Departure_Time__c = datetime.newInstance(2018, 12, 15, 8, 52, 0)
								  );
		}

		if(combinations == 'searchAirportCodeAndFlightNumber'){
			guestObj= new Guest__c( Name = 'Test Guest',
									Last_Name__c = 'lastname test',
									Email__c = 'a@gmail.com',
									Airline_Code__c = 'BA213',
									Flight_Number__c = '2323',
									Arrival_Time__c = null,
									Departure_Time__c = null
								  );
		}

		if(combinations == 'searchWrongAirportCode'){
			guestObj= new Guest__c( Name = 'Test Guest',
									Last_Name__c = 'lastname test',
									Email__c = 'a@gmail.com',
									Airline_Code__c = 'KMo08',
									Flight_Number__c = '2323',
									Arrival_Time__c = null,
									Departure_Time__c = null
								  );
		}

		if(combinations == 'searchWrongArrivalTime'){
			guestObj= new Guest__c( Name = 'Test Guest',
									Last_Name__c = 'lastname test',
									Email__c = 'a@gmail.com',
									Airline_Code__c = 'BA213',
									Flight_Number__c = '2323',
									Arrival_Time__c =  datetime.newInstance(2018, 12, 10, 8, 52, 0),
									Departure_Time__c = datetime.newInstance(2018, 12, 15, 8, 52, 0)
								  );
		}
		return guestObj;
	}

	public static List<Guest__c> createGuest(String combinations){
		List<Guest__c> guestList = new List<Guest__c>();
		if(combinations == 'validParamsBuffer0'){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = 'BA312',
												Flight_Number__c = '2323',
												Arrival_Airport_Code__c = 'BOS' ,
												Departure_Airport_Code_c__c = 'LHR',
												Arrival_Terminal__c = 'Terminal 1',
												Departure_Terminal__c = 'Terminal 2',
												Arrival_Time__c = datetime.newInstance(2018, 12, 13, 8, 52, 0),
												Departure_Time__c = datetime.newInstance(2018, 12, 15, 8, 52, 0),
												Buffer__c = 0,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}	
		}
		if( combinations == 'validParamsWithBuffer' ){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = 'BA312',
												Flight_Number__c = '2323',
												Arrival_Airport_Code__c = 'BOS' ,
												Departure_Airport_Code_c__c = 'LHR',
												Arrival_Terminal__c = 'Terminal 1',
												Departure_Terminal__c = 'Terminal 2',
												Arrival_Time__c = datetime.newInstance(2018, 12, 13, 8, 52, 0),
												Departure_Time__c = datetime.newInstance(2018, 12, 15, 8, 52, 0),
												Buffer__c = 1,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}				
		}
		else if(combinations == 'wrongArrivalTerminal'){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = 'BA312',
												Flight_Number__c = '2323',
												Arrival_Airport_Code__c = 'BOS' ,
												Departure_Airport_Code_c__c = 'LHR',
												Arrival_Terminal__c = 'Terminal 4',
												Departure_Terminal__c = 'Terminal 2',
												Arrival_Time__c = datetime.newInstance(2018, 12, 13, 8, 52, 0),
												Departure_Time__c = datetime.newInstance(2018, 12, 15, 8, 52, 0),
												Buffer__c = 0,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}
		}
		else if(combinations == 'wrongArrivalAirportCode'){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = 'BA312',
												Flight_Number__c = '2323',
												Arrival_Airport_Code__c = 'MAN' ,
												Departure_Airport_Code_c__c = 'LHR',
												Arrival_Terminal__c = 'Terminal 1',
												Departure_Terminal__c = 'Terminal 2',
												Arrival_Time__c = datetime.newInstance(2018, 12, 13, 8, 52, 0),
												Departure_Time__c = datetime.newInstance(2018, 12, 15, 8, 52, 0),
												Buffer__c = 1,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}
		}
		else if(combinations == 'wrongDepartureTerminal&DepartureAirportCode'){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = 'BA312',
												Flight_Number__c = '2323',
												Arrival_Airport_Code__c = 'BOS' ,
												Departure_Airport_Code_c__c = 'MAN',
												Arrival_Terminal__c = 'Terminal 1',
												Departure_Terminal__c = 'Terminal 3',
												Arrival_Time__c = datetime.newInstance(2018, 12, 13, 8, 52, 0),
												Departure_Time__c = datetime.newInstance(2018, 12, 15, 8, 52, 0),
												Buffer__c = 0,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}
		}
		else if(combinations == 'departureTreminalMissing'){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = 'BA312',
												Flight_Number__c = '2323',
												Arrival_Airport_Code__c = 'BOS' ,
												Departure_Airport_Code_c__c = 'LHR',
												Arrival_Terminal__c = 'Terminal 1',
												Departure_Terminal__c = ' ',
												Arrival_Time__c = datetime.newInstance(2018, 12, 13, 8, 52, 0),
												Departure_Time__c = datetime.newInstance(2018, 12, 15, 8, 52, 0),
												Buffer__c = 1,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}
		}
		else if(combinations == 'allRelatedFieldsMissing'){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = '',
												Flight_Number__c = '',
												Arrival_Airport_Code__c = '' ,
												Departure_Airport_Code_c__c = '',
												Arrival_Terminal__c = '',
												Departure_Terminal__c = ' ',
												Arrival_Time__c = null ,
												Departure_Time__c = null ,
												Buffer__c = 1,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}
		}	

		else if(combinations == 'searchAirportCodeOnly'){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = 'BA312',
												Flight_Number__c = '',
												Arrival_Airport_Code__c = '' ,
												Departure_Airport_Code_c__c = '',
												Arrival_Terminal__c = '',
												Departure_Terminal__c = ' ',
												Arrival_Time__c = null ,
												Departure_Time__c = null ,
												Buffer__c = 1,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}
		}	

		else if(combinations == 'searchArrivalDateOnly'){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = '',
												Flight_Number__c = '',
												Arrival_Airport_Code__c = '' ,
												Departure_Airport_Code_c__c = '',
												Arrival_Terminal__c = '',
												Departure_Terminal__c = ' ',
												Arrival_Time__c = datetime.newInstance(2018, 12, 13, 8, 52, 0) ,
												Departure_Time__c = null ,
												Buffer__c = 1,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}
		}
		else if(combinations == 'searchDepartureDateOnly'){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = '',
												Flight_Number__c = '',
												Arrival_Airport_Code__c = '' ,
												Departure_Airport_Code_c__c = '',
												Arrival_Terminal__c = '',
												Departure_Terminal__c = ' ',
												Arrival_Time__c = null ,
												Departure_Time__c = datetime.newInstance(2018, 12, 15, 8, 52, 0) ,
												Buffer__c = 1,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}
		}
		else if(combinations == 'searchAirportCodeAndFlightNumber'){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = 'BA213',
												Flight_Number__c = '2323',
												Arrival_Airport_Code__c = '' ,
												Departure_Airport_Code_c__c = '',
												Arrival_Terminal__c = '',
												Departure_Terminal__c = ' ',
												Arrival_Time__c = null ,
												Departure_Time__c = null,
												Buffer__c = 1,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}
		}
		
		else if(combinations == 'searchWrongAirportCode'){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = 'K9087',
												Flight_Number__c = '2323',
												Arrival_Airport_Code__c = '' ,
												Departure_Airport_Code_c__c = '',
												Arrival_Terminal__c = '',
												Departure_Terminal__c = ' ',
												Arrival_Time__c = datetime.newInstance(2018, 12, 13, 8, 52, 0) ,
												Departure_Time__c = datetime.newInstance(2018, 12, 15, 8, 52, 0),
												Buffer__c = 1,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}
		}		

		else if(combinations == 'searchWrongArrivalTime'){
			for(Integer i = 0 ;i<1;i++){
				Guest__c guestObj= new Guest__c(Name = 'Test Guest',
												Last_Name__c = 'lastname test',
												Email__c = 'a@gmail.com',
												Airline_Code__c = 'BA213',
												Flight_Number__c = '2323',
												Arrival_Airport_Code__c = '' ,
												Departure_Airport_Code_c__c = '',
												Arrival_Terminal__c = '',
												Departure_Terminal__c = ' ',
												Arrival_Time__c = datetime.newInstance(2018, 12, 10, 8, 52, 0) ,
												Departure_Time__c = datetime.newInstance(2018, 12, 15, 8, 52, 0),
												Buffer__c = 1,
												Error_Message__c='',
												Validation__c=''
												);
			guestList.add(guestObj);	
			}
		}
	return guestList;
	}

	public static List<Case> createCases(Integer count,String job){
		Case caseObj;
		List<Case> listOfCases = new List<Case>();
		if(job =='Maintainance'){
			for(Integer i = 0 ; i < count ; i++ ){
				caseObj = new Case(Status = 'New',
										Origin = 'Phone',
										Job_Type__c = 'Maintainance',
										Job_Description__c = 'Technical issue'+string.valueof(i) );
				listOfCases.add(caseObj);           
			}
		}
		else{
			for(Integer i = 0 ; i < count ; i++ ){
				caseObj = new Case(Status = 'New',
										Origin = 'Phone',
										Job_Type__c = 'Repair',
										Job_Description__c = 'Technical issue'+string.valueof(i) );
				listOfCases.add(caseObj);           
			}
		}
		
		return listOfCases;
	}

    public static List<Event__c> createEvents(Integer count){
        Event__c eventObj;
        List<Event__c> eventList = new List<Event__c>();
        for(Integer i = 0 ; i < count ; i++ ){
               eventObj = new Event__c(Name = 'Test Event'+string.valueof(i));
               eventList.add(eventObj);            
        }
        return eventList;
    }

    public static List<Group_Code__c> createGroupCode(Integer count){
		Group_Code__c groupObj;
        List<Group_Code__c> groupCodeList = new List<Group_Code__c>();
        for(Integer i = 0 ; i < count ; i++ ){
               groupObj = new Group_Code__c();
               groupCodeList.add(groupObj);            
        }        
        return groupCodeList;
    }
    
    public static List<Package__c> createPackages(Integer count ,List<Id> eventIds, List<Id> groupCodeIds, String str){
        Package__c packageObj;
        List<Package__c> packageList = new List<Package__c>();
        for(Integer i = 0 ; i < count ; i++ ){
            if(str == 'Invalid' ){
               packageObj = new Package__c(Event__c = eventIds[0],
                                       	   Group_Code__c= groupCodeIds[0],
                                       	   Name = 'Test Package'+string.valueof(i));
               packageList.add(packageObj);
            }
            else if(str == 'valid'){
               packageObj = new Package__c(Event__c =  eventIds[i],
                                       	   Group_Code__c = groupCodeIds[i+1],
                                           Name = 'Test Package'); 
               packageList.add(packageObj);
            }
            else {
               packageObj = new Package__c(Event__c =  eventIds[i],
                                       	   Group_Code__c = groupCodeIds[i+2],
                                           Name = 'Test Package'); 
               packageList.add(packageObj);
            }            
        }
        return packageList;
    }
    
	public static List<Attachment> createAttachment(List<ID> accountIds,Integer count){
        Attachment attachObj;
        List<Attachment> attachList = new List<Attachment>();
        for(Integer i = 0; i < count ; i++){
            attachObj = new Attachment(Name = 'Test Attachment'+string.valueof(i));
        	Blob bodyBlob=Blob.valueOf('Test Attachment Body'+string.valueof(i));
        	attachObj.body=bodyBlob;
        	attachObj.parentId=accountIds[0];
        	attachList.add(attachObj);
        }
		return attachList;
	}

	public static List<Account> createAccount(Integer count){
        Account accountObj;
        List<Account> accountList = new List<Account>();
        for(Integer i = 0; i < count ; i++){
            accountObj = new Account(Name = 'Test Account',
									 Industry = 'Farming',
									 Type = 'Customer - Direct',
									 Phone = '556677',
									 Rating = 'Warm'									
									);
            accountList.add(accountObj);
        }
		return accountList;
	}
    
	public static Lead createLead(){
		Lead leadObj = new Lead( Lastname = 'Test Lead 600' , Company = 'Espl5' , Status = 'Closed - Converted');
		return leadObj;
	}

	public static AcceptLead.leadRecord  createLeadList(){
		AcceptLead.leadRecord innerClass = new AcceptLead.leadRecord();
		innerClass.LastName = 'TestLead600';  
		innerClass.Company = 'Espl5';
		innerClass.Status = 'Closed-Converted';

		return innerClass;		
	}

	public static AcceptLead.leadRecord  createLeadListNoLastName(){
		AcceptLead.leadRecord innerClass = new AcceptLead.leadRecord();
		innerClass.LastName = '';  
		innerClass.Company = 'ESPL';
		innerClass.Status = ' Closed - Converted ';

		return innerClass;		
	}

	public static AcceptLead.leadRecord  createLeadNoParams(){
		AcceptLead.leadRecord innerClass = new AcceptLead.leadRecord();
		innerClass.LastName = '';  
		innerClass.Company = '';
		innerClass.Status = '';

		return innerClass;		
	}
    
    public static List<Opportunity> createSingleOpportunityBatch(List<ID> accountIDs){
        List<Opportunity> opportunityList = new List<Opportunity>();
		Opportunity opportunityObj = new Opportunity(Name = 'Test Opportunity First',
        								 			 StageName = 'Closed Won', 
        								 			 Amount = 5000,
                                                     CloseDate =system.today(),
                                                     accountId = accountIDs[0]);
  		opportunityList.add(opportunityObj);
        return opportunityList;
    }

    public static List<Opportunity> createTwoOpportunitiesBatch(List<ID> accountIDs){
        List<Opportunity> opportunityList = new List<Opportunity>();
		Opportunity opportunityObject;
		for(Integer eachInteger = 0 ; eachInteger < 2 ; eachInteger ++ ){
            opportunityObject =  new Opportunity( Name = 'Test Opportunity'+string.valueof(eachInteger) ,
                                                                  StageName = 'Closed Won',
                                                                  Amount = 5000,
                                                                  CloseDate =system.today(),
                                                                  accountId = accountIDs[0]
                                                    );
            opportunityList.add(opportunityObject);
        }
        return opportunityList;
    }       
    
    public static List<Opportunity> createFourOpportunitiesBatch(List<ID> accountIDs){
        List<Opportunity> opportunityList = new List<Opportunity>();
		Opportunity opportunityObject;
		for(Integer eachInteger = 0 ; eachInteger < 4 ; eachInteger ++ ){
            opportunityObject =  new Opportunity( Name = 'Test Opportunity'+string.valueof(eachInteger) ,
                                                                  StageName = 'Closed Won',
                                                                  Amount = 5000,
                                                                  CloseDate =system.today(),
                                                                  accountId = accountIDs[0]
                                                    );
            opportunityList.add(opportunityObject);
        }
        return opportunityList;
    }   
    

    public static List<Opportunity> twoAccountsFourOpportunitiesBatch(List<ID> accountIDs){
		Opportunity opportunityObject;
        List<Opportunity> listToBeInserted = new List<Opportunity>(); 
		for(Integer eachInteger = 0 ; eachInteger < 4 ; eachInteger ++ ){
			if(eachInteger < = 1){
				opportunityObject =  new Opportunity( Name = 'Test Opportunity'+string.valueof(eachInteger) ,
																StageName = 'Closed Won',
																Amount = 5000,
																CloseDate =system.today(),
																accountId = accountIDs[0]
													);
				listToBeInserted.add(opportunityObject);
			}
			if(eachInteger > 1){
				opportunityObject =  new Opportunity( Name = 'Test Opportunity'+string.valueof(eachInteger) ,
																StageName = 'Closed Won',
																Amount = 2000,
																CloseDate =system.today(),
																accountId = accountIDs[1]
													);
				listToBeInserted.add(opportunityObject);				
			}
		}
        return listToBeInserted;
    } 

     public static List<Opportunity> twoAccounts200OpportunitiesBatch(List<ID> accountIDs){
		Opportunity opportunityObject;
        List<Opportunity> listToBeInserted = new List<Opportunity>(); 
		for(Integer eachInteger = 0 ; eachInteger < 200 ; eachInteger ++ ){
			if(eachInteger <  100){
				opportunityObject =  new Opportunity( Name = 'Test Opportunity'+string.valueof(eachInteger) ,
																StageName = 'Closed Won',
																Amount = 5000,
																CloseDate =system.today(),
																accountId = accountIDs[0]
													);
				listToBeInserted.add(opportunityObject);
			}
			if(eachInteger >= 100){
				opportunityObject =  new Opportunity( Name = 'Test Opportunity'+string.valueof(eachInteger) ,
																StageName = 'Closed Won',
																Amount = 2000,
																CloseDate =system.today(),
																accountId = accountIDs[1]
													);
				listToBeInserted.add(opportunityObject);				
			}
		}
        return listToBeInserted;
    }   
    
    public static List<Account> createSingleAccount(){
        List<Account> accountList = new List<Account>();
		Account accountObj = new Account(Name = 'TestAccount2',
        								 Website = 'www.sForce.com', 
        								 Phone = '988900989');
  		accountList.add(accountObj);
        return accountList;
    }
  
    public static List<Account> createSingleAccountBatch(List<ID> contactIDs){
        List<Account> accountList = new List<Account>();
		Account accountObj = new Account(Name = 'Test Account First',
        								 Website = 'www.eternussolutions.com', 
        								 PrimaryContact__c = contactIDs[0]);
  		accountList.add(accountObj);
        return accountList;
    }
	public static List<Account> createTwoAccounts(){
		List<Account> accountList = new List<Account>();
		Account currentAccount;
		for(Integer eachAccount = 0 ; eachAccount < 2 ; eachAccount++){
			currentAccount = new Account( Name = 'TestAccount'+string.valueof(eachAccount));
			accountList.add(currentAccount);
		}		
		return accountList;
	}

    public static List<Account> insertAccountList10(){
        List<Account> accountList = new List<Account>();
        Account accountObj;
        for(Integer eachAccount = 0 ; eachAccount < 10 ; eachAccount++){
            if(eachAccount < 4){
            	accountObj = new Account( Name = 'google'+string.valueof(eachAccount));
                accountList.add(accountObj);
            }
            if(eachAccount >= 4){
            	accountObj = new Account( Name = 'test'+string.valueof(eachAccount)); 
                accountList.add(accountObj);
            }            
        }
        return accountList;
    }
    
	public static List<Account> alphabeticalSearch(){
		List<Account> charAccountList = new List<Account>();
		Account eachAccountChar;
		for(Integer eachChar = 0 ; eachChar < 10 ; eachChar++){
			if(eachChar < 3){
				eachAccountChar = new Account( Name = 'Arai'+string.valueof(eachChar));
				charAccountList.add(eachAccountChar);				
			}
			if(eachChar >=3 && eachChar < 7){
				eachAccountChar = new Account( Name = 'Boston'+string.valueof(eachChar));
				charAccountList.add(eachAccountChar);
			}
			if(eachChar >= 7){
				eachAccountChar = new Account( Name = 'Korea'+string.valueof(eachChar));
				charAccountList.add(eachAccountChar);				
			}
		}		
		return charAccountList;
	}
    public static List<Account> oneContactTwoAccountsBatch(List<ID> contactIDs){
		List<Account> accountList = new List<Account>();
        Account accountObject;
		for(Integer i = 0 ; i < 2 ; i++ )
		{
            if(i == 0){
                accountObject = new Account(Name = 'Test Account Second '+''+string.valueof(i),
                                            Website = 'www.eternussolutions.com',
                                            PrimaryContact__c = contactIDs[0]);
                accountList.add(accountObject);                
            }
            else{
                accountObject = new Account(Name = 'Test Account Second '+''+string.valueof(i),
                                            Website = 'www.eternussolutions.com',
                                            PrimaryContact__c = contactIDs[0]);
                accountList.add(accountObject);                 
            }
		}        
        return accountList;
    }    
    
    public static List<Account> insertTwoAccountsBatch(List<ID> contactIDs){
		List<Account> accountList = new List<Account>();
        Account accountObject;
		for(Integer i = 0 ; i < 2 ; i++ )
		{
            if(i == 0){
                accountObject = new Account(Name = 'Test Account Second '+''+string.valueof(i),
                                            Website = 'www.eternussolutions.com',
                                            PrimaryContact__c = contactIDs[0]);
                accountList.add(accountObject);                
            }
            else{
                accountObject = new Account(Name = 'Test Account Second '+''+string.valueof(i),
                                            Website = 'www.eternussolutions.com',
                                            PrimaryContact__c = contactIDs[1]);
                accountList.add(accountObject);                 
            }
		}        
        return accountList;
    }   
    public static List<Account> insertTwoAccounts(){
		List<Account> accountList = new List<Account>();
        Account accountObject;
		for(Integer i = 0 ; i < 2 ; i++ )
		{
            if(i == 0){
                accountObject = new Account(Name = 'TestCloneAccount1'+''+string.valueof(i),
                                            Website = 'www.sForce.com',
                                            Phone = '988900989');
                accountList.add(accountObject);                
            }
            else{
                accountObject = new Account(Name = 'TestCloneAccount2'+''+string.valueof(i),
                                            Website = 'www.google.com',
                                            Phone = '988900980');
                accountList.add(accountObject);                 
            }
		}        
        return accountList;
    }
    public static List<Account> insertBulkAccounts(){
		List<Account> accountList = new  List<Account>();
		Account accountObject;
		for(Integer i = 0 ; i < 200 ; i++ )
		{
			accountObject = new Account(Name = 'TestCloneAccount'+''+string.valueof(i));
			accountList.add(accountObject);
		}		
        return accountList;
    }
   
    public static List<Contact> insertSingleContact(List<ID> accountIDs){
        List<Contact> contactList = new List<Contact>();
		Contact contactObj = new Contact(LastName = 'Test1',
        								 Email = 'Test1@sForce.com',
        								 Phone = '9898989870',
        								 AccountId = accountIDs[0]);
  		contactList.add(contactObj);  
        return contactList;
    }
 
    public static List<Contact> insertOneContactNoEmail(){
        List<Contact> contactList = new List<Contact>();
        Contact contactData = new Contact();
        contactData.LastName = 'TestContact';
        contactData.Email = '';
        contactData.Phone = '112211';
        contactList.add(contactData);
        return contactList;
    }
    
    public static List<Contact> insertOneContact(){
        List<Contact> contactList = new List<Contact>();
        Contact contactData = new Contact();
        contactData.LastName = 'shruti';
        contactData.Email = 'shruti@eternus.com';
        contactList.add(contactData);
        return contactList;
    }
    
    public static List<Contact> insertOneContactInValidEmail(){
        List<Contact> contactList = new List<Contact>();
        Contact contactData = new Contact();
        contactData.LastName = 'TestContact';
        contactData.Email = 'test';
        contactData.Phone = '112211';
        contactList.add(contactData);
        return contactList;
    }
 
    public static List<Contact> insertTwoContactsBatch(){
        List<Contact> listOfContacts = new List<Contact>(); 
        for(Integer i = 0 ; i < 2 ; i++ ){
            if(i==0){
                Contact contactObjectFirst = new Contact();
                contactObjectFirst.LastName = 'shrutiContact1';
                contactObjectFirst.Email = 'shruti@gmail.com';
                listOfContacts.add(contactObjectFirst);
            }
            if(i>0){
                Contact contactObjectSecond = new Contact();
                contactObjectSecond.LastName = 'shrutiContact2';
                contactObjectSecond.Email = 'sam@eternus.com';
                listOfContacts.add(contactObjectSecond);                    
            }
        } 
        return listOfContacts;
    }    
    
    public static List<Contact> insertThreeContacts(){
        List<Contact> listOfContacts = new List<Contact>(); 
        for(Integer i = 0 ; i < 3 ; i++ ){
            if(i==0){
                Contact contactObject = new Contact();
                contactObject.LastName = 'TestContact'+''+string.valueof(i);
                contactObject.Email = 'Rose'+string.valueof(i)+'@gmail.com';
                contactObject.Phone = '9090909090'+string.valueof(i);
                listOfContacts.add(contactObject);
            }
            if(i>0){
                Contact contactObjectNew = new Contact();
                contactObjectNew.LastName = 'TestContact'+''+string.valueof(i);
                contactObjectNew.Email = 'Rose10@gmail.com';
                contactObjectNew.Phone = '9090909090';
                listOfContacts.add(contactObjectNew);                    
            }
        } 
        return listOfContacts;
    }
    
    public static List<Contact> insert200Contacts(List<ID> accountIDs){
		List<Contact> bulkContacts = new  List<Contact>();
		Contact objectContact;
		for(Integer i = 0 ; i < 200 ; i++ )
		{
            if(i<100){
                objectContact = new Contact(LastName = 'TestContact'+''+string.valueof(i), 
                                            Email = 'Rose'+string.valueof(i)+'@gmail.com',
                                            Phone = '909090'+string.valueof(i),
                							AccountId = accountIDs[0]);
                bulkContacts.add(objectContact);            
            }
            if(i>=100){
                objectContact = new Contact(LastName = 'TestContact'+''+string.valueof(i), 
                                            Email = 'Rose@gmail.com',
                                            Phone = '909090'+string.valueof(i),
                                            AccountId = accountIDs[1]);
                bulkContacts.add(objectContact);            
            } 
		}
        return bulkContacts;
    }

    public static List<Contact> insertBulkContacts(){
		List<Contact> bulkContacts = new  List<Contact>();
		Contact objectContact;
		for(Integer i = 0 ; i < 200 ; i++ )
		{
            if(i<100){
                objectContact = new Contact(LastName = 'TestContact'+''+string.valueof(i), 
                                            Email = 'Rose'+string.valueof(i)+'@gmail.com',
                                            Phone = '909090'+string.valueof(i));
                bulkContacts.add(objectContact);            
            }
            if(i>=100 && i<150){
                objectContact = new Contact(LastName = 'TestContact'+''+string.valueof(i), 
                                            Email = 'Rose@gmail.com',
                                            Phone = '909090');
                bulkContacts.add(objectContact);            
            } 
            if(i>=150){
                objectContact = new Contact(LastName = 'TestContact'+''+string.valueof(i), 
                                            Email = 'Rosary@gmail.com',
                                            Phone = '909090');
                bulkContacts.add(objectContact);            
            }            
		}
        return bulkContacts;
    }    
    
	public static List<Account> bulkCheckAlphabeticalSearch(){
		List<Account> charAccountList = new List<Account>();
		Account eachAccountChar;
		for(Integer eachChar = 0 ; eachChar <= 200 ; eachChar++){
			if(eachChar < 20){
				eachAccountChar = new Account( Name = 'Arai'+string.valueof(eachChar));
				charAccountList.add(eachAccountChar);				
			}
			if(eachChar >=20 && eachChar < 70){
				eachAccountChar = new Account( Name = 'Boston'+string.valueof(eachChar));
				charAccountList.add(eachAccountChar);
			}
			if(eachChar >= 71){
				eachAccountChar = new Account( Name = 'Korea'+string.valueof(eachChar));
				charAccountList.add(eachAccountChar);				
			}
		}		
		return charAccountList;		
	}

	public static List<Account> alphabeticalSearchForALLBulk(){
		List<Account> charAccountList = new List<Account>();
		Account eachAccountChar;
		for(Integer eachChar = 1 ; eachChar <= 200 ; eachChar++){
			if(eachChar < 20){
				eachAccountChar = new Account( Name = 'Arai'+eachChar , Phone = '99993'+eachChar , Website = 'Arai@gmail.com'+eachChar);
				charAccountList.add(eachAccountChar);				
			}
			if(eachChar >=20 && eachChar <= 70){
				eachAccountChar = new Account( Name = 'Boston'+eachChar, Phone = '99991'+eachChar , Website = 'Arai@gmail.com'+eachChar);
				charAccountList.add(eachAccountChar);
			}
			if(eachChar >= 71){
				eachAccountChar = new Account( Name = 'Korea'+eachChar, Phone = '99992'+eachChar , Website = 'Arai@gmail.com'+eachChar);
				charAccountList.add(eachAccountChar);				
			}
		}		
		return charAccountList;
	}

	public static List<City__c> createCityCustomSetting(){
		List<City__c> listOfCountries = new List<City__c>();
		City__c citySetting;
		citySetting = new City__c(Name = 'Kolkata',Country__c = 'India');
		listOfCountries.add(citySetting);
		citySetting = new City__c(Name = 'Lyon',Country__c = 'France');
		listOfCountries.add(citySetting);
		citySetting = new City__c(Name = 'Miami',Country__c = 'USA');
		listOfCountries.add(citySetting);
		citySetting = new City__c(Name = 'Milan',Country__c = 'Italy');
		listOfCountries.add(citySetting);
		citySetting = new City__c(Name = 'Mumbai',Country__c = 'India');
		listOfCountries.add(citySetting);
		citySetting = new City__c(Name = 'New Delhi',Country__c = 'India');
		listOfCountries.add(citySetting);
		citySetting = new City__c(Name = 'New York',Country__c = 'USA');
		listOfCountries.add(citySetting);
		citySetting = new City__c(Name = 'Paris',Country__c = 'France');
		listOfCountries.add(citySetting);
		citySetting = new City__c(Name = 'Pune',Country__c = 'India');
		listOfCountries.add(citySetting);
		citySetting = new City__c(Name = 'Rome',Country__c = 'Italy');
		listOfCountries.add(citySetting);
		citySetting = new City__c(Name = 'Washington DC',Country__c = 'USA');
		listOfCountries.add(citySetting);

		return listOfCountries;
	}

	public static List<Lead> dataOneleadDuplicateByEmail(){
		Lead leadObj;
		List<Lead> leadList = new List<Lead>();
		for(Integer eachInteger = 0; eachInteger < 2 ;eachInteger ++){
			if(eachInteger == 0){
				leadObj = new Lead( LastName = 'LeadOne',
									FirstName = 'LeadOneFirstName',
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das@gmail.com',
									Phone = '99999'
							  	  );
				leadList.add(leadObj);
			}
			if(eachInteger > 0){
				leadObj = new Lead( LastName = 'LeadTwo',
									FirstName = 'LeadTwoFirstName',
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das@gmail.com',
									Phone = '999991'
							  	  );
				leadList.add(leadObj);
			}			
		}
		return leadList;
	}

	public static List<Lead> OneleadDuplicateByPhone(){
		Lead leadOne;
		List<Lead> leadList = new List<Lead>();
		for(Integer eachInteger = 0; eachInteger < 2 ;eachInteger ++){
			if(eachInteger == 0){
				leadOne = new Lead( LastName = 'LeadOne',
									FirstName = 'LeadOneFirstName',
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das11@gmail.com',
									Phone = '99999'
							  	  );
				leadList.add(leadOne);
			}
			if(eachInteger > 0){
				leadOne = new Lead( LastName = 'LeadTwo',
									FirstName = 'LeadTwoFirstName',
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das@gmail.com',
									Phone = '99999'
							  	  );
				leadList.add(leadOne);
			}			
		}
	    return leadList;
	}

	public static List<Lead> OneleadDuplicateByFirstName(){
		Lead leadOne;
		List<Lead> leadList = new List<Lead>();
		for(Integer eachInteger = 0; eachInteger < 2 ;eachInteger ++){
			if(eachInteger == 0){
				leadOne = new Lead( LastName = 'LeadOne',
									FirstName = 'LeadOneFirstName',
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das11@gmail.com',
									Phone = '99999'
							  	  );
				leadList.add(leadOne);
			}
			if(eachInteger > 0){
				leadOne = new Lead( LastName = 'LeadTwo',
									FirstName = 'LeadOneFirstName',
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das@gmail.com',
									Phone = '99999'
							  	  );
				leadList.add(leadOne);
			}			
		}
		return leadList;
	}

	public static List<Lead> MultipleleadDuplicateByFirstName(){
		Lead leadOne;
		List<Lead> leadList = new List<Lead>();
		for(Integer eachInteger = 0; eachInteger < 200 ;eachInteger ++){
			if(eachInteger == 0){
				leadOne = new Lead( LastName = 'LeadOne',
									FirstName = 'LeadOneFirstName',
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das11@gmail.com',
									Phone = '99999'
							  	  );
				leadList.add(leadOne);
			}
			if(eachInteger > 0 && eachInteger <= 40){
				leadOne = new Lead( LastName = 'LeadTwo',
									FirstName = 'LeadOneFirstName'+string.valueof(eachInteger),
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das@gmail.com',
									Phone = '99999'
							  	  );
				leadList.add(leadOne);
			}	
			if(eachInteger > 40 && eachInteger < 200){
				leadOne = new Lead( LastName = 'LeadTwo',
									FirstName = 'FirstName',
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das@gmail.com',
									Phone = '99999'
							  	  );
				leadList.add(leadOne);
			}		
		}		
		return leadList;
	}

	public static List<Lead> MultipleleadDuplicateByEmail(){

		Lead leadOne;
		List<Lead> leadList = new List<Lead>();
		for(Integer eachInteger = 0; eachInteger < 200 ;eachInteger ++){
			if(eachInteger == 0){
				leadOne = new Lead( LastName = 'LeadOne',
									FirstName = 'LeadOneFirstName',
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das11@gmail.com',
									Phone = '99999'
							  	  );
				leadList.add(leadOne);
			}
			if(eachInteger > 0 && eachInteger <= 40){
				leadOne = new Lead( LastName = 'LeadTwo',
									FirstName = 'LeadOneFirstName'+string.valueof(eachInteger),
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das@gmail.com'+string.valueof(eachInteger),
									Phone = '99999'
							  	  );
				leadList.add(leadOne);
			}	
			if(eachInteger > 40 && eachInteger < 200){
				leadOne = new Lead( LastName = 'LeadTwo',
									FirstName = 'FirstName',
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das@gmail.com',
									Phone = '99999'
							  	  );
				leadList.add(leadOne);
			}		
		}
		return leadList;		
	}	

	public static List<Lead> MultipleleadDuplicateByPhone(){
		Lead leadOne;
		List<Lead> leadList = new List<Lead>();
		for(Integer eachInteger = 0; eachInteger < 200 ;eachInteger ++){
			if(eachInteger == 0){
				leadOne = new Lead( LastName = 'LeadOne',
									FirstName = 'LeadOneFirstName',
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das11@gmail.com',
									Phone = '999991111'
							  	  );
				leadList.add(leadOne);
			}
			if(eachInteger > 0 && eachInteger <= 40){
				leadOne = new Lead( LastName = 'LeadTwo',
									FirstName = 'LeadOneFirstName'+string.valueof(eachInteger),
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das@gmail.com'+string.valueof(eachInteger),
									Phone = '99999'+string.valueof(eachInteger)
							  	  );
				leadList.add(leadOne);
			}	
			if(eachInteger > 40 && eachInteger < 200){
				leadOne = new Lead( LastName = 'LeadTwo',
									FirstName = 'FirstName',
									Company = 'ESPL',
									Status = 'Open - Not Contacted',
									Email = 'das@gmail.com',
									Phone = '99999'
							  	  );
				leadList.add(leadOne);
			}		
		}
		return leadList;
	}
    
    public static ManageEvent__c validInputSingleLead(){
		ManageEvent__c thisEvent = new ManageEvent__c();
		thisEvent.Json__c =' { "LastName" : " BatchApexLead " , "Company" : "ESPL" , "Status" : "Open - Not Contacted " } ';
		thisEvent.Object__c = 'Lead';
        return thisEvent;        
    }
    
    public static ManageEvent__c validInputSingleAccount(){
		ManageEvent__c thisEvent = new ManageEvent__c();
		thisEvent.Json__c =' { "Name" : " BatchApexAccount " , "Phone" : "88888888" } ';
		thisEvent.Object__c = 'Account';
        return thisEvent;        
    }
    public static ManageEvent__c validInputSingleContact(){
		ManageEvent__c thisEvent = new ManageEvent__c();
		thisEvent.Json__c =' { "LastName" : " BatchApexContact" , "Phone" : "88888888" } ';
		thisEvent.Object__c = 'Contact';
        return thisEvent;        
    }
    public static List<ManageEvent__c> validInputBulkEvent(){
		ManageEvent__c thisEvent ;
		List<ManageEvent__c> eventList = new List<ManageEvent__c>();
		for(Integer eachEvent = 0 ; eachEvent < 200 ; eachEvent ++ ){
			thisEvent = new ManageEvent__c( Json__c =' { "LastName" : " BatchApexLead " , "Company" : "ESPL" , "Status" : "Open - Not Contacted " } ',
											Object__c = 'Lead'
										  );
		eventList.add(thisEvent);
		}
    return eventList;        
    }
    
    public static List<ManageEvent__c> inValidInputBulkEvent(){
		ManageEvent__c thisEvent ;
		List<ManageEvent__c> eventList = new List<ManageEvent__c>();
		for(Integer eachEvent = 0 ; eachEvent < 200 ; eachEvent ++ ){
			if(eachEvent < 198){
				thisEvent = new ManageEvent__c( Json__c =' { "LastName" : " BatchApexLead " , "Company" : "ESPL" , "Status" : "Open - Not Contacted " } ',
												Object__c = 'Lead'
											);
				eventList.add(thisEvent);
			}
			else{
				thisEvent = new ManageEvent__c( Json__c =' { "LastName" : "  " , "Company" : "ESPL" , "Status" : "Open - Not Contacted " } ',
												Object__c = 'Lead'
											);
				eventList.add(thisEvent);				
			}
		}
    return eventList;        
    }
}
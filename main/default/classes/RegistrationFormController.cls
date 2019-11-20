public  class RegistrationFormController {
	public Guest__c guest {get;set;}
	public List<SelectOption> eventList {get;set;} 
	public ID selectedEvent {get;set;}  
	public String selectedGroupCode {get;set;}  
	public List<SelectOption> codePackageList {get;set;}
	public String confirmationMesssage {get;set;}
	public RegistrationFormController() {
		guest = new Guest__c();
		guest.Start_Date__c = System.today();
		guest.End_Date__c = System.today();
		eventList = new List<SelectOption>();
		eventList.add(new SelectOption( '' , '-None-' ));
		codePackageList = new List<SelectOption>();
		codePackageList.add(new SelectOption( '' , '-None-' ));

	} 

    public void getEventList(){
		system.debug('In getEventList');
        eventList = new List<SelectOption>();
        List<Event__c> listOfEvents = new List<Event__c>();
        Set<Event__c> uniqueEvents = new Set<Event__c>();
		system.debug('End Date--->' + guest.End_Date__c);
		Date tempDate = guest.End_Date__c;
		system.debug('End Date in VARIABLE--->' + tempDate);
        listOfEvents = Database.query('Select Name From Event__c Where End_Date__c > today And End_Date__c < :tempDate');
        for(Event__c eachEvent : listOfEvents){
			Event__c eventObj = new Event__c();
			eventObj.Id = eachEvent.Id;
			eventObj.Name = eachEvent.Name;
            uniqueEvents.add(eventObj);
        }
        system.debug(uniqueEvents);
		
        /**
         * Generating Picklist of events in specified Date range
         */
        for(Event__c eventOption : uniqueEvents){
            eventList.add(new SelectOption(eventOption.Id , eventOption.Name)); 
            system.debug(eventOption);
        }
		
    }

	public void getCodePackageList(){
		codePackageList = new List<SelectOption>(); 
		List<Package__c> packageList =[ Select
											Event__c,
											Event__r.Name,
											Package_GroupCode__c
										From 
									  		Package__c];
		//guest.Event__c = selectedEvent;
		//system.debug('Selected Event  CHECK---> '+guest.Event__c);
		//system.debug('Selected Event ---> '+selectedEvent);									  
		
		for(Package__c eachPackage : packageList){
			system.debug('Existing Event ---> '+eachPackage.Event__c);	
			if(eachPackage.Event__c == selectedEvent){
				system.debug('---Group Code ----->'+eachPackage.Package_GroupCode__c);
				codePackageList.add(new SelectOption(eachPackage.Package_GroupCode__c , eachPackage.Package_GroupCode__c));
			}
		}
	}

	public pagereference doRegister(){ 
		//guest.Group_Code__c = selectedGroupCode;

		try{
			Insert guest;
		}
		catch(Exception e){
			String errorMessage = e.getMessage();
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Enter Valid Last Name'));		   
			return null;	
		}
		return new PageReference('/'+guest.id+'/e');

	}
}
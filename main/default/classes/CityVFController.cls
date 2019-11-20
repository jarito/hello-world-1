/**
 * Custom Controller which contains the logic of generating dependant picklists
 */
public class CityVFController{
    /**
     * cityInfo is list of values of City custom setting
     * countryNames is the list of countries
     * cityNames is the list of dependent cities based on the country selected
     * selectedCountry is the country selected from the picklist
     */    
    public List<City__c> cityInfo {get;set;}
    public List<SelectOption> countryNames {get;set;}
    public List<SelectOption> cityNames {get;set;}
    public String selectedCountry {get;set;}

    /**
     * Constructor
     */
    public CityVFController(){
        Map<String,City__c> cityMap = City__c.getAll();
        cityInfo = cityMap.values();
        selectedCountry = 'India';
        getCountryNames();
        getCities();
    }

    /**
     * list of countries in a picklist
     */
    public void getCountryNames(){
        countryNames = new List<SelectOption>();
        List<City__c> listCountries = new List<City__c>();
        Set<String> uniqueCountries = new Set<String>();
        listCountries = [Select
                            Country__c
                         From
                            City__c];
        for(City__c eachCity : listCountries){
            uniqueCountries.add(eachCity.Country__c);
        }
        system.debug(uniqueCountries);
        /**
         * Generating Picklist of countries
         */
        for(String countryOption : uniqueCountries){
            countryNames.add(new SelectOption(countryOption , countryOption)); 
            system.debug(countryOption);
        }
    }

    /**
     * Picklist of cities present in the selected country
     */
    public void getCities(){
        cityNames = new List<SelectOption>();
        system.debug('========'+City__c.getAll().values());
        for(City__c cityVar : City__c.getAll().values()){
            //system.debug('--selectedCountry--'+selectedCountry);
            //system.debug('--hello--');     
            if(cityVar.Country__c == selectedCountry){
                 cityNames.add(new SelectOption(cityVar.id , cityVar.Name)); 
            } 
        }
    } 
}
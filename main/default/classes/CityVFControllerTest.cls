@isTest
public with sharing class CityVFControllerTest {
	static testMethod void countryAndCityCheck(){
		List<City__c> listOfCountries = TestDataFactory.createCityCustomSetting();
		insert listOfCountries;

		CityVFController objectCity = new CityVFController();
		objectCity.selectedCountry = 'INDIA';
		objectCity.getCountryNames();
		system.debug('Selected Country'+objectCity.selectedCountry);
		system.debug('Cities are : '+objectCity.cityNames);
        Set<String> outputCitiesSet = new Set<String>();
		for(City__c cityVar : City__c.getAll().values()){   
            if(cityVar.Country__c == objectCity.selectedCountry){
				 outputCitiesSet.add(cityVar.Name); 
            } 
        }

		for(SelectOption selectCountry : objectCity.cityNames){
			system.assert(outputCitiesSet.contains(selectCountry.getLabel()));
		}
	}
}
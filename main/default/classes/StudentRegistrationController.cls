public with sharing class StudentRegistrationController {
	public String selectedLanguage {get;set;}
	public list<SelectOption> languages {get;set;}
	public StudentRegistrationController(ApexPages.StandardController controller) {
		//selectedLanguage='en';

		languages = new list<SelectOption>();
		languages.add(new SelectOption('en','English'));
		languages.add(new SelectOption('fr','French'));	
		languages.add(new SelectOption('es','Spanish'));
		languages.add(new SelectOption('de','German'));	
	}
}
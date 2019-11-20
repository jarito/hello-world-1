public with sharing class DynamicQueryController {

	public String selectedObject {get;set;}
	public List<SelectOption> objectList {get;set;}
    //public List<> countryNames {get;set;}
	//public Set<String> fieldsList {get;set;}
	public String selectedField {get;set;} 
	public List<string> leftselected{get;set;}
    public List<string> rightselected{get;set;}
    //Set<string> leftvalues = new Set<string>();
    public Set<string> rightvalues = new Set<string>();
	Set<string> leftFieldList = new Set<string>();
	public List<SelectOption> options {get;set;}
	public String recordCount{get;set;}
	public  List<SelectOption> recordCountValues {get;set;}
	public String sortOption{get;set;}
	public  List<SelectOption> sortOptionList {get;set;}
	public String dynamicString {get;set;}
	public String inputValue {get;set;}	
	List<List<sObject>> listOfSObjects;
	public List<sObject> searchList {get;set;} 
	public List<String> joinList {get;set;}

	public DynamicQueryController() {
		leftselected = new List<String>();
        rightselected = new List<String>();
		selectedObject = 'account';
		sortOption = 'ASC';
		//recordCount= '100';
		getSortOptionList();
		getObjectList();
		getRecordCountList();
		//getFieldList();
	}  

	public PageReference selectclick(){
        rightselected.clear();
        for(String s : leftselected){
            leftFieldList.remove(s);
            rightvalues.add(s);
        }
        return null;
    }
     
    public PageReference unselectclick(){
        leftselected.clear();
        for(String s : rightselected){
            rightvalues.remove(s);
            leftFieldList.add(s);
        }
        return null;
    }

	Map<string,Schema.SObjectType> mapOfSObjects = Schema.getGlobalDescribe();
    public void getObjectList(){
        objectList = new List<SelectOption>();
		objectList.add(new selectoption('','Account'));
		
			for(String eachSObject : mapOfSObjects.keyset())
			{
				objectList.add(new SelectOption(eachSObject,eachSObject));
			}
			objectList.sort();			
	
	}
	
	//public List<SelectOption> options {get;set;}
	public List<SelectOption> getunSelectedValues(){
			//List<SelectOption> leftFieldList = new List<SelectOption>();
			system.debug('****mapOfSObjects***'+mapOfSObjects);
			system.debug('***mapOfSObjects.get(selectedObject)======'+mapOfSObjects.get(selectedObject));	
			Map<string,Schema.SObjectField> mapField=mapOfSObjects.get(selectedObject).getDescribe().fields.getMap();
			system.debug('*****'+mapField.keySet());
			//fieldsList=mapField.keySet();
			system.debug('*****'+mapField.keySet());
			//fieldList.add(new selectoption('','-None-'));                    
			for(string name : mapField.keySet()){
				Schema.DescribeFieldResult fieldResult=mapField.get(name).getDescribe();
				leftFieldList.add(fieldResult.getName());
			}
			options = new List<SelectOption>();
			List<string> tempList = new List<String>();
			tempList.addAll(leftFieldList);
			tempList.sort();
			for(string eachCharacter : tempList)
				options.add(new SelectOption(eachCharacter,eachCharacter));
				
			return options;		
	}

	public List<SelectOption> getSelectedValues(){
        List<SelectOption> optionList = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(rightvalues);
        tempList.sort();
        for(String eachCharacter : tempList)
            optionList.add(new SelectOption(eachCharacter,eachCharacter));
        return optionList;
    }

	public void getRecordCountList(){
		recordCountValues = new List<SelectOption>();
		recordCountValues.add(new SelectOption(String.valueOf(100),String.valueOf(100)));
		recordCountValues.add(new SelectOption(String.valueOf(200),String.valueOf(200)));
		recordCountValues.add(new SelectOption(String.valueOf(300),String.valueOf(300)));
		system.debug('====recordCount====='+recordCount);
	}	

	public void getSortOptionList(){
		sortOptionList = new List<SelectOption>();
		sortOptionList.add(new SelectOption('ASC','Ascending'));
		sortOptionList.add(new SelectOption('DESC','Descending'));		
	} 

	public void getRecords(){
		
		if(inputValue.isNumeric()){
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Enter text value '));	
		}
		
		try{
			joinList = new List<String>(rightvalues);
			String innerString = String.join( joinList , ',');
            system.debug('----innerString----'+innerString);
            system.debug('----selectedObject----'+selectedObject);
            system.debug('----selectedField----'+selectedField+'----sortOption==='+sortOption+'----recordCount---'+recordCount);
			dynamicString = ' Find \''+inputValue+'*\' IN ALL FIELDS RETURNING ' +selectedObject+ ' ( '+innerString +' ORDER BY ' +selectedField+' '+ sortOption + ' LIMIT '+recordCount  +' ) ' ;		
			//dynamicString = ' Find \''+inputValue+'*\' IN ALL FIELDS RETURNING ' + selectedObject + ' ( '+innerString + ' ) ';		
			system.debug('----dynamicString----'+dynamicString);
            
            listOfSObjects = search.query( dynamicString );
            
            system.debug('----listOfSObjects----'+listOfSObjects);
			searchList = (List<sObject>)listOfSObjects[0];
            system.debug('----searchList----'+searchList);
		}
		catch(Exception e){
			String errorMessage = e.getMessage();
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,errorMessage));		   
		}

	}	
}
/**
 * Controller which specifies the logic to update the status of various Job Requests for Technician
 */
public with sharing class JobRequestControllerTechnician {
    public list<Case> existingCases {get;set;}
    public JobRequestControllerTechnician(ApexPages.StandardController controller) {
        init();
    }
    /** 
     * Method which display all existing Job Requests for the reference of Technician
     */
    public void init() {
          existingCases = [ Select  
                                    CaseNumber,
                                    Job_Type__c,
                                    Job_Description__c,
                                    Status 
                            From 
                                    Case 
                            Where 
                                    Job_Type__c = 'Maintainance' OR Job_Type__c = 'Repair'
                          ];   
    }

    /** 
     * Method which updates the Job Requests ie saves the changes made by Technician
     * Note : The updations/changes here refer to updating the status of Job Request
     */   
    public PageReference updateRecord(){      
        try{ 
            update existingCases;
        }
        catch(DmlException ex){
            ApexPages.addMessages(ex);
        }
        init();
        return null;
    }     
}
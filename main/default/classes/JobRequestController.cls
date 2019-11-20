/**
 * Controller to check whether Job requests are accepted and updated as expected
 */
public with sharing class JobRequestController {
    ApexPages.StandardController stdController;
    public list<SelectOption> jobTypes {get;set;}
    public list<Case> existingCases {get;set;}
    public string selectedJob {get;set;}
    public Case caseObj{get;set;}

    public JobRequestController(ApexPages.StandardController controller) {
        stdController = controller;
        init();
        this.caseObj = (case)controller.getRecord();
        jobTypes = new list<SelectOption>();
        jobTypes.add(new SelectOption('Maintainance','Maintainance'));
        jobTypes.add(new SelectOption('Repair','Repair'));   
    }
    /**
     * Method which accepts Job Request Input parameters and Saves them 
     */
    public PageReference save() {
        if(selectedJob == 'Maintainance'){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Cost of your Job is 3000'));
        }
        if(selectedJob == 'Repair'){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Cost of your Job is 6000'));
        }        
        //stdController.save(); // calling standard save() method
        /**
         *Fetching the assignment rules on case and assigning it to the jod request record being created
         */ 
        AssignmentRule assgRule = new AssignmentRule();
        assgRule = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= assgRule.id;
        //Case newCase = new Case(Status = 'New') ;
        caseObj.setOptions(dmlOpts);
        insert caseObj;
        /**
         *return 'null' to stay on same page
         */
        return null; 
    }
    /**
     * Returning page reference as new vf page named 'UpdateJobPage'
     */
    public PageReference updateJob(){
        return Page.UpdateJobPage;
    }
    
    /**
     * Method to display all existing Job Requests
     */
    public void init() {
          existingCases = [ Select  
                                    CaseNumber,
                                    Job_Type__c,
                                    Job_Description__c 
                            From 
                                    Case 
                            Where 
                                    Job_Type__c = 'Maintainance' OR Job_Type__c = 'Repair'
                          ];   
    }
    
    /**
     * Method which saves the changes made by user ie updates the job request
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
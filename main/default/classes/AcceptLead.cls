@RestResource(urlMapping='/getData/*')
global class AcceptLead {
    /**
     * Method which creates Lead record by accepting parameters from other org
     */
    @HttpPost
    global static void createLeadRecord(leadRecord record){
        List<Lead> thisLead = new List<Lead>{new Lead(LastName = record.LastName , Company = record.Company,Status = record.Status)};
        Database.SaveResult[] insertedLeads = Database.insert(thisLead,false );  
        for (Database.SaveResult sr : insertedLeads ) {
             RestResponse res = RestContext.response;
             ResponseMessage objectExternalClass = new ResponseMessage();
            if (sr.isSuccess()) {
                objectExternalClass.isSuccess = True;
                objectExternalClass.recordId = sr.getId();  
                objectExternalClass.Status = 'Success';
                system.debug('Tested here');
                res.responseBody = Blob.valueOf(JSON.serialize(objectExternalClass));
            }
            else {
                for(Database.Error err : sr.getErrors()) {
                    objectExternalClass.isSuccess = False;
                    objectExternalClass.recordId = '';  
                    objectExternalClass.Status = err.getMessage();
                    res.responseBody = Blob.valueOf(JSON.serialize(objectExternalClass));
                }
            }                
        }              
    }
    /**
     * Method which deletes Lead record by accepting parameters from other org
     */
    @HttpDelete
    global static void doDelete() {
        String leadID = RestContext.request.params.get('leadId');
        system.debug('ID------> '+leadID);
        String leadLastName = RestContext.request.params.get('leadLastName'); 
        system.debug('LastName------> '+leadLastName);       
        RestResponse res = RestContext.response;
        //String leadId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<Lead> leadList = [SELECT Id,LastName FROM Lead WHERE Id=:leadID AND LastName=:leadLastName];

         if(leadList.isEmpty()){
             RestResponse responseUpdate = RestContext.response;
             String showMessage;         
             showMessage = 'Such Record does not Exists ';
             responseUpdate.responseBody = Blob.valueOf(JSON.serialize(showMessage));
         }
        Database.DeleteResult[] deletedLeads = Database.delete(leadList , false);
        for(Database.DeleteResult dr : deletedLeads ) {
            RestResponse responseDelete = RestContext.response;
            ResponseMessage objectExternalClass = new ResponseMessage();
            if (dr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                objectExternalClass.isSuccess = True;
                objectExternalClass.recordId = dr.getId();  
                objectExternalClass.Status = 'Success';               
                responseDelete.responseBody = Blob.valueOf(JSON.serialize(objectExternalClass));
            }
            else {
                // Operation failed, so get all errors               
                for(Database.Error err : dr .getErrors()) {
                    objectExternalClass.isSuccess = True;
                    objectExternalClass.recordId = '';  
                    objectExternalClass.Status = err.getMessage();                    
                    responseDelete.responseBody = Blob.valueOf(JSON.serialize(objectExternalClass));
                }
            }                
        }          
    }

    /**
     * Method which updates existing Lead record by accepting parameters from other org
     */    
    @HttpPatch
    global static void leadUpdate(leadRecord record){   
         //List<Lead> delLead = new List<Lead>{new Lead(LastName = record.LastName , Company = record.Company,Status = record.Status)};
         Lead putleadUpdate = new Lead(LastName = record.LastName , Company = record.Company,Status = record.Status);
         String lastNameLead = putleadUpdate .LastName ;
         System.debug('----Name----'+lastNameLead );
         String companyNameLead =  putleadUpdate.Company;
         String statusLead =  putleadUpdate.Status;
         System.debug('----statusLead----'+statusLead );
         List<Lead> leadCheck = [Select Id, LastName,Status,Company From Lead];
         system.debug('*****Normal Query***'+leadCheck);
         List<Lead> putUpdateLead = [Select Id,LastName From Lead Where LastName = : lastNameLead AND Status = : statusLead  ];
         //List<Lead> putUpdateLead = [Select Id,LastName,Company From Lead Where LastName ='Test Lead 600' AND Status='Closed Converted'  ];
         //system.debug('***CHECK POINT****'+putUpdateLead);
         for(Lead eachLead : putUpdateLead ){
             eachLead.Company = companyNameLead ;
         }  

         if(putUpdateLead.isEmpty()){
             RestResponse responseUpdate = RestContext.response;
             String showMessage;         
             showMessage = 'Such Record does not Exists ';
             responseUpdate.responseBody = Blob.valueOf(JSON.serialize(showMessage));
         }            
         Database.SaveResult [] putUpdatedLeads = Database.update(putUpdateLead , false);
         for (Database.SaveResult sr : putUpdatedLeads ) {
             RestResponse responseUpdate = RestContext.response;
             ResponseMessage objectExternalClass = new ResponseMessage();
             if (sr.isSuccess()) {
                 // Operation was successful, so get the ID of the record that was processed
                 objectExternalClass.isSuccess = True;
                 objectExternalClass.recordId = sr.getId();  
                 objectExternalClass.Status = 'Success';               
                 responseUpdate.responseBody = Blob.valueOf(JSON.serialize(objectExternalClass));
             }
             else {
                 // Operation failed, so get all errors               
                 for(Database.Error err : sr.getErrors()) {
                    objectExternalClass.isSuccess = True;
                    objectExternalClass.recordId = '';  
                    objectExternalClass.Status = err.getMessage();                     
                    responseUpdate.responseBody = Blob.valueOf(JSON.serialize(objectExternalClass));
                 }
             }                
        }        
    } 
    
    /**
     * Wrapper class to pass parameters to methods
     */
    global class leadRecord{
        global String LastName;
        global String Company; 
        global string Status;
    }
    /**
     * Wrapper class containing variables for Response generation
     */
    global class ResponseMessage{
        global Boolean isSuccess;
        global String recordId ;
        global String Status ;
    }
}
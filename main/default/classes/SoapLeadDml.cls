/**
 * This class performs the required actions and sends response based on those actions to the client side
 */
global class SoapLeadDml{
    /**
     * This method creates lead record based on the parameters accepted from other org
     * It also sends response to the other org according to the actions performed 
     */
    webService static String createLead(String FirstName , String LastName , String Email , String Phone,String Company, String Status){
        String responseMessage;
        List<Lead> insertThis =new List<Lead>{new Lead(LastName = LastName , FirstName = FirstName , Email = Email , Phone = Phone, Company=Company,Status=Status)};
                Database.SaveResult[] insertedLeads = Database.insert(insertThis,false );
                for(Database.SaveResult sr : insertedLeads ) {
                    Boolean isSuccess=true;
                    String leadId;
                    String statusMessage= 'Success';
                    
                    if (sr.isSuccess()) {
                        // Operation was successful, so get the ID of the record that was processed
                        System.debug('Successfully inserted Lead. LeadID: ' + sr.getId());
                        responseMessage = 'isSuccess..'+isSuccess+'   '+' ID of Lead Inserted.. '+sr.getId()+'  '+'Status.. '+statusMessage;
                    }
                    else {
                        // Operation failed, so get all errors               
                        for(Database.Error err : sr.getErrors()) {
                            isSuccess=false;
                            responseMessage = 'isSuccess..'+isSuccess+'    '+' ID of Lead Inserted.. '+'  '+'   '+'Status.. '+err.getMessage();
                        }
                    }                
               }
      return responseMessage;
    }
    /**
     * This method deletes lead record based on the parameters accepted from other org
     * It also sends response to the other org according to the actions performed 
     */    
    webService static String deleteLead(String FirstNameLead , String LastNameLead , String EmailLead , String PhoneLead,String CompanyLead, String StatusLead){
        String responseMessage;
        Lead deleteThis = new Lead(LastName = LastNameLead , FirstName = FirstNameLead , Email = EmailLead , Phone = PhoneLead, Company=CompanyLead,Status=StatusLead);
        String leadLastName = deleteThis.LastName;
        String leadFirstName = deleteThis.FirstName;
        String leadCompany = deleteThis.Company;
        String leadEmail =deleteThis.Email;
        String leadStatus = deleteThis.Status;
        String leadPhone = deleteThis.Phone;
                List<Lead> deleteLead = [Select Id From Lead Where LastName =:leadLastName AND Company=:leadCompany AND Status=:leadStatus AND Phone=:leadPhone AND Email=:leadEmail  ];              
                if(deleteLead.isEmpty()){
                    responseMessage = 'No such record exists';
                }
                Database.DeleteResult[] deletedLeads = Database.delete(deleteLead , false);
                for (Database.DeleteResult dr : deletedLeads ) {
                    Boolean isSuccess=true;
                    String leadId;
                    String statusMessage= 'Success';
                    if (dr.isSuccess()) {
                        System.debug('Successfully Deleted Lead. LeadID: ' + dr.getId());
                        responseMessage = 'isSuccess..'+isSuccess+'   '+' ID of Deleted Lead.. '+dr.getId()+'  '+'Status.. '+statusMessage;
                     }
                    else {               
                        for(Database.Error err : dr .getErrors()) {
                            isSuccess=false;
                            responseMessage = 'isSuccess..'+isSuccess+'    '+' ID of Lead Deleted.. '+'  '+'   '+'Status.. '+err.getMessage();
                        }
                    }                
               }         
        
        
        return responseMessage;
    }
    /**
     * This method updates existing lead record based on the parameters accepted from other org
     * It also sends response to the other org according to the actions performed 
     */    
    webService static String updateLead(String FirstNameLead , String LastNameLead , String EmailLead , String PhoneLead,String CompanyLead, String StatusLead){
        String responseMessage;
        Lead updateThis = new Lead(LastName = LastNameLead , FirstName = FirstNameLead , Email = EmailLead , Phone = PhoneLead, Company=CompanyLead,Status=StatusLead);
        String leadLastName = updateThis.LastName;
        String leadFirstName = updateThis.FirstName;
        String leadCompany = updateThis.Company;
        String leadEmail =updateThis.Email;
        String leadStatus = updateThis.Status;
        String leadPhone = updateThis.Phone;
                List<Lead> updateLead = [Select Id,LastName,Phone From Lead Where FirstName=: leadFirstName AND LastName =:leadLastName ];              
                if(updateLead.isEmpty()){
                    responseMessage = 'No such record exists';
                }                
                for(Lead updateEachLead : updateLead){
                    updateEachLead.Email=leadEmail;
                    updateEachLead.Phone = leadPhone;
                }
                Database.SaveResult [] updatedLeads = Database.update(updateLead , false);
                for (Database.SaveResult sr : updatedLeads ) {
                     RestResponse res = RestContext.response;
                     Boolean isSuccess=true;
                     String leadId;
                     String statusMessage= 'Success';
                    if (sr.isSuccess()) {
                        // Operation was successful, so get the ID of the record that was processed
                        System.debug('Successfully updated Lead. LeadID: ' + sr.getId());
                        responseMessage = 'isSuccess..'+isSuccess+'   '+' ID of Lead Updated.. '+sr.getId()+'  '+'Status.. '+statusMessage;
                    }
                    else {
                        // Operation failed, so get all errors               
                        for(Database.Error err : sr.getErrors()) {
                            isSuccess=false;
                            responseMessage = 'isSuccess..'+isSuccess+'    '+' ID of Lead... '+'  '+'   '+'Status.. '+err.getMessage();
                        }
                    }                
               }         
        
        
        return responseMessage;
    }    
    
}
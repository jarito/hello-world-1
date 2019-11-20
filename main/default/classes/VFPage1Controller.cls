/**
 * Controller which contains logic to control the flow of pages transition
 */
public class VFPage1Controller{

    public String accountID {get;set;}
    public ID recordID;
    Account account;
     
    public  Attachment attachment {
          get; /*{
              //if (attachment == null)
              //attachment = new Attachment();
              //return attachment;
          }*/
          set;
    }
    //Constructor
    public VFPage1Controller(ApexPages.StandardController controller){
        /**
         * Get current record ID and current record
         */
        this.recordID = controller.getRecord().Id;
        this.account = (account)controller.getRecord();
        attachment = new Attachment() ;
    }
    /**
     * This method contains logic for deleting a attachment by keeping same page reference
     */
    public PageReference deleteAttachment(){
        Attachment attach = new Attachment();
        attach = [Select 
                        id 
                  From 
                        Attachment 
                  Where 
                        id =: accountID];
        system.debug('accountID----> '+accountID);
        system.debug('query result---> '+attach);
        delete attach;
        PageReference pageRef = ApexPages.currentPage();
        pageRef.setRedirect(true);
        system.debug('pageRef----> '+pageRef);
        return pageRef;
    }
    /**
     * Redirection to a new page where record can be edited
     */
    public PageReference VFStep2(){
    return Page.VFPage2;
    }
    /**
     * Redirection to a new page where files can be added and record changes can be saved
     */
    public PageReference VFStep3(){
    return Page.VFPage3;
    }
    /**
     * Method containing logic to save a record and related attachment
     */
    public PageReference save(){
        if(attachment.body != null && attachment.name != null && attachment.description != null ){
            attachment.OwnerId = UserInfo.getUserId();
            attachment.parentId = ApexPages.currentPage().getParameters().get('id');
            attachment.IsPrivate = true; 

            system.debug('attachment.description----> '+attachment.description);
            system.debug('attachment.name----> '+attachment.name);
            system.debug('attachment.body----> '+attachment.body);
            system.debug('OwnerId----> '+attachment.OwnerId);
            system.debug('parentId----> '+attachment.parentId);
            try {
                    insert attachment;
                } 
            catch (DMLException e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
                return null;
            } finally {
            attachment = new Attachment(); 
            }
        }
        
        update account;
       /**
        * Redirection to second page
        */    
        PageReference redirectPage = Page.VFPage1;
        redirectPage.setRedirect(True);
        redirectPage.getParameters().put('id',recordID);
        return redirectPage; 
      
        /**
         * PageReference accountPage = new ApexPages.StandardController(account).view();
         * accountPage.setRedirect(true);
         * return accountPage;
         */
    }
}
public class RunUpdateOrderBatchVFController {
    public ID detailPageId;
    public RunUpdateOrderBatchVFController(ApexPages.StandardController controller) {
        detailPageId = controller.getId();
    }
    
    public PageReference executeBatch() {//String query = 'Select Id From Order Where ID =:'+detailPageId+' AND SBQQ__Contracted__c = true AND No_of_Contracts__c = 0 AND Count_of_Order_Products__c > 0';
        Id batchJobID = Database.executeBatch(new UpdateOrderBatch(detailPageId), 200);
        AsyncApexJob a = [SELECT 
                                Id, 
                                Status, 
                                NumberOfErrors, 
                                JobItemsProcessed, 
                                TotalJobItems, 
                                CreatedBy.Email, 
                                ExtendedStatus
                          FROM  AsyncApexJob 
                          WHERE Id =: batchJobID];
        System.debug('Batch Status >>> '+a.Status);
        PageReference pg = new PageReference('/'+detailPageId);
        //System.debug('Delay >>> '+pg.getParameters().get('delay'));
        //pg.getParameters().put('delay','3000');
        pg.setRedirect(true);
        return pg;
    }
}
public class NewCaseListController{
            
    public List<Case> getNewCases()
    {
        List<Case> results = [Select Id, CaseNumber From Case Where status = 'closed'];
        return results;
    }        
    
}
/**
 * Class to fetch all Closed Won Opportunities of Account and send an Email to Primary Contact 
 * of that account 
 */
global class OpportunityPerDay implements Database.Batchable<sObject>, Database.Stateful {
    /**
     * MAP 1
     * The map below, MapOfEmailAndAccountID is a map of Primary Contacts EmailID as a Key and associated  
     * Accounts ID as Value
     */
    Map<String,ID> MapOfEmailAndAccountID = new Map<String,ID>();
    /**
     * MAP 2
     * The map below, mapOfAccountIDAndOpportunityList is a map of Account ID as a Key and associated List 
     * of Opportunities as Value
     */
    Map<ID,List<Opportunity>> mapOfAccountIDAndOpportunityList = new Map<ID,List<Opportunity>>();
    /**
     * MAP 3
     * The map below, mapOfEmailAndOpportunityList is a map of Primary Contacts EmailID as a Key and 
     * List of Opportunities associated with the Account of that Primary Contact as Value.
     * This map is Combination of the two Maps created above.
     * Where Key of this Map is same as Key of MAP 1 and Value of this Map is same as value of MAP 2
     */    
    Map<String,List<Opportunity>> mapOfEmailAndOpportunityList = new Map<String,List<Opportunity>>();
    /**
     * This method fetches all Opportunities with Stage Closed Won along with respective Accounts and  
     * thier recpective Primary Contacts Email ID
     */
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select
                                                Id,
                                         		Name,
                                                Amount,
                                                StageName,
                                                AccountId,
                                                Account.PrimaryContact__r.Email
                                         From   
                                                Opportunity
                                         Where 
                                                StageName = 'Closed Won'
                                                AND
                                                Account.PrimaryContact__r.Email != null
                                        ]);
    }

    /**
     * This method accepts a list from above method(start) and contains the processing logic
     */
    global void execute(Database.BatchableContext bc , List<Opportunity> opportunityList){
        system.debug('---In Execute Method---');
        /**
         * Creating Map of Primary Contacts Email ID and associated Account ID  
         */
        for(Opportunity eachOpportunity : opportunityList){
            if(MapOfEmailAndAccountID.containsKey(eachOpportunity.Account.PrimaryContact__r.Email)){
                MapOfEmailAndAccountID.put(eachOpportunity.Account.PrimaryContact__r.Email , eachOpportunity.AccountId  );
            }
            else{
                MapOfEmailAndAccountID.put(eachOpportunity.Account.PrimaryContact__r.Email , eachOpportunity.AccountId  );
            }
        }
        system.debug('****Map 1****'+MapOfEmailAndAccountID);
        /**
         * Creating Map of Account ID and List of associated Closed Won Opportunities 
         */
        for(Opportunity eachOpportunity : opportunityList){
            if(mapOfAccountIDAndOpportunityList.containsKey(eachOpportunity.AccountId)){
                List<Opportunity> temporaryList = mapOfAccountIDAndOpportunityList.get(eachOpportunity.AccountId);
                temporaryList.add(eachOpportunity);
            }
            else{
                List<Opportunity> temporaryList = new List<Opportunity>();
                temporaryList.add(eachOpportunity); 
                mapOfAccountIDAndOpportunityList.put(eachOpportunity.AccountId , temporaryList);
            }
        }
        system.debug('****Map 2****'+mapOfAccountIDAndOpportunityList);
        /**
         * Creating Map of Primary Contacts Email ID and List of Opportunities associated with Account of that Contact  
         */
        List<Opportunity> tempList ;
        for(String eachEmail :  MapOfEmailAndAccountID.keySet()){
            ID tempAccountID = MapOfEmailAndAccountID.get(eachEmail);
            tempList = new List<Opportunity>();
            tempList = mapOfAccountIDAndOpportunityList.get(tempAccountID);
            mapOfEmailAndOpportunityList.put(eachEmail , tempList);
        }
        system.debug('****Map 3****'+mapOfEmailAndOpportunityList);
    }

    /**
     * The method below does the Post processing work. Here, task of sending Email to Primary Contact is
     * done in this method
     */    
    global void finish(Database.BatchableContext bc){
        system.debug('********FINISH SIDE MAP*********'+mapOfEmailAndOpportunityList);
        /**
         * A list to contain list of emails to be sent to opportunities 
         */
        List<Messaging.SingleEmailMessage> sendEMailList = new List<Messaging.SingleEmailMessage>();
        for( String eachContactEmail : mapOfEmailAndOpportunityList.keySet() ){
            Messaging.SingleEmailMessage objectEmail = new Messaging.SingleEmailMessage();
            objectEmail.setsubject('Opportunities Closed Today');
            /**
             * List containing Email Ids of Primary Contacts
             */
            List<String> toAdd = new List<String>();
            toAdd.add(eachContactEmail);
            Decimal sumOfAmount =0 ;
            String formattedOpportunity = '';
            
            for(Opportunity eachOpportunity : mapOfEmailAndOpportunityList.get(eachContactEmail)){
                    sumOfAmount = sumOfAmount + eachOpportunity.Amount;
                    formattedOpportunity = formattedOpportunity+'\n'+eachOpportunity.Name +'    '+eachOpportunity.Amount;
            }   
            /**
             * This Email body contains Opportunities associated with Account of Primary Contact and also the
             * sum of Amount associated with each Opportunity  
             */
            objectEmail.setplaintextbody('Opportunity Associated with this Contact are '+formattedOpportunity+'\n'+' Total Amount = '+sumOfAmount);
            objectEmail.setToAddresses(toAdd);
            sendEMailList.add(objectEmail);
        }
        system.debug('List of Emails'+sendEMailList);
        if(!sendEMailList.isEmpty()){
            //List of all Emails
            //List<Messaging.SendEmailResult>  result = Messaging.sendEmail(sendEMailList); 
            system.debug('----sendEMailList--'+sendEMailList)  ;                
        }
    }
}
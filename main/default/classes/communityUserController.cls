public class communityUserController {
    @auraEnabled
    public static List<Contact> fellowRecordsListApex(List<String> picklist1 , List<String> picklist2 ,List<String> picklist3){
        List<String> plist1 = picklist1;
        List<String> plist2 = picklist2;
        List<String> plist3 = picklist3;
        system.debug('plist1-> '+plist1);
        String criteriaEquals = '';
        String criteriaContains = '' ;
        
        integer listSize =  plist1.size();
        system.debug('list size -->'+listSize);
        String temp11 = plist1[0];
        String temp22 = plist3[0];
        if(plist2[0] == 'equals'){
           	criteriaEquals = criteriaEquals	+ ' '+  temp11 +' '+ '=: temp22 ' + ' ' ; 
        }
        else if(plist2[0] == 'contains'){
            String val = '\'%' +temp22+ '%\' ';
			criteriaEquals = criteriaEquals	+ ' '+  temp11 + ' ' +'like' +val+ ' ' ; 
        }
        
        
        if(listSize > 1){
            for(integer i = 1 ; i <= plist1.size() ; i++){
                for(integer j = 1 ; j <= plist2.size() ; j++){
                    for(integer k = 1 ; k <= plist3.size() ; k++){
                        if(i == 0 && j == 0 && k == 0){
                            if(plist2[0] == 'equals'){
                                String temp1 = plist1[0];
                                String temp2 = plist3[0];
                                criteriaEquals = criteriaEquals	+ ' ' + ' OR ' + ' '+  temp1 + '=: temp2 ' + ' ' ;	
                                system.debug('IN IF equals 0...');
                            } 
                            if(plist2[0] == 'contains'){
                                String temp1 = plist1[0];
                                String temp2 = plist3[0];
                                String val = '\'%' +temp2+ '%\' ';
                                criteriaEquals = criteriaEquals	+ ' ' + ' OR ' + ' '+  temp1 + 'like '+val+ ' ' ;	  
                            	system.debug('IN IF contains 0...');
                            }
                        }
                        if(i == 1 && j == 1 && k == 1){
                            if(plist2[1] == 'equals'){
                                String temp1 = plist1[1];
                                String temp2 = plist3[1];
                                criteriaEquals = criteriaEquals	+  ' ' + ' OR ' + ' ' + temp1  +'=: temp2 ' + ' ' ;
                                system.debug('IN IF equals 1...');
                            }if(plist2[1] == 'contains'){
                                String temp1 = plist1[1];
                                String temp2 = plist3[1];
                                String val = '\'%' +temp2+ '%\' ';
                                criteriaEquals = criteriaEquals	+ ' ' + ' OR ' + ' '+  temp1 + ' ' +'like'+val + ' ' ;	  
                            	system.debug('IN IF contains 1...');
                            }
                        }
                    }
                }
            }            
        }   

        
        String dynamicString = 'Select Id, (Select Id From Users) ,Email__c,FirstName,LastName,Current_City__c,Current_Country__c,Phone From Contact Where ' + criteriaEquals ;
        system.debug('dynamicString -- >' +dynamicString);
        List<Contact> userList =  Database.query(dynamicString);
       
        return userList;
    }
    
	@auraEnabled
    public static User getCurrentUser(){
        User oUser = [select  id,
                      		  Contact.Id,
                      		  Contact.LastName, 
                      		  Contact.FirstName,
                      		  Contact.fellowshipDuration__c, 
                      		  Contact.fellowshipLocation__c,
                      	      Contact.Title,
                      		  Contact.languagesSpoken__c,
                      		  Contact.Phone,
                      		  Contact.skype__c,
                      		  Name
                 	  FROM 
                      		  User 
                      Where 
                      		  id =: userInfo.getUserId()];
        return oUser;
    }
    
    @auraEnabled(cacheable=true)
    public static Account getAccountId(){
        Account objAccount = [Select Id From Account Where Name = 'Edge Communications'];
        return objAccount;
    }
 
    @auraEnabled(cacheable=true)
    public static List<User> getSkillSet(){
        List<User> userSkills = [Select Name, (Select Name,Skills__c  From Skill_Sets__r) From User];
        return userSkills;
    }
    
}
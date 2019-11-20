trigger ClosedOpportunityTrigger on Opportunity (before insert,before update) {
    List<Task> taskList = new List<Task>();
    for(Opportunity oppVar : Trigger.New){
        if(oppVar.StageName == 'Closed Won'){
            Task taskVar = new Task();
            taskVar.Subject = 'Follow Up Test Task';
            taskVar.WhatId = oppVar.Id;
            taskList.add(taskVar);
        }
    }
    if(taskList.size() > 0 ){
        insert taskList;
    }
}
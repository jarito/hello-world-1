function chooseAccount(Id){
               	RemotingController.deleteAccount(Id,function(result, event){
                   	if (event.status){
                 	      alert('Account has been deleted');
                   	}
               	} 
        );        
}    


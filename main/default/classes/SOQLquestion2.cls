public with sharing class SOQLquestion2 {
	/* This function displays the list of IDs and Names of all the Active Users */
	public soqlQuestion2() {
		Map<ID,User> mapOfUser = new Map<ID,User>();
		List<User> usersList = [Select Id, Name From User Where IsActive = True ]; 
		for(User userVar : usersList){
			mapOfUser.put(userVar.id, userVar);
		}
		system.debug(mapOfUser);
	}
}
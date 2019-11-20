public class ContactsListController {
   private String sortOrder = 'LastName';
    
    
    
    public List<Contact> contacts {get;set;} 
    public ContactsListController(){
    /*
    contacts=new List<Contact>();
    contacts= Database.query(
            'SELECT Id, FirstName, LastName, Title, Email ' +
            'FROM Contact ' +
            'ORDER BY ' + sortOrder + ' ASC ');
            */
       
    }
    
    public List<Contact> contactMethod(){
     contacts= Database.query(
            'SELECT Id, FirstName, LastName, Title, Email ' +
            'FROM Contact ' +
            'ORDER BY ' + sortOrder + ' ASC ');
  
    return contacts;
    }
    
    /*
    public List<Contact> abc() {
    
        List<Contact> contacts = Database.query(
            'SELECT Id, FirstName, LastName, Title, Email ' +
            'FROM Contact ' +
            'ORDER BY ' + sortOrder + ' ASC '
      
        );
        return contacts ;
    }
    */
    
    public void sortByLastName() {
        this.sortOrder = 'LastName';
                contactMethod();

    }
        
    public void sortByFirstName() {
        this.sortOrder = 'FirstName';
        contactMethod();

    }    
    
        public void sortByEmail() {
        this.sortOrder = 'Email';
        contactMethod();

    }  
}
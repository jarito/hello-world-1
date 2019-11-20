({
   doInit : function(component, event, helper) {
		//debugger;
        //var tmp = component.get("v.recordId")
        //console.log('***ID IN MAP***',tmp);
/*	var tempValue = component.get("v.contactInfo");
       if(tempValue != null){
       cmp.set('v.mapMarkers', [
            {
                location: {
                    Street: tempValue.MailingStreet,
                    City: tempValue.MailingCity,
                    State: tempValue.MailingState
                },

                title: 'The White House',
                description: 'Landmark, historic home & office of the United States president, with tours for visitors.'
            }
        ]);            
       }
*/        
      /*  var centreValue = component.get("v.mapCenter");
       	var titleValue = component.get("v.markersTitle");
       if(centreValue != null && titleValue != null) {
           component.set('v.mapCenter', {
           		location: {
           			Country: 'United States'
           		}
           }); 
           component.set('v.markersTitle', 'Google Office locations.');
           
       }*/

   },

    childMethod : function(component, event, helper) {
        //Call Child aura method
        //var contactObj = component.get('v.contactInfo');
		var params = event.getParam('arguments');
        var contactParam = params.contactDetails;
        var companyParam = params.companyDetails;
        console.log('--------argument1--------'+contactParam.MailingStreet);
        console.log('--------argument2--------'+companyParam.State);
		//component.set('v.mapMarkers',contactParam.contactDetails);
		debugger;
        component.set('v.mapMarkers', [
            {
                location: {
                    Street: contactParam.MailingStreet,
                    City: contactParam.MailingCity,
                    State: contactParam.MailingState,
                    Country: contactParam.MailingCountry,
                    PostalCode:contactParam.MailingPostalCode,

                },

                title: 'Your Address Details',
                description: 'Landmark, historic home & office of the president of India, with tours for visitors.'
            },
           {
                location: {
                    Street: companyParam.Street ,
                    City: companyParam.City,
                    State: companyParam.State,
                    Country: companyParam.Country,
                    PostalCode: companyParam.PostalCode,
                },

                title: 'The Ghost House',
                description: 'Landmark, historic home & office of the United States president, with tours for visitors.'
            },
        ]);
        component.set('v.markersTitle', 'Welcome');
        //component.set('v.zoomLevel', 21);
        //var contactShow = component.get('v.contactInfo');
        //console.log('***contactShow MAP***',contactShow.MailingStreet);
        
    }  
})
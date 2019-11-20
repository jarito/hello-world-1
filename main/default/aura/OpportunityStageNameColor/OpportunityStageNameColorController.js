({
	onLoad: function(component, event, helper) {
		console.log('colorCmp load');
		var sName = component.get("v.stageName");
		debugger;
		if (sName != undefined) {
	
			// **** write picklist values in Lower Case ***** //       
			var tempLowerCase = sName.toLowerCase();
			debugger;
			var cRed = 'closed lost';
			var cGreen = 'closed won';
			var cOrange1 = 'needs analysis';
			var cOrange2 = 'prospecting';
			var cOrange3 = 'qualification';
			var cBlue1 = 'value proposition';
			var cBlue2 = 'id. decision makers';
			var cBlue3 = 'perception analysis';
			var cPurple1 = 'proposal/price quote';
			var cPurple2 = 'negotiation/review';

			// ...add more values vaiable here 
	
			// set the color on based on picklist values 
			var checkIndex1 = cRed.indexOf(tempLowerCase);     
			if (cRed.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Red');
                var checkColor = component.get("v.Color");
                debugger;
			} 
            else if (cGreen.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Green');
                var checkColor = component.get("v.Color");
                debugger;
			} else if (cOrange1.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Orange');
                var checkColor = component.get("v.Color");
                debugger;
			} else if (cOrange2.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Orange');
                var checkColor = component.get("v.Color");
                debugger;
			} else if (cOrange3.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Orange');
                var checkColor = component.get("v.Color");
                debugger;
			} else if (cBlue1.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Blue');
                var checkColor = component.get("v.Color");
			} else if (cBlue2.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Blue');
                var checkColor = component.get("v.Color");
                debugger;
			} else if (cBlue3.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Blue');
                var checkColor = component.get("v.Color");
                debugger;
			} else if (cPurple1.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Purple');
                var checkColor = component.get("v.Color");
                debugger;
			}else if (cPurple2.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Purple');
                var checkColor = component.get("v.Color");
                debugger;
			}

		}
	},
	
	onChange: function(component, event, helper) {
		var checkClosureState = component.get("v.closureStatus");
		var sName = component.get("v.stageName");
		debugger;
		if (sName != undefined) {
	
			// **** write picklist values in Lower Case ***** //       
			var tempLowerCase = sName.toLowerCase();
			debugger;
			var cRed = 'closed lost';
			var cGreen = 'closed won';
			var cOrange1 = 'needs analysis';
			var cOrange2 = 'prospecting';
			var cOrange3 = 'qualification';
			var cBlue1 = 'value proposition';
			var cBlue2 = 'id. decision makers';
			var cBlue3 = 'perception analysis';
			var cPurple1 = 'proposal/price quote';
			var cPurple2 = 'negotiation/review';

			// ...add more values vaiable here 
	
			// set the color on based on picklist values 
			var checkIndex1 = cRed.indexOf(tempLowerCase);     
			if (cRed.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Red');
                var checkColor = component.get("v.Color");
                debugger;
			} 
            else if (cGreen.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Green');
                var checkColor = component.get("v.Color");
                debugger;
			} else if (cOrange1.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Orange');
                var checkColor = component.get("v.Color");
                debugger;
			} else if (cOrange2.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Orange');
                var checkColor = component.get("v.Color");
                debugger;
			} else if (cOrange3.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Orange');
                var checkColor = component.get("v.Color");
                debugger;
			} else if (cBlue1.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Blue');
                var checkColor = component.get("v.Color");
			} else if (cBlue2.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Blue');
                var checkColor = component.get("v.Color");
                debugger;
			} else if (cBlue3.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Blue');
                var checkColor = component.get("v.Color");
                debugger;
			} else if (cPurple1.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Purple');
                var checkColor = component.get("v.Color");
                debugger;
			}else if (cPurple2.indexOf(tempLowerCase) != -1) {
				component.set("v.Color", 'Purple');
                var checkColor = component.get("v.Color");
                debugger;
			}

		}
	}

  })
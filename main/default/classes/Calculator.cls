public with sharing class Calculator {
	/* This Function Calculates Sum, Difference, Product and Division */
	public void calculate(String operation, Integer number1, Integer number2){

		if (operation == 'Sum'){
			Integer	sum = number1 + number2;
			System.debug('Sum of two numbers is : '+sum);
		}
		else if(operation == 'Sub'){
			Integer	difference = number1 - number2;
			System.debug('Subtraction of two numbers is : '+difference);
		}
		else if(operation == 'Div'){
			Integer	division = number1 / number2;
			System.debug('Sum of two numbers is : '+division);
		}
		else if(operation == 'Mul'){
			Integer	multiplication = number1 * number2;
			System.debug('Sum of two numbers is : '+multiplication);
		}

	}
}
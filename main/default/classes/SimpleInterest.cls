public with sharing class SimpleInterest {
    /* This function calculates Simple Interest based on the parameters passed in the function*/
    public void calculateSI(Decimal principal , Decimal numberOfYears, Decimal rate){
        Decimal simpleInterest = (principal * numberOfYears *  rate) / 100 ; 
        system.debug('Simple Interest is : '+simpleInterest);
    }
}
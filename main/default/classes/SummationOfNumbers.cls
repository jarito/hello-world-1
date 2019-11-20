public with sharing class SummationOfNumbers {
    /*This method computes the sum of the numbers till the Input numbers passed as a parameter*/
    public void Summation(Integer inputDigit){
        Integer sum = 0;
        for(Integer digit = 0; digit <= inputDigit ; digit++)  {
            sum = sum + digit ;
        }
        system.debug('Summation of '+inputDigit+' Numbers is: '+sum);
    }
}
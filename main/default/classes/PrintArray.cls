public with sharing class PrintArray {
    /* This function will create and print an array upto the number passed as a parameter */
    public void printArray(Integer Num){
        system.debug('Array Elements:');
        for(Integer i = 0 ; i < Num; i++)
        system.debug(i);
    }
}
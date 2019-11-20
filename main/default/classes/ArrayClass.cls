public with sharing class ArrayClass {
    public void display(Integer[] arrayInput) {
        for(Integer i = 0 ; i < arrayInput.size() ; i++) {
            system.debug( arrayInput[i] );
        }
    }
    public void sortArray(Integer[] arrayInput){
        for(Integer i = 0; i < arrayInput.size() ; i++){
            for(Integer j = i+1 ; j < arrayInput.size() ; j++ ){
                if(arrayInput[i] > arrayInput[j]){
                    Integer temp = arrayInput[i];
                    arrayInput[i] = arrayInput[j];
                    arrayInput[j] = temp;
                }
            }
        }
        system.debug('Sorted Array is:');
        display(arrayInput);
    }
    public void sortArrayReverse(Integer[] arrayInput){
        for(Integer i = 0; i < arrayInput.size() ; i++){
            for(Integer j = i+1 ; j < arrayInput.size() ; j++ ){
                if(arrayInput[i] < arrayInput[j]){
                    Integer temp = arrayInput[i];
                    arrayInput[i] = arrayInput[j];
                    arrayInput[j] = temp;
                }
            }
        }
        system.debug('Reverse Sorted Array is:');
        display(arrayInput);
    }
    
    public void maxValue(Integer[] arrayInput){
        Integer max =arrayInput[0];
            for(Integer i = 0; i < arrayInput.size() ; i++){
                if(max < arrayInput[i]){
                    max = arrayInput[i];
                }
            }
        system.debug('Max Value is : '+max);
    }
    
    public void minValue(Integer[] arrayInput){
        Integer min = arrayInput[0];
            for(Integer i = 0; i < arrayInput.size() ; i++){
                if(min > arrayInput[i]){
                    min = arrayInput[i];
                }
            }
        system.debug('Min Value is : '+min);
    }
}
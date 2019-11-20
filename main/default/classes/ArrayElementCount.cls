public with sharing class ArrayElementCount {
	
	public void CountElements(){

		Integer[] IntArray = new Integer[]{5,2,3,1,1,2};
		for(Integer i = 0; i < IntArray.size() ; i++){
			system.debug(IntArray[i]);
		}

		Integer[] IntCount = new Integer[]{0,0,0,0,0,0,0,0,0,0};


		for(Integer i = 0; i < IntArray.size() ; i++)
		{
			IntCount[IntArray[i]]++;
		}

		system.debug('Count of each array element is : ');

		for(Integer i = 0; i < IntCount.size() ; i++)
		{
			system.debug( i + ' --> ' + Intcount[i]);
		}

	}
}
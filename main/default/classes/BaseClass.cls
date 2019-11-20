public  with sharing class BaseClass {
	Integer num;
	String name;

	public BaseClass(){

	}

	public BaseClass(Integer digit, String text){
		num = digit;
		name = text;
	}

	public void display() {
		system.debug('--Name is-- '+name);
		system.debug('--Number is-- '+num);
	}

}
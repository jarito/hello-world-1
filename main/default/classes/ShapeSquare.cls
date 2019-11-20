public with sharing class ShapeSquare extends Shape{
	public Integer side = 20;
	public Integer result = 0;
	
	/* The method below Overrides the abstract method in Base class(Shape)  */
	public override void Area() {
		result = side * side;
		system.debug('Area of Square is: '+result);		
	}
}
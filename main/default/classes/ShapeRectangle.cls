public with sharing class ShapeRectangle extends Shape{
	public Integer Length = 20;
	public Integer Height = 10;

	public override void Area() {
	
		system.debug('Area of Rectangle is: '+(Length * Height));		
	}
}
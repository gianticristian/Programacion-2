package;

import flixel.FlxObject;

class EnemyBlue extends Enemy 
{
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic("assets/images/Enemy Blue.png", true, 16, 16);
		updateHitbox();
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		health = 1;
		damage = 1;
		gravity = 1000;
		speed = 400;
		maxSpeed = 500;
	}
	
	
	
}
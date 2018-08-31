package;

import flixel.FlxObject;
import flixel.FlxSprite;


class Kick extends FlxSprite 
{
	private var speed : Int = 850;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic("assets/images/Kick.png", true, 16, 16);
		updateHitbox();
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		velocity.x = speed;
		maxVelocity.set(speed, 0);
	}
	
	public function setDirection(direction:Int)
	{
		if (direction == 1)
		{
			velocity.x = -speed;
			facing = FlxObject.LEFT;
		}
		else
		{
			velocity.x = speed;
			facing = FlxObject.RIGHT;
		}
	}
}
package;

import flixel.FlxObject;
import flixel.FlxSprite;


class Punch extends FlxSprite 
{
	private var speed : Int = 700;
	

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic("assets/images/player.png", true, 16, 16);
		scale.set(3, 3);
		updateHitbox();
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		animation.add("Move", [29], 0, false);
		animation.play("Move");
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
package;

import flixel.FlxSprite;
import flixel.FlxObject;


class Enemy extends FlxSprite 
{
	public var damage : Int;
    public var speed : Int;
	public var maxSpeed : Int;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		facing = FlxObject.LEFT;
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);	
	}
	
	override public function update (elapsed : Float)
    {
		super.update(elapsed);
    }
	
	public function Hurt(damage : Int)
	{
	
		health -= damage;
		velocity.x = 0;
		animation.play("Hurt");
		
		animation.finishCallback = function L(s : String)
		{
			if (health < 1)
				kill();
			else
				animation.play("Walk");
		}
	}

	public function Turn()
	{
		if (facing == FlxObject.LEFT)
			facing = FlxObject.RIGHT;
		else 
			facing = FlxObject.LEFT;
			
		velocity.x *= 0;
		acceleration.x *= -1;
	}
}
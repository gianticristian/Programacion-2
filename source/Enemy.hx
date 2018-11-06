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
		Walk();
		super.update(elapsed);
    }
	
	public function Hurt(damage : Int)
	{
		health -= damage;
		if (health < 1)
			Dead();
	}
	
	public function Dead()
	{
		trace("I am dead");
	}
	
	private function Walk()
	{
		animation.play("Walk");		
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
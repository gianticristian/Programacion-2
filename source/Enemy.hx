package;

import flixel.FlxSprite;


class Enemy extends FlxSprite 
{
	public var damage : Int;
	public var gravity : Int;
    public var speed : Int;
	public var maxSpeed : Int;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		acceleration.y = gravity;
		acceleration.x = speed;
		maxVelocity.set(maxSpeed, gravity);	
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
	
}
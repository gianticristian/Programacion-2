package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.tweens.FlxTween;


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
		var accelerationTemp = acceleration.x;
		acceleration.x = 0;
		velocity.x = 0;
		animation.play("Hurt");
		
		if (health < 1)
			Die();
		
		animation.finishCallback = function HurtContinue(_animation : String)
		{
			acceleration.x = accelerationTemp;
			animation.play("Walk");
		}
	}
	
	private function Die()
	{
		animation.play("Die");
		solid = false;
		
		FlxTween.tween(this, { y: y - 10}, .1, 
		{
			onComplete: function(_)
			{
				FlxTween.tween	( this, { alpha: 0.1 }, 1, 
				{
					onComplete: function(_) 
					{
						kill();
					}
				});
			}
		});		
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
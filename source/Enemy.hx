package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;


class Enemy extends FlxSprite 
{
	public var player : Player;
	public var hurtSound : FlxSound;
	public var damage : Int;
	private var speed : Int;
	private var maxSpeed : Int;
	private var lookRange : Int;
	
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		facing = FlxObject.LEFT;
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);	
		
		hurtSound = FlxG.sound.load("assets/sounds/Enemy Hurt.wav");
		Sound.instance.sfxGroup.add(hurtSound);
	}
	
	override public function update (elapsed : Float)
    {
		SearchPlayer();
		super.update(elapsed);
    }
	
	public function Hurt(damage : Int)
	{
		health -= damage;
		animation.play("Hurt");
		hurtSound.play();
		var accelerationTemp = acceleration.x;
		acceleration.x = 0;
		velocity.x = 0;

		
		if (health < 1)
			Die();
		
		animation.finishCallback = function HurtContinue(_animation : String)
		{
			acceleration.x = accelerationTemp;
			if (IsPlayerBehind())
				Turn();
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
				FlxTween.tween(this, { alpha: 0.1 }, 1, 
				{
					onComplete: function(_) 
					{
						destroy();
					}
				});
			}
		});		
	}
	
	override public function destroy ()
	{
		Sound.instance.sfxGroup.remove(hurtSound);
		super.destroy();
	}
	
	private function IsPlayerBehind() : Bool
	{
		if (player.x < x && facing == FlxObject.RIGHT)
			return true;
		if (player.x > x && facing == FlxObject.LEFT)
			return true;
		return false;
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
	
	private function SearchPlayer()
	{
		if (player != null && player.alive && player.y == y)
		{
			if (!IsPlayerBehind() && Math.abs(x - player.x) < lookRange) 
			{
				trace("Attack!");
			}	
			else
			{
				trace("Where are?!");
			}	
		}
	}
}
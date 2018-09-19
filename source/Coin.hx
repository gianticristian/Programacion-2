package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;


class Coin extends FlxSprite 
{
	public var value : Int = 10;
	private var pickedSound : FlxSound;
	
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic("assets/images/Coins.png", true, 16, 16);
		updateHitbox();
		animation.add("Idle", [25, 26, 27, 28, 29], 10);
		animation.play("Idle");
		pickedSound = FlxG.sound.load("assets/sounds/Coin.wav");
		pickedSound.volume = 0.1;
	}
	
	public function picked ()
	{
		alive = false;
		FlxTween.tween
		(
			this, 
			{ x: this.x, y: this.y - 50 }, 
			0.5,
			{
				ease: FlxEase.quadOut,
				onStart: pickedStart,
				onUpdate: pickedUpdate, 
				onComplete: pickedComplete,
				type: FlxTween.ONESHOT
			}
		);	
	}
	
	function pickedStart(Tween:FlxTween) : Void
	{
		this.pickedSound.play();
	}
	
	function pickedUpdate(Tween:FlxTween) : Void
	{
		this.alpha -= 0.01;
	}
	
	function pickedComplete(Tween:FlxTween) : Void
	{
		this.kill();
	}
}
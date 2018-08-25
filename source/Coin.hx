package;

import flixel.FlxSprite;


class Coin extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic("assets/images/Coins.png", true, 16, 16);
		scale.set(2, 2);
		updateHitbox();
		animation.add("Idle", [25, 26, 27, 28, 29], 10);
		animation.play("Idle");
	}
}
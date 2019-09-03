package;

import flixel.FlxSprite;
import flixel.FlxObject;



class Parachute extends FlxSprite 
{
	private var player : Player;

	public function new(_player : Player) 
	{
		super(0, 0);
		PlayState.instance.add(this);
		player = _player;
		loadGraphicFromSprite(player);
		animation.add("Idle", [5], 1);
		animation.play("Idle");
		Show();
	}
	
	override public function update (elapsed : Float)
    {
		super.update(elapsed);
		if (active)
			setPosition(player.x, player.y - player.height);
			
		if (player.isTouching(FlxObject.DOWN))
		{
			Hide();
		}
    }
	
	public function Show ()
	{
		set_active(true);
		set_visible(true);
	}
	
	public function Hide ()
	{
		set_active(false);
		set_visible(false);
	}
	
}
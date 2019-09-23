package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.system.FlxSound;
import flixel.FlxG;


class Parachute extends FlxSprite 
{
	private var player : Player;
	private var openSound : FlxSound;

	public function new(_player : Player) 
	{
		super(0, 0);
		PlayState.instance.add(this);
		player = _player;
		loadGraphicFromSprite(player);
		animation.add("Idle", [5], 1);
		animation.play("Idle");
		openSound = FlxG.sound.load("assets/sounds/Parachute.wav");
		Sound.instance.sfxGroup.add(openSound);
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
		openSound.play();
	}
	
	public function Hide ()
	{
		set_active(false);
		set_visible(false);
	}
	
	override public function destroy()
	{
		Sound.instance.sfxGroup.remove(openSound);
		super.destroy();
	}
}
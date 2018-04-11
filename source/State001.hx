package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import Player;


class State001 extends FlxState
{
	public var _player:Player;
	
	override public function create () : Void 
	{
		// Set the background color
        FlxG.camera.bgColor = FlxColor.WHITE;
		_player = new Player(0, 0);
        add(_player);
		
		
		FlxG.camera.follow(_player, FlxCameraFollowStyle.PLATFORMER, 2);	
		
		super.create();
	}
	
	override public function destroy () : Void 
	{
		super.destroy();
	}
	
	override public function update (elapsed : Float) : Void
	{
		super.update(elapsed);
	}
}
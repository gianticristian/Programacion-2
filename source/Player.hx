package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Gianti Cristian
 */
class Player extends FlxSprite
{
	//Movement
    private var _speed : Float = 275;
    private var _jumpSpeed : Float = 1000;
    private var _gravity : Float = 2500;
	//Input
    private var _left : Bool;
    private var _right : Bool;
    private var _jump : Bool;

	public function new (?X : Float = 0, ?Y : Float = 0)
	{
		super(X, Y);
		makeGraphic(16, 16, FlxColor.GRAY);
		//loadGraphic('assets/images/player.png', false, 64, 64);  
		acceleration.y = _gravity;
	}
	
	private function Input () : Void
    {
        _left = FlxG.keys.anyPressed([LEFT, A]);
        _right = FlxG.keys.anyPressed([RIGHT, D]);
        _jump = FlxG.keys.anyJustPressed([SPACE]);    
        if (_left && _right)
			_left = _right = false;
    }
	
	private function Movement () : Void
    {
        velocity.x = 0;          
        if (_left)
            velocity.x = -_speed;
        if (_right)
            velocity.x = _speed;               
		if ((isTouching(FlxObject.DOWN)) && (_jump))
			velocity.y -= _jumpSpeed;		
    }
   
    override public function update (elapsed : Float)
    {
        Movement();           
        Input();
		super.update(elapsed);
    }
	
	
}
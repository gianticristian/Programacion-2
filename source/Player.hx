package;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;


class Player extends FlxSprite
{
	//Movement
    private var speed : Float = 25;
    private var jumpSpeed : Float = 1000;
    private var gravity : Float = 2500;
	//Input
    private var left : Bool;
    private var right : Bool;
    private var jump : Bool;

	public function new (?X : Float = 0, ?Y : Float = 0)
	{
		super(X, Y);
		loadGraphic("assets/images/player.png", true, 16, 16); 
		scale.set(3, 3);
		updateHitbox();
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		
		animation.add("Idle", [4, 6]);
		animation.add("Walk", [0, 1, 2, 1]);
		
		
		drag.set(50, 50);
		acceleration.y = gravity;
	}
	
	private function Input () : Void
    {
        left = FlxG.keys.anyPressed([LEFT, A]);
        right = FlxG.keys.anyPressed([RIGHT, D]);
        jump = FlxG.keys.anyJustPressed([SPACE]);    
        if (left && right)
			left = right = false;
    }
	
	private function Movement () : Void
    {
        if (left)
		{
			velocity.x += -speed;
			facing = FlxObject.LEFT;
			animation.play("Walk");
		}   
        else if (right)
		{
			velocity.x += speed;
			facing = FlxObject.RIGHT;
			animation.play("Walk");
		}
		else
		{
			velocity.x = 0;
			animation.play("Idle");
		}
			
            
		if ((isTouching(FlxObject.DOWN)) && (jump))
			velocity.y -= jumpSpeed;		
    }
   
    override public function update (elapsed : Float)
    {
        Movement();           
        Input();
		super.update(elapsed);
    }
	
	
}
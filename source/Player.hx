package;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;


class Player extends FlxSprite
{
	//Movement
    private var speed : Float = 100;
	private var speedMax: Float = 300;
    private var jumpSpeed : Float = 500;
    private var gravity : Float = 1000;
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
		
		
		animation.add("Idle", [0, 1, 2, 3], 2);
		animation.add("Walk", [12, 13, 14], 10);
		//animation.add("Jump", [],);
		animation.add("Hurt", [6]);
		
		
		drag.set(1500, 1000);
		acceleration.y = gravity;
	}
	
	override public function update (elapsed : Float)
    { 
		Input();
		Movement();     
		super.update(elapsed);
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
		trace(velocity.x);
		
        if (left)
		{
			//if (facing == FlxObject.RIGHT)
			//	acceleration.x = 0;
			
			acceleration.x -= speed;
			facing = FlxObject.LEFT;
			animation.play("Walk");
		}   
        else if (right)
		{
			/*
			if (facing == FlxObject.LEFT)
			{
				acceleration.x = 0;
				trace(facing);
			}
			*/	
				
			/*
			if (acceleration.x < 0)
			{
				acceleration.x = 0;
				trace(acceleration.x);
			}
			*/
				
				
			acceleration.x += speed;
			facing = FlxObject.RIGHT;
			animation.play("Walk");
		}
		else
		{
			//velocity.x = 0;
			acceleration.x = 0;
			animation.play("Idle");
		}
		
		if (acceleration.x <= -speedMax)
			acceleration.x = -speedMax;
		
		if (acceleration.x >= speedMax)
			acceleration.x = speedMax;
		
            
		if ((isTouching(FlxObject.DOWN)) && (jump))
			Jump();
    }
	
	private function Jump()
	{
		velocity.y -= jumpSpeed;	
	}
	
	private function Hurt()
	{
		animation.play("Hurt");
	}
}
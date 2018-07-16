package;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;


class Player extends FlxSprite
{
	//Movement
    private var speed : Float = 350;
	private var rotationSpeed = 3;
    private var jumpSpeed : Float = 2500;
    private var gravity : Float = 1500;
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
		animation.add("GoinUp", [18], 1, true);
		animation.add("GoinDown", [19], 1, true);
		animation.add("Hurt", [6]);
		
		maxVelocity.x = 550;
		maxVelocity.y = 550;
		drag.set(1000, 1000);
		acceleration.y = gravity;
	}
	
	override public function update (elapsed : Float)
    { 
		Input();
		Movement();  
		InAir();
		super.update(elapsed);
    }
	
	private function Input () : Void
    {
        left = FlxG.keys.anyPressed([LEFT, A]);
        right = FlxG.keys.anyPressed([RIGHT, D]);
        jump = FlxG.keys.anyJustPressed([SPACE, L]);    
        if (left && right)
			left = right = false;
    }
	
	private function Movement () : Void
    {
        if (left)
		{
			if (facing == FlxObject.RIGHT)
				velocity.x /= rotationSpeed;
				
			acceleration.x -= speed;
			if (acceleration.x < maxVelocity.x)
				acceleration.x = -maxVelocity.x;
				
			facing = FlxObject.LEFT;
			animation.play("Walk");
		}   
        if (right)
		{
			if (facing == FlxObject.LEFT)
				velocity.x /= rotationSpeed;
			
			acceleration.x += speed;
			if (acceleration.x > maxVelocity.x)
				acceleration.x = maxVelocity.x;
			
			facing = FlxObject.RIGHT;
			animation.play("Walk");		
		}
		
		if (!left && !right)
		{
			acceleration.x = 0;
			animation.play("Idle");
		}
	      
		if ((isTouching(FlxObject.DOWN)) && (jump))
			Jump();
    }
	
	private function Jump()
	{
		velocity.y -= jumpSpeed;
	}
	
	private function InAir()
	{
		if (velocity.y < 0 )
			animation.play("GoinUp");
		if (velocity.y > 0 )
			animation.play("GoinDown");
	}
	
	private function Hurt()
	{
		animation.play("Hurt");
	}
}
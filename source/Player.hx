package;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
//import flixel.addons.display.FlxExtendedSprite.MouseCallback;
import flixel.addons.util.FlxFSM;


class Player extends FlxSprite
{
	public var gravity : Int = 1000;
    public var speed : Int = 350;
	public var maxSpeed : Int = 600;
	public var deceleration : Float = 0.9;
	public var rotationSpeed : Int = 3;
    public var jumpSpeed : Int = 400;
	private var pressedLeft : Bool = false;
	private var pressedRight : Bool = false;

	private var fsm:FlxFSM<Player>;
	
	
	public function new (?X : Float = 0, ?Y : Float = 0)
	{
		super(X, Y);
		loadGraphic("assets/images/player.png", true, 16, 16); 
		scale.set(3, 3);
		updateHitbox();
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		animation.add("Idle", [0, 1, 2, 3], 2);
		animation.add("Hurt", [6]);
		animation.add("Walk", [12, 13, 14], 10);
		animation.add("GoinUp", [18], 0);
		animation.add("GoinDown", [19], 0);
		animation.add("Punch", [27, 26, 25, 24, 28], 10, false);
		
		fsm = new FlxFSM<Player>(this);
	
		fsm.transitions
			.add(Idle, Jump, Conditions.jump)
			.add(Jump, Idle, Conditions.grounded)
			.add(Idle, Punch, Conditions.punch)
			.add(Punch, Idle, Conditions.animationFinished)
			.add(Jump, GroundPound, Conditions.groundSlam)
			.add(GroundPound, GroundPoundFinish, Conditions.grounded)
			.add(GroundPoundFinish, Idle, Conditions.animationFinished)
			.start(Idle);
		
		acceleration.y = gravity;
		maxVelocity.set(maxSpeed, gravity);
	}
	
	override public function update (elapsed : Float)
    {
		fsm.update(elapsed);
		super.update(elapsed);
    }
	
	public function input()
	{
		pressedLeft = FlxG.keys.anyPressed([LEFT, A]);
		pressedRight = FlxG.keys.anyPressed([RIGHT, D]);
		
		if (pressedLeft && pressedRight)
			pressedLeft = pressedRight = null;
	}
	
	public function movementGround()
	{
		if (isMoving())
		{
			if (pressedLeft && facing == FlxObject.RIGHT)
			{
				turn();
				facing = FlxObject.LEFT;
			}
			if (pressedRight && facing == FlxObject.LEFT)
			{
				turn();
				facing = FlxObject.RIGHT;
			}
			accelerate();
		}
		else
			decelerate();
	}
	
	public function isMoving() : Bool
	{
		return pressedLeft || pressedRight;
	}
	
	public function isFalling() : Bool
	{
		return velocity.y > (0 + jumpSpeed / 2);
	}
	
	private function accelerate()
	{
		if (facing == FlxObject.LEFT)
			acceleration.x -= speed;
		else
			acceleration.x += speed;
	}
	
	private function decelerate()
	{
		velocity.x *= deceleration;
	}
	
	private function turn()
	{
		velocity.x /= rotationSpeed;
	}
}

class Conditions
{
	public static function jump(Owner:FlxSprite):Bool
	{
		return FlxG.keys.anyJustPressed([SPACE, W]) && Owner.isTouching(FlxObject.DOWN);
	}
	
	public static function grounded(Owner:FlxSprite):Bool
	{
		return Owner.isTouching(FlxObject.DOWN);
	}
	
	public static function punch(Owner:FlxSprite):Bool
	{
		return FlxG.keys.anyJustPressed([K]) && Owner.isTouching(FlxObject.DOWN);
	}
	
	public static function groundSlam(Owner:FlxSprite):Bool
	{
		return FlxG.keys.anyJustPressed([DOWN, S]) && !Owner.isTouching(FlxObject.DOWN);
	}
	
	public static function animationFinished(Owner:FlxSprite):Bool
	{
		return Owner.animation.finished;
	}
}	
	
class Idle extends FlxFSMState<Player>
{	
	override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.animation.play("Idle");
	}
	
	override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.acceleration.x = 0;
		owner.input();
		owner.movementGround();
		if (owner.isMoving())
			owner.animation.play("Walk");
		else
			owner.animation.play("Idle");
	}	
}

class Jump extends FlxFSMState<Player>
{
	override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.animation.play("GoinUp");
		owner.velocity.y = -owner.jumpSpeed;
	}
	
	override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.acceleration.x = 0;
		owner.input();
		owner.movementGround();
		
		if (owner.isFalling())
			owner.animation.play("GoinDown");
	}
}

class Punch extends FlxFSMState<Player>
{
	override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.animation.play("Punch");
		owner.velocity.x = 0;
		owner.acceleration.x = 0;
	}
}

class SuperJump extends Jump
{
	override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.animation.play("GoinUp");
		owner.velocity.y = -300;
	}
}

class GroundPound extends FlxFSMState<Player>
{
	var _ticks:Float;
	
	override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.animation.play("pound");
		owner.velocity.x = 0;
		owner.acceleration.x = 0;
		_ticks = 0;
	}
		
	override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
	{
		_ticks++;
		if (_ticks < 15)
		{
			owner.velocity.y = 0;
		}
		else
		{
			owner.velocity.y = owner.gravity;
		}
	}
}

class GroundPoundFinish extends FlxFSMState<Player>
{
	override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.animation.play("landing");
		FlxG.camera.shake(0.025, 0.25);
		owner.velocity.x = 0;
		owner.acceleration.x = 0;
	}
}

	

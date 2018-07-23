package;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.util.FlxFSM;


class Player extends FlxSprite
{
	public static inline var gravity : Int = 1000;
    public static inline var speed : Int = 350;
	public static inline var maxSpeed : Int = 600;
	public static inline var deceleration : Float = 0.9;
	public static inline var rotationSpeed : Int = 3;
    public static inline var jumpSpeed : Int = 400;
	private var fsm:FlxFSM<FlxSprite>;
	
	
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
		
		fsm = new FlxFSM<FlxSprite>(this);
		
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
	
class Idle extends FlxFSMState<FlxSprite>
{
	private var pressedLeft:Bool = false;
	private var pressedRight:Bool = false;
	
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("Idle");
	}
	
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.acceleration.x = 0;
		input();
		
		if (pressedLeft || pressedRight)
		{
			moving(owner);	
			owner.animation.play("Walk");
		}
		else
		{
			decelerate(owner);
			owner.animation.play("Idle");
		}		
	}
	
	private function input()
	{
		pressedLeft = FlxG.keys.anyPressed([LEFT, A]);
		pressedRight = FlxG.keys.anyPressed([RIGHT, D]);
	}
	
	private function moving(owner:FlxSprite)
	{
		if (pressedLeft && pressedRight)
		{
			decelerate(owner);
			return;
		}
		else
		{
			if (pressedLeft && owner.facing == FlxObject.RIGHT)
			{
				turn(owner);
				owner.facing = FlxObject.LEFT;
			}
			if (pressedRight && owner.facing == FlxObject.LEFT)
			{
				turn(owner);
				owner.facing = FlxObject.RIGHT;
			}
			accelerate(owner);
		}
	}
	
	private function accelerate(owner:FlxSprite)
	{
		if (owner.facing == FlxObject.LEFT)
			owner.acceleration.x -= Player.speed;
		else
			owner.acceleration.x += Player.speed;
	}
	
	private function decelerate(owner:FlxSprite)
	{
		owner.velocity.x *= Player.deceleration;
	}
	
	private function turn(owner:FlxSprite)
	{
		owner.velocity.x /= Player.rotationSpeed;
	}
}

class Jump extends FlxFSMState<FlxSprite>
{
	private var pressedLeft:Bool = false;
	private var pressedRight:Bool = false;
	
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("GoinUp");
		owner.velocity.y = -Player.jumpSpeed;
	}
	
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.acceleration.x = 0;
		input();
		
		if (pressedLeft || pressedRight)	
			moving(owner);	
	}
	
	private function input()
	{
		pressedLeft = FlxG.keys.anyPressed([LEFT, A]);
		pressedRight = FlxG.keys.anyPressed([RIGHT, D]);
	}
	
	private function moving(owner:FlxSprite)
	{
		if (pressedLeft && pressedRight)
		{
			decelerate(owner);
			return;
		}
		else
		{
			if (pressedLeft && owner.facing == FlxObject.RIGHT)
			{
				turn(owner);
				owner.facing = FlxObject.LEFT;
			}
			if (pressedRight && owner.facing == FlxObject.LEFT)
			{
				turn(owner);
				owner.facing = FlxObject.RIGHT;
			}
			accelerate(owner);
		}
	}
	
	private function accelerate(owner:FlxSprite)
	{
		if (owner.facing == FlxObject.LEFT)
			owner.acceleration.x -= Player.speed;
		else
			owner.acceleration.x += Player.speed;
	}
	
	private function decelerate(owner:FlxSprite)
	{
		owner.velocity.x *= Player.deceleration;
	}
	
	private function turn(owner:FlxSprite)
	{
		owner.velocity.x /= Player.rotationSpeed;
	}
}

class Punch extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("Punch");
		owner.velocity.x = 0;
		owner.acceleration.x = 0;
	}
}

class SuperJump extends Jump
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("GoinUp");
		owner.velocity.y = -300;
	}
}

class GroundPound extends FlxFSMState<FlxSprite>
{
	var _ticks:Float;
	
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("pound");
		owner.velocity.x = 0;
		owner.acceleration.x = 0;
		_ticks = 0;
	}
		
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		_ticks++;
		if (_ticks < 15)
		{
			owner.velocity.y = 0;
		}
		else
		{
			owner.velocity.y = Player.gravity;
		}
	}
}

class GroundPoundFinish extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("landing");
		FlxG.camera.shake(0.025, 0.25);
		owner.velocity.x = 0;
		owner.acceleration.x = 0;
	}
}

	

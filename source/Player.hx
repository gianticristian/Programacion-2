package;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.util.FlxFSM;


class Player extends FlxSprite
{
	public static inline var gravity:Float = 1000;
    public static inline var speed : Float = 350;
	public static inline var maxSpeed : Float = 600;
	public static inline var rotationSpeed = 3;
    public static inline var jumpSpeed : Float = 400;

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
		animation.add("Punch", [24, 25, 26, 27, 28], 10, false);
		
		fsm = new FlxFSM<FlxSprite>(this);
		
		fsm.transitions
			.add(Idle, Jump, Conditions.jump)
			.add(Jump, Idle, Conditions.grounded)
			.add(Jump, GroundPound, Conditions.groundSlam)
			.add(GroundPound, GroundPoundFinish, Conditions.grounded)
			.add(GroundPoundFinish, Idle, Conditions.animationFinished)
			.start(Idle);
		
		//maxVelocity.x = 550;
		//maxVelocity.y = 550;
		//drag.set(1000, 1000);
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
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("Idle");
	}
	
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.acceleration.x = 0;
		
		if (FlxG.keys.anyPressed([LEFT, A]) || FlxG.keys.anyPressed([RIGHT, D]))
		{
			if (FlxG.keys.anyPressed([LEFT, A]) && FlxG.keys.anyPressed([RIGHT, D]))
				return;
			
			owner.facing = FlxG.keys.anyPressed([LEFT, A]) ? FlxObject.LEFT : FlxObject.RIGHT;
			owner.animation.play("Walk");
			owner.acceleration.x = FlxG.keys.anyPressed([LEFT, A]) ? -300 : 300;
		}
		else
		{
			owner.animation.play("Idle");
			owner.velocity.x *= 0.9;
		}
	}
}

class Jump extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("GoinUp");
		owner.velocity.y = -Player.jumpSpeed;
	}
	
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.acceleration.x = 0;
		if (FlxG.keys.anyPressed([LEFT, A]) || FlxG.keys.anyPressed([RIGHT, D]))	
		{
			owner.acceleration.x = FlxG.keys.anyPressed([LEFT, A]) ? -300 : 300;
		}
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

	

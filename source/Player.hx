package;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.util.FlxFSM;
import flixel.system.FlxSound;
import flixel.group.FlxGroup.FlxTypedGroup;


class Player extends FlxSprite
{
	public var gravity : Int = 500;
    public var speed : Int = 200;
	public var maxSpeed : Int = 250;
	public var deceleration : Float = 0.9;
	public var attackDeceleration : Float = 0.1;
	public var attackAcceleration : Float = 1.1;
	public var rotationSpeed : Int = 3;
    public var jumpSpeed : Int = 220;
	public var pressedLeft : Bool = false;
	public var pressedRight : Bool = false;
	public var pressedJump : Bool = false;
	public var pressedAttack : Bool = false;
	public var attackPoint : Float = 0;
	public var money : Int = 0;
	public var beingHurt : Bool = false;
	
	public var jumpSound : FlxSound;
	public var attackSound : FlxSound;
	
	private var punchs : FlxTypedGroup<Punch>;
	private var kicks : FlxTypedGroup<Kick>;
	private var fsm : FlxFSM<Player>;

	
	
	public function new (?X : Float = 0, ?Y : Float = 0, poolPunch : FlxTypedGroup<Punch>, poolKick : FlxTypedGroup<Kick>)
	{
		super(X, Y);
		health = 10;
		punchs = poolPunch;
		kicks = poolKick;
		loadGraphic("assets/images/Player.png", true, 16, 16); 
		updateHitbox();
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		jumpSound = FlxG.sound.load("assets/sounds/Jump.wav");
		jumpSound.volume = 0.1;
		attackSound = FlxG.sound.load("assets/sounds/Attack.wav");
		attackSound.volume = 0.1;
		
		animation.add("Idle", [0, 1, 2, 3], 2);
		animation.add("Hurt", [4], 2, false);
		animation.add("Walk", [6, 7, 8, 9, 10, 11], 10);
		animation.add("GoinUp", [12], 0);
		animation.add("GoinDown", [13], 0);
		animation.add("Landing", [16], 0);
		animation.add("Kick", [15], 6, false);
		animation.add("Punch", [22, 23, 24], 12, false);
		animation.add("Scale", [25, 26, 27]);
			
		fsm = new FlxFSM<Player>(this);
	
		fsm.transitions
			.add(Idle, Jump, Conditions.jump)
			.add(Jump, Idle, Conditions.grounded)
			
			.add(Idle, Attack, Conditions.attack)
			.add(Attack, Idle, Conditions.animationFinished)
			
			.add(Jump, Attack, Conditions.attack)
			.add(Attack, Jump, Conditions.animationFinished)
			
			.add(Idle, Hurt, Conditions.hurt)
			.add(Hurt, Idle, Conditions.animationFinished)
			
			.add(Jump, Hurt, Conditions.hurt)
			.add(Hurt, Jump, Conditions.animationFinished)
			
			.add(Jump, GroundPound, Conditions.groundSlam)
			.add(GroundPound, GroundPoundFinish, Conditions.grounded)
			.add(GroundPoundFinish, Idle, Conditions.animationFinished)
			.start(Idle);
		
		acceleration.y = gravity;
		maxVelocity.set(maxSpeed, gravity);
		attackPoint += width; 
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
			pressedLeft = pressedRight = false;
		
		pressedJump = FlxG.keys.anyJustPressed([SPACE, W]);
		pressedAttack = FlxG.keys.anyJustPressed([K]);
		
	}
	
	public function movement()
	{
		if (isMoving())
		{
			if (pressedLeft && facing == FlxObject.RIGHT)
			{
				turn();
				facing = FlxObject.LEFT;
				attackPoint *= -1;
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
	
	public function decelerate()
	{
		velocity.x *= deceleration;
	}
	
	public function attack()
	{
		attackSound.play();
		if (isTouching(FlxObject.DOWN))
		{
			animation.play("Punch");
			acceleration.x = 0;
			velocity.x *= attackDeceleration;
			var punch = punchs.recycle(Punch);
			punch.reset(x, y);
			punch.setDirection(facing);			
		}
		else
		{
			animation.play("Kick");
			var kick = kicks.recycle(Kick);
			kick.reset(x, y);
			kick.setDirection(facing);	
		}
	}
	
	private function turn()
	{
		velocity.x /= rotationSpeed;
	}
	
	override public function hurt(damage:Float) : Void 
	{
		if (beingHurt)
			return;
			
		beingHurt = true;
		super.hurt(damage);
	}
}

class Conditions
{
	public static function jump(owner:Player):Bool
	{
		return owner.pressedJump && owner.isTouching(FlxObject.DOWN);
	}
	
	public static function grounded(owner:Player):Bool
	{
		return owner.isTouching(FlxObject.DOWN);
	}
	
	public static function attack(owner:Player):Bool
	{
		return owner.pressedAttack;
	}
	
	public static function hurt(owner:Player):Bool
	{
		return owner.beingHurt;
	}
	
	public static function groundSlam(owner:Player):Bool
	{
		return FlxG.keys.anyJustPressed([DOWN, S]) && !owner.isTouching(FlxObject.DOWN);
	}
	
	public static function animationFinished(owner:Player):Bool
	{
		return owner.animation.finished;
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
		owner.movement();
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
		owner.jumpSound.play();
	}
	
	override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.acceleration.x = 0;
		owner.input();
		owner.movement();
		
		if (owner.isFalling())
			owner.animation.play("GoinDown");
	}
	
	override public function exit(owner:Player):Void
	{
		owner.animation.play("Landing");
	}
}

class Attack extends FlxFSMState<Player>
{
	override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.attack();		
	}
}

class Hurt extends FlxFSMState<Player>
{
	override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.animation.play("Hurt");
	}
	
	override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.decelerate();
	}
	
	override public function exit(owner:Player):Void
	{
		owner.beingHurt = false;
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

	

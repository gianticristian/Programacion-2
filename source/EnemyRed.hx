package;


class EnemyRed extends Enemy 
{
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic("assets/images/Enemy Red.png", true, 16, 16);
		updateHitbox();

		animation.add("Walk", [0, 1, 2, 3, 4, 5], 6);
		animation.add("Hurt", [7], 5, false);
		animation.add("Die", [6], 1, false);
		
		lookRange = 50;
		health = 2;
		damage = 2;
		speed = 20;
		maxSpeed = 50; 
		acceleration.set(-speed, 300);
		maxVelocity.set(maxSpeed, 300);
		
		animation.play("Walk");
	}
	
}
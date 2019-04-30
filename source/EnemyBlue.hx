package;


class EnemyBlue extends Enemy 
{
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic("assets/images/Enemy Blue.png", true, 16, 16);
		updateHitbox();

		animation.add("Walk", [6, 7, 8, 9, 10, 11], 6);
		animation.add("Hurt", [13], 5, false);
		animation.add("Die", [12], 1, false);
		
		lookRange = 125;
		health = 3;
		damage = 1;
		speed = 10;
		maxSpeed = 30; 
		acceleration.set(-speed, 300);
		maxVelocity.set(maxSpeed, 300);
		
		animation.play("Walk");
	}
}
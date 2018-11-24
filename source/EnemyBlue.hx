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
		
		health = 3;
		damage = 1;
		acceleration.set(-30, 300);
		maxVelocity.set(30, 300);
		
		animation.play("Walk");
	}
}
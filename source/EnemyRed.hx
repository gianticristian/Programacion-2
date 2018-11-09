package;


class EnemyRed extends Enemy 
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic("assets/images/Enemy Red.png", true, 16, 16);
		updateHitbox();

		animation.add("Walk", [0, 1, 2, 3, 4, 5], 6);
		animation.add("Hurt", [6, 7], 5, false);
		
		health = 2;
		damage = 3;
		acceleration.set(-30, 400);
		maxVelocity.set(30, 400);
		
		animation.play("Walk");
	}
	
}
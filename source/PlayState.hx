package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import Player;


class PlayState extends FlxState
{
	static public var instance : PlayState;

	private var ui : UI;
	public var player:Player;
	// Punch pool objects
	public var poolPunch : FlxTypedGroup<Punch>;
	public var poolPunchSize : Int = 10;
	// Kick pool objects
	public var poolKick : FlxTypedGroup<Kick>;
	public var poolKickSize : Int = 10;
	
	public var level:TiledLevel;
	public var coins:FlxGroup;
	public var enemies:FlxTypedGroup<Enemy>;
	//public var floor:FlxObject;
	public var edges:FlxTypedGroup<FlxObject>;
	public var exit:FlxSprite;
	public var cameraGame:FlxCamera;
	public var cameraUI:FlxCamera;
	
	override public function create () : Void 
	{
		PlayState.instance = this;
		
		//FlxG.mouse.visible = false;
		
		createPool();
		coins = new FlxGroup();
		enemies = new FlxTypedGroup<Enemy>();
		edges = new FlxTypedGroup<FlxObject>();
		level = new TiledLevel("assets/tiled/level_1.tmx", this);

		// Add backgrounds
		//add(level.backgroundLayer);

		add(coins);
		add(edges);
		// Add static images
		add(level.imagesLayer);
		// Load player objects
		add(level.objectsLayer);
		// Add foreground tiles after adding level objects, so these tiles render on top of player
		add(level.foregroundTiles);
		
		add(enemies);
		add(player);
		add(poolPunch);
		add(poolKick);
		
		// Level camera
		cameraGame = new FlxCamera();
		FlxG.cameras.reset(cameraGame);
		FlxCamera.defaultCameras = [cameraGame];
		cameraGame.zoom = 3;
		cameraGame.bgColor = FlxColor.WHITE;
		cameraGame.follow(player, FlxCameraFollowStyle.PLATFORMER, 2);
		
		// UI camera
		cameraUI = new FlxCamera();
		FlxG.cameras.add(cameraUI);
		cameraUI.bgColor = FlxColor.TRANSPARENT;
		
		// UI class		
		ui = new UI(0, 0);
		ui.camera = cameraUI;		
		add(ui);
		ui.updateMoney(player.money);
		ui.updateHealth(player.health);
		
		super.create();
	}
	
	override public function destroy () : Void 
	{
		super.destroy();
	}
	
	override public function update (elapsed : Float) : Void
	{
		super.update(elapsed);
		level.collideWithLevel(player);		
		FlxG.overlap(player, coins, playerTouchCoin);
		FlxG.overlap(player, enemies, playerTouchEnemy);
		FlxG.overlap(enemies, poolPunch, enemyTouchPunch);
		FlxG.overlap(enemies, poolKick, enemyTouchKick);
		FlxG.collide(edges, enemies, enemyTouchEdge);
		
		for (enemy in enemies)
			level.collideWithLevel(enemy);	
	}
	
	private function enemyTouchPunch (_enemy : Enemy, _punch : Punch) : Void
	{
		if (_enemy.alive && _punch.alive)
		{
			_enemy.Hurt(1);
			_punch.kill();
		}
	}
	
	private function enemyTouchKick (_enemy : Enemy, _kick : Kick) : Void
	{
		if (_enemy.alive && _kick.alive)
		{
			_enemy.Hurt(1);
			_kick.kill();
		}
	}
	
	private function enemyTouchEdge (_edge : FlxObject, _enemy : Enemy) : Void
	{
		if (_enemy.alive)
			_enemy.Turn();
	}
	
	private function playerTouchCoin (_player : Player, _coin : Coin) : Void
	{
		if (_player.alive && _coin.alive)
		{
			_player.money += _coin.value;
			ui.updateMoney(_player.money);
			_coin.picked();		
		}
	}
	
	public function playerTouchEnemy(_player : Player, _enemy : Enemy) : Void
	{
		if (_player.alive && _enemy.alive)
		{
			_player.hurt(_enemy.damage);
			ui.updateHealth(_player.health);
			_enemy.hurt(1);
		}
	}
	
	private function createPool()
	{
		poolPunch = new FlxTypedGroup<Punch>(poolPunchSize);
		for (i in 0...poolPunchSize) 
		{
			var punch = new Punch();
			punch.kill();
			poolPunch.add(punch);
		}
		
		poolKick = new FlxTypedGroup<Kick>(poolKickSize);
		for (i in 0...poolKickSize) 
		{
			var kick = new Kick();
			kick.kill();
			poolKick.add(kick);
		}
	}
	
	public function PlayerDie()
	{
		player.Spawn();
		ui.updateHealth(player.health);
	}
}
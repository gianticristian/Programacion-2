package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.group.FlxGroup;
//import flixel.text.FlxText;
import flixel.util.FlxColor;
import Player;


class PlayState extends FlxState
{
	private var ui : UI;
	public var player:Player;
	// Punch pool objects
	public var poolPunch : FlxTypedGroup<Punch>;
	public var poolPunchSize : Int = 20;
	// Kick pool objects
	public var poolKick : FlxTypedGroup<Kick>;
	public var poolKickSize : Int = 10;
	
	
	public var level:TiledLevel;
	public var coins:FlxGroup;
	public var floor:FlxObject;
	public var exit:FlxSprite;
	public var cameraGame:FlxCamera;
	public var cameraUI:FlxCamera;
	
	override public function create () : Void 
	{
		//FlxG.mouse.visible = false;
		createPool();
		
		player = new Player(0, 0, poolPunch, poolKick);
        add(player);		
		
		coins = new FlxGroup();
		level = new TiledLevel("assets/tiled/level_1.tmx", this);
		// Add backgrounds
		//add(level.backgroundLayer);
		add(coins);
		// Add static images
		add(level.imagesLayer);
		// Load player objects
		add(level.objectsLayer);
		// Add foreground tiles after adding level objects, so these tiles render on top of player
		add(level.foregroundTiles);
		
			
		
		// Level camera
		cameraGame = new FlxCamera();
		FlxG.cameras.reset(cameraGame);
		FlxCamera.defaultCameras = [cameraGame];
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
	
	
	private function createPool()
	{
		poolPunch = new FlxTypedGroup<Punch>(poolPunchSize);
		for (i in 0...poolPunchSize) 
		{
			var punch = new Punch();
			punch.kill();
			poolPunch.add(punch);
		}
		add(poolPunch);
		
		poolKick = new FlxTypedGroup<Kick>(poolKickSize);
		for (i in 0...poolKickSize) 
		{
			var kick = new Kick();
			kick.kill();
			poolKick.add(kick);
		}
		add(poolKick);
	}
}
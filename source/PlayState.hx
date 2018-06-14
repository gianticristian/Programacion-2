package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import Player;


class PlayState extends FlxState
{
	public var player:Player;
	
	public var level:TiledLevel;
	public var coins:FlxGroup;
	public var floor:FlxObject;
	public var exit:FlxSprite;
	public var cameraGame:FlxCamera;
	public var cameraUI:FlxCamera;
	
	override public function create () : Void 
	{
		player = new Player(0, 0);
        add(player);
		//FlxG.camera.bgColor = FlxColor.WHITE;
		//FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER, 2);			
		
		coins = new FlxGroup();
		level = new TiledLevel("assets/tiled/level_1.tmx", this);
		// Add backgrounds
		add(level.backgroundLayer);
		// Draw coins first
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
		var ui = new UI(0, 0);
		ui.camera = cameraUI;		
		add(ui);
		
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
	}
}
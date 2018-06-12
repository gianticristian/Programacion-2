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
	public var score:FlxText;
	public var status:FlxText;
	public var coins:FlxGroup;
	public var floor:FlxObject;
	public var exit:FlxSprite;
	
	// Debug
	public var player_acceleration:FlxText;
	public var player_velocity:FlxText;
	
	
	override public function create () : Void 
	{
        FlxG.camera.bgColor = FlxColor.WHITE;
		player = new Player(0, 0);
        add(player);
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER, 2);			
		
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
		
		
		player_acceleration = new FlxText(500);
		player_acceleration.setFormat("assets/fonts/monofonto.ttf", 20, FlxColor.BLACK, FlxTextAlign.CENTER);
		player_acceleration.antialiasing = true;
		add(player_acceleration);
		
		player_velocity = new FlxText(700);
		player_velocity.setFormat("assets/fonts/monofonto.ttf", 20, FlxColor.BLACK, FlxTextAlign.CENTER);
		player_velocity.antialiasing = true;
		add(player_velocity);
		
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
		
		
		player_acceleration.text = "Acceleration: " + player.acceleration.x;
		player_acceleration.x = player.x - 100;
		player_velocity.text = "Velocity: " + player.velocity.x;
		player_velocity.x = player.x + 100;
	}
}
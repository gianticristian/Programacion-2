package;

import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class UI extends FlxSpriteGroup 
{
	private var levelText:FlxText;
	private var healthText:FlxText;
	
	public function new(X:Float=0, Y:Float=0, MaxSize:Int=0) 
	{
		super(X, Y, MaxSize);
		
		levelText = new FlxText(20, 10, 0, "Level: ");
		levelText.setFormat("assets/fonts/monofonto.ttf", 14, FlxColor.BLACK);
		levelText.antialiasing = true;
		add(levelText);
		
		healthText = new FlxText(camera.width - 100 , 10, 0, "Health: ");
		healthText.setFormat("assets/fonts/monofonto.ttf", 14, FlxColor.BLACK);
		healthText.antialiasing = true;
		add(healthText);
	}
	
	public function updateHealth(value:Float)
	{
		healthText.text = "Health: " + value;
	}
	
	public function updateLevel(value:Float)
	{
		levelText.text = "Level: " + value;
	}
	
	
	
	
}
package;

import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class UI extends FlxSpriteGroup 
{
	private var moneyText : FlxText;
	private var moneyValue : Int = 0;
	
	private var healthText : FlxText;
	
	
	public function new(X:Float=0, Y:Float=0, MaxSize:Int=0) 
	{
		super(X, Y, MaxSize);
		
		moneyText = new FlxText(20, 10, 0, "Money: ");
		moneyText.setFormat("assets/fonts/monofonto.ttf", 14, FlxColor.BLACK);
		moneyText.antialiasing = true;
		add(moneyText);
		
		healthText = new FlxText(camera.width - 100 , 10, 0, "Health: ");
		healthText.setFormat("assets/fonts/monofonto.ttf", 14, FlxColor.BLACK);
		healthText.antialiasing = true;
		add(healthText);
	}
	
	public function updateHealth(value:Float)
	{
		healthText.text = "Health: " + value;
	}
	
	public function addMoney(value : Int)
	{
		moneyValue += value;
		moneyText.text = "Money: " + moneyValue;
	}
	
	public function updateMoney(player : Player)
	{
		moneyText.text = "Money: " + player.money;
	}
}
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;


class MenuState extends FlxState
{
	private var title : FlxText;
	private var version : FlxText;
	private var start : FlxText;
	private var credits : FlxText;
	
	
	private var pointer: FlxSprite; 
	
	override public function create () : Void
	{
		super.create();
		camera.bgColor.setRGB(255,77,77);
		// Title
		title = new FlxText(0, 100, FlxG.width);
		title.text = "Titulo Principal";
		title.setFormat("assets/fonts/Minercraftory.ttf", 41, FlxColor.WHITE, FlxTextAlign.CENTER);
		title.antialiasing = true;
		add(title);
		// Start
		start = new FlxText();
		start.text = "Start";
		start.setFormat("assets/fonts/Minercraftory.ttf", 40, FlxColor.WHITE, FlxTextAlign.CENTER);
		start.setPosition(FlxG.width / 2 - start.width / 2, FlxG.height / 2);
		start.antialiasing = true;
        add(start);
		// Credits
		credits = new FlxText();
		credits.text = "Credits";
		credits.setFormat("assets/fonts/Minercraftory.ttf", 40, FlxColor.WHITE, FlxTextAlign.CENTER);
		credits.setPosition(FlxG.width / 2 - credits.width / 2, FlxG.height / 1.5);
		credits.antialiasing = true;
        add(credits);		
		// Pointer
		pointer = new FlxSprite();
		pointer.makeGraphic(300, 50, FlxColor.TRANSPARENT, true);
		pointer.setPosition(start.x - start.width / 4, start.y); 
		pointer.drawRect(0, 0, 300, 3, FlxColor.WHITE);
		pointer.drawRect(0, 47, 300, 3, FlxColor.WHITE);
		pointer.drawRect(0, 0, 3, 300, FlxColor.WHITE);
		pointer.drawRect(297, 0, 3, 50, FlxColor.WHITE);
		add(pointer);
		
		
	}

	override public function update (elapsed : Float) : Void
	{
		if (FlxG.keys.anyJustPressed([UP, W]))
		{
			pointer.y -= 10;
		}
		if (FlxG.keys.anyJustPressed([DOWN, S]))
		{
			pointer.y += 10;
		}
		
		super.update(elapsed);
	}
	
	private function ClickStart () 
	{
		FlxG.camera.fade(FlxColor.BLACK, 2.0, false, ChangeScene.bind("Start"));
	}
	
	private function ClickCredits () 
	{
		FlxG.camera.fade(FlxColor.BLACK, 2.0, false, ChangeScene.bind("Credits"));
	}
	
	private function ChangeScene (nextScene : String) : Void
	{
		switch (nextScene) 
		{
			case "Start":
				FlxG.switchState(new PlayState());
			case "Credits":
				FlxG.switchState(new Credits());
			default:
				trace("Scene not found");
		}
	}
	

	
}
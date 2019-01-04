package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

import flixel.addons.ui.FlxUIButton;

class MenuState extends FlxState
{
	private var title : FlxText;
	private var version : FlxText;
	private var start : FlxButton;
	private var credits : FlxButton;
	
	private var but : FlxUIButton;
	
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
		start = new FlxButton(0, 0, "", ClickStart);
		start.loadGraphic("assets/images/Start.png", true, 102, 41);
		start.x = FlxG.width / 2 - start.width / 2;
		start.y = FlxG.height / 2;
		start.antialiasing = true;
        add(start);
		// Credits
		credits = new FlxButton(0, 0, "", ClickCredits);
		credits.loadGraphic("assets/images/Credits.png", true, 143, 41);
		credits.x = FlxG.width / 2 - credits.width / 2;
		credits.y = FlxG.height / 1.5;
		credits.antialiasing = true;
        add(credits);
		
		
		
		// But
		but = new FlxUIButton(100 , 100, "But");
		but.setLabelFormat("blue highway linocut.ttf", 16);
		
		
		
		add(but);
		
		
	}

	override public function update (elapsed : Float) : Void
	{
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
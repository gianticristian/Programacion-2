package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	private var title : FlxText;
	private var version : FlxText;
	private var start : FlxButton;
	private var credits : FlxButton;
	
	override public function create () : Void
	{
		super.create();
		// Title
		title = new FlxText(0, 100, FlxG.width);
		title.text = "Titulo Principal";
		title.setFormat("assets/fonts/blue highway linocut.ttf", 41, FlxColor.WHITE, FlxTextAlign.CENTER);
		title.antialiasing = true;
		add(title);
		// Start
		start = new FlxButton(150, 150, "Start", ClickStart);
		start.x = FlxG.width / 2 - start.width / 2;
		start.y = FlxG.height / 2;
		start.antialiasing = true;
        add(start);
		// Credits
		credits = new FlxButton(150, 150, "Credits", ClickCredits);
		credits.x = FlxG.width / 2 - credits.width / 2;
		credits.y = FlxG.height / 1.5;
		credits.antialiasing = true;
        add(credits);
		
		
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
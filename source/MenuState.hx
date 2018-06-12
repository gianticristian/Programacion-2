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
	
	override public function create () : Void
	{
		super.create();
		// Texto Titulo principal
		title = new FlxText(0, 100, FlxG.width);
		title.text = "Titulo Principal";
		title.setFormat("assets/fonts/blue highway linocut.ttf", 41, FlxColor.WHITE, FlxTextAlign.CENTER);
		title.antialiasing = true;
		add(title);
		// Boton Start
		start = new FlxButton(150, 150, "Start", ClickStart);
		start.x = 	FlxG.width / 2 - start.width / 2;
		start.y = 	FlxG.height / 2;
		start.antialiasing = true;
        add(start);
		
		
	}

	override public function update (elapsed : Float) : Void
	{
		super.update(elapsed);
	}
	
	private function ClickStart () 
	{
		FlxG.camera.fade(FlxColor.BLACK, 2.0, false, StartPlaying);			// Oscurece la pantalla de a poco
		trace("ClickStart");
	}
	
	private function StartPlaying () 
	{
		FlxG.switchState(new PlayState());								// Carga el primer escenario
	}
}
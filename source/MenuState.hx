package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	private var _title : FlxText;
	private var _version : FlxText;
	private var _start : FlxButton;
	
	override public function create () : Void
	{
		super.create();
		// Texto Titulo principal
		_title = new FlxText(0, 100, FlxG.width);
		_title.text = "Titulo Principal";
		_title.setFormat("assets/fonts/blue highway linocut.ttf", 41, FlxColor.WHITE, FlxTextAlign.CENTER);
		_title.antialiasing = true;
		add(_title);
		// Boton Start
		_start = new FlxButton(150, 150, "Start", ClickStart);
		_start.x = 	FlxG.width / 2 - _start.width / 2;
		_start.y = 	FlxG.height / 2;
		_start.antialiasing = true;
        add(_start);
		
		
	}

	override public function update (elapsed : Float) : Void
	{
		super.update(elapsed);
	}
	
	private function ClickStart () 
	{
		FlxG.camera.fade(FlxColor.BLACK, 2.0, StartPlaying);			// Oscurece la pantalla de a poco
	}
	
	private function StartPlaying () 
	{
		FlxG.switchState(new State001());								// Carga el primer escenario
	}
}
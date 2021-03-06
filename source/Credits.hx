package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

class Credits extends FlxSubState 
{
	private var title : FlxText;
	private var name : FlxText;
	private var pointer: FlxSprite; 
	private var back : FlxText;
	
	override public function create () : Void
	{
		super.create();
		_parentState.persistentDraw = false;
		_parentState.persistentUpdate = false;
		set_bgColor(FlxColor.fromRGB(0, 153, 255));
		// Title
		title = new FlxText(0, 70, FlxG.width);
		title.text = "Credits";
		title.setFormat("assets/fonts/Minercraftory.ttf", 50, FlxColor.WHITE, FlxTextAlign.CENTER);
		title.antialiasing = true;
		add(title);
		// Name
		name = new FlxText(0, 250, FlxG.width);
		name.text = "Cristian Gianti";
		name.setFormat("assets/fonts/Minercraftory.ttf", 30, FlxColor.WHITE, FlxTextAlign.CENTER);
		name.antialiasing = true;
		add(name);
		// Back
		back = new FlxText();
		back.text = "Back";
		back.setFormat("assets/fonts/Minercraftory.ttf", 30, FlxColor.WHITE, FlxTextAlign.CENTER);
		back.setPosition(FlxG.width / 2 - back.width / 2, FlxG.height / 2 + back.height * 3);
		back.antialiasing = true;
		add(back);
		// Pointer
		pointer = new FlxSprite();
		pointer.makeGraphic(250, 50, FlxColor.TRANSPARENT, true);
		pointer.setPosition(FlxG.width / 2 - pointer.width / 2, back.y); 
		pointer.drawRect(5, 0, 240, 5, FlxColor.WHITE);
		pointer.drawRect(5, 45, 240, 5, FlxColor.WHITE);
		pointer.drawRect(0, 5, 5, 40, FlxColor.WHITE);
		pointer.drawRect(245, 5, 5, 40, FlxColor.WHITE);
		add(pointer);
	}
	
	override public function update (elapsed : Float) : Void
	{
		super.update(elapsed);
		if (FlxG.keys.anyJustPressed([ENTER, SPACE]))
		{
			FlxG.camera.fade(FlxColor.BLACK, 0.5, false, ChangeState);
			Sound.instance.menuSelected.play();
		}
	}
	
	private function ChangeState () : Void
	{
		camera.fade(FlxColor.TRANSPARENT, 0.5, true);
		close();
	}		
}
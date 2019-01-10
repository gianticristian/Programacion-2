package;

import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxSave;
using flixel.util.FlxSpriteUtil;


class Options extends FlxSubState 
{
	private var title : FlxText;
	private var pointer: FlxSprite; 
	private var musicVolume : FlxText;
	private var musicVolumeDown : FlxSprite;
	private var musicVolumeUp : FlxSprite;
	private var musicVolumeBar : FlxBar;
	private var musicVolumeBarDistance : Int = 0;
	private var back : FlxText;
	private var menuSelected : FlxSound;
	private var save: FlxSave;

	override public function create () : Void 
	{
		super.create();
		_parentState.persistentDraw = false;
		_parentState.persistentUpdate = false;
		set_bgColor(FlxColor.fromRGB(0, 204, 102));
		// Title
		title = new FlxText(0, 70, FlxG.width);
		title.text = "Options";
		title.setFormat("assets/fonts/Minercraftory.ttf", 50, FlxColor.WHITE, FlxTextAlign.CENTER);
		title.antialiasing = true;
		add(title);
		// MusicVolume
		musicVolume = new FlxText();
		musicVolume.text = "Music";
		musicVolume.setFormat("assets/fonts/Minercraftory.ttf", 20, FlxColor.WHITE, FlxTextAlign.CENTER);
		musicVolume.setPosition(FlxG.width / 2 - musicVolume.width / 2, FlxG.height / 2 - musicVolume.height * 3);
		musicVolume.antialiasing = true;
		add(musicVolume);
		// MusicVolumeDown
		musicVolumeDown = new FlxSprite();
		musicVolumeDown.makeGraphic(20, 20, FlxColor.TRANSPARENT, true);
		musicVolumeDown.setPosition(FlxG.width / 2 - musicVolumeDown.width * 8, musicVolume.y + musicVolume.height * 1.5); 
		musicVolumeDown.drawRect(0, musicVolumeDown.height / 2 - 2.5, 20, 5, FlxColor.WHITE);
		add(musicVolumeDown);
		// MusicVolumeUp
		musicVolumeUp = new FlxSprite();
		musicVolumeUp.makeGraphic(20, 20, FlxColor.TRANSPARENT, true);
		musicVolumeUp.setPosition(FlxG.width / 2 + musicVolumeUp.width * 8, musicVolume.y + musicVolume.height * 1.5); 
		musicVolumeUp.drawRect(0, musicVolumeUp.height / 2 - 2.5, 20, 5, FlxColor.WHITE);
		musicVolumeUp.drawRect(musicVolumeUp.width / 2 - 2.5, 0, 5, 20, FlxColor.WHITE);
		add(musicVolumeUp);
		// MusicVolumeBar
		musicVolumeBarDistance = Std.int((musicVolumeUp.x - musicVolumeUp.width) - (musicVolumeDown.x + musicVolumeDown.width));
		musicVolumeBar = new FlxBar(musicVolumeDown.x + musicVolumeDown.width * 1.5, musicVolumeDown.y, LEFT_TO_RIGHT, musicVolumeBarDistance, Std.int(musicVolumeUp.height));
		musicVolumeBar.createFilledBar(0xff464646, FlxColor.WHITE, true, FlxColor.WHITE);
		add(musicVolumeBar);
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
		// Sound
		menuSelected = FlxG.sound.load("assets/sounds/MenuSelected.wav");
		menuSelected.volume = 1;
		
		
		save = new FlxSave();
		save.bind("musicVolume");
	}
	
	override public function update (elapsed : Float) : Void
	{
		super.update(elapsed);
		if (FlxG.keys.anyJustPressed([ENTER, SPACE]))
		{
			FlxG.camera.fade(FlxColor.BLACK, 0.5, false, ChangeState);
			menuSelected.play();
		}
		if (FlxG.keys.anyJustPressed([LEFT, A]))
		{
			//FlxG.sound.volume -= 0.1;
			FlxG.sound.music.volume -= 0.1;
			save.data.volume = FlxG.sound.volume;
			menuSelected.play();
		}
		if (FlxG.keys.anyJustPressed([RIGHT, D]))
		{
			//FlxG.sound.volume += 0.1;
			FlxG.sound.music.volume += 0.1;
			save.data.volume = FlxG.sound.volume;
			menuSelected.play();
		}
	}
	
	private function ChangeState () : Void
	{
		save.close();
		camera.fade(FlxColor.TRANSPARENT, 0.5, true);
		close();
	}	
}
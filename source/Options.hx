package;

import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.FlxG;
using flixel.util.FlxSpriteUtil;


class Options extends FlxSubState 
{
	private var title : FlxText;
	private var back : FlxText;
	
	private var musicVolume : FlxText;
	private var musicVolumeDown : FlxSprite;
	private var musicVolumeUp : FlxSprite;
	private var musicVolumeBar : FlxBar;
	private var musicVolumeBarDistance : Int = 0;
	private var musicVolumeBarText : FlxText;
	
	private var sfxVolume : FlxText;
	private var sfxVolumeDown : FlxSprite;
	private var sfxVolumeUp : FlxSprite;
	private var sfxVolumeBar : FlxBar;
	private var sfxVolumeBarDistance : Int = 0;
	private var sfxVolumeBarText : FlxText;
	
	private var pointer: FlxSprite; 
	private var menu : Array<FlxText>;
	private var selected : Int = 0;

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
		musicVolume.alpha = 0.5;
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
		musicVolumeBar.createFilledBar(bgColor, FlxColor.WHITE, true, FlxColor.WHITE);
		add(musicVolumeBar);
		// MusicVolumeBarText
		musicVolumeBarText = new FlxText();
		musicVolumeBarText.text = "0";
		musicVolumeBarText.setFormat("assets/fonts/Minercraftory.ttf", 12, bgColor, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		musicVolumeBarText.setPosition((musicVolumeBar.x + musicVolumeBar.width / 2) - musicVolumeBarText.width / 2, musicVolumeBar.y - 1);
		musicVolumeBarText.antialiasing = true;
		add(musicVolumeBarText);	
		// SfxVolume
		sfxVolume = new FlxText();
		sfxVolume.text = "SFX";
		sfxVolume.setFormat("assets/fonts/Minercraftory.ttf", 20, FlxColor.WHITE, FlxTextAlign.CENTER);
		sfxVolume.setPosition(FlxG.width / 2 - sfxVolume.width / 2, FlxG.height / 2);
		sfxVolume.antialiasing = true;
		sfxVolume.alpha = 0.5;
		// SfxVolumeDown
		sfxVolumeDown = new FlxSprite();
		sfxVolumeDown.makeGraphic(20, 20, FlxColor.TRANSPARENT, true);
		sfxVolumeDown.setPosition(FlxG.width / 2 - sfxVolumeDown.width * 8, sfxVolume.y + sfxVolume.height * 1.5); 
		sfxVolumeDown.drawRect(0, sfxVolumeDown.height / 2 - 2.5, 20, 5, FlxColor.WHITE);
		add(sfxVolumeDown);
		// SfxVolumeUp
		sfxVolumeUp = new FlxSprite();
		sfxVolumeUp.makeGraphic(20, 20, FlxColor.TRANSPARENT, true);
		sfxVolumeUp.setPosition(FlxG.width / 2 + sfxVolumeUp.width * 8, sfxVolume.y + sfxVolume.height * 1.5); 
		sfxVolumeUp.drawRect(0, sfxVolumeUp.height / 2 - 2.5, 20, 5, FlxColor.WHITE);
		sfxVolumeUp.drawRect(sfxVolumeUp.width / 2 - 2.5, 0, 5, 20, FlxColor.WHITE);
		add(sfxVolumeUp);
		// SfxVolumeBar
		sfxVolumeBarDistance = Std.int((sfxVolumeUp.x - sfxVolumeUp.width) - (sfxVolumeDown.x + sfxVolumeDown.width));
		sfxVolumeBar = new FlxBar(sfxVolumeDown.x + sfxVolumeDown.width * 1.5, sfxVolumeDown.y, LEFT_TO_RIGHT, sfxVolumeBarDistance, Std.int(sfxVolumeUp.height));
		sfxVolumeBar.createFilledBar(bgColor, FlxColor.WHITE, true, FlxColor.WHITE);
		add(sfxVolumeBar);
		// SfxVolumeBarText
		sfxVolumeBarText = new FlxText();
		sfxVolumeBarText.setFormat("assets/fonts/Minercraftory.ttf", 12, bgColor, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		sfxVolumeBarText.setPosition((sfxVolumeBar.x + sfxVolumeBar.width / 2) - sfxVolumeBarText.width / 2, sfxVolumeBar.y - 1);
		sfxVolumeBarText.antialiasing = true;
		add(sfxVolumeBarText);
		// Back
		back = new FlxText();
		back.text = "Back";
		back.setFormat("assets/fonts/Minercraftory.ttf", 30, FlxColor.WHITE, FlxTextAlign.CENTER);
		back.setPosition(FlxG.width / 2 - back.width / 2, FlxG.height / 2 + back.height * 3);
		back.antialiasing = true;
		
		// Menu
		menu = new Array<FlxText>();
		menu.push(musicVolume);
		menu.push(sfxVolume);
		menu.push(back);
		for (item in menu)
			add(item);
			
		// Pointer
		pointer = new FlxSprite();
		pointer.makeGraphic(250, 50, FlxColor.TRANSPARENT, true);
		pointer.setPosition(FlxG.width / 2 - pointer.width / 2, back.y); 
		pointer.drawRect(5, 0, 240, 5, FlxColor.WHITE);
		pointer.drawRect(5, 45, 240, 5, FlxColor.WHITE);
		pointer.drawRect(0, 5, 5, 40, FlxColor.WHITE);
		pointer.drawRect(245, 5, 5, 40, FlxColor.WHITE);
		add(pointer);
		selected = menu.length - 1;
		
		UpdateSfxVolumeUI();
		UpdateMusicVolumeUI();
	}
	
	override public function update (elapsed : Float) : Void
	{
		super.update(elapsed);
		if (FlxG.keys.anyJustPressed([ENTER, SPACE]))
			if (menu[selected] == back) 
				Back();
		if (FlxG.keys.anyJustPressed([LEFT, A]))
			ClickSelected(-0.1);
		if (FlxG.keys.anyJustPressed([RIGHT, D]))
			ClickSelected(0.1);
	
		if (FlxG.keys.anyJustPressed([UP, W]))
		{
			if (selected > 0)
			{
				menu[selected].alpha = 0.5;
				selected--;
				menu[selected].alpha = 1;
				pointer.y = menu[selected].y;
				Sound.instance.menuChange.play();
			}
		}
		if (FlxG.keys.anyJustPressed([DOWN, S]))
		{
			if (selected < menu.length - 1)
			{
				menu[selected].alpha = 0.5;
				selected++;
				menu[selected].alpha = 1;
				pointer.y = menu[selected].y;
				Sound.instance.menuChange.play();
			}
		}
	}
	
	private function ClickSelected (amount : Float = null)
	{
		if (menu[selected] == musicVolume)
		{
			Sound.instance.SetMusicVolume(amount);
			UpdateMusicVolumeUI();
		}
		else if (menu[selected] == sfxVolume) 
		{
			Sound.instance.SetSfxVolume(amount);
			UpdateSfxVolumeUI();
		}
		else 
			return;
		Sound.instance.menuSelected.play();
	}
	
	private function Back () : Void
	{
		Sound.instance.menuSelected.play();
		camera.fade(FlxColor.TRANSPARENT, 0.5, true);
		close();	
	}	
	
	private function UpdateMusicVolumeUI () : Void
	{
		var volume:Int = Math.round(FlxG.sound.music.volume * 100);
		musicVolumeBar.value = volume;
		musicVolumeBarText.text = Std.string(volume);
	}
	
	private function UpdateSfxVolumeUI () : Void
	{
		var volume:Int = Math.round(Sound.instance.sfxGroup.volume * 100);
		sfxVolumeBar.value = volume;
		sfxVolumeBarText.text = Std.string(volume);
	}
}
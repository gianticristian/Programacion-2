package;

import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.system.FlxSoundGroup;

class Sound 
{
	public static var instance (default, null) : Sound = new Sound();
	
	public var sfxGroup : FlxSoundGroup;
	public var menuChange : FlxSound;
	public var menuSelected : FlxSound;
	
	public var mainMenuMusic : String = "assets/sounds/MenuMusic.wav";
	
	
	private function new () : Void
	{
		Sound.instance = this;		
	}
	
	public function CreateSound () :Void
	{
		menuChange = new FlxSound();
		menuChange = FlxG.sound.load("assets/sounds/MenuChange.wav");
		menuSelected = new FlxSound();
		menuSelected = FlxG.sound.load("assets/sounds/MenuSelected.wav");
		sfxGroup = new FlxSoundGroup();
		sfxGroup.add(menuChange);
		sfxGroup.add(menuSelected);
		sfxGroup.volume = Save.instance.LoadSfxVolume();
	}
	
	public function SetSfxVolume (volume : Float) : Void
	{
		sfxGroup.volume += volume;
		Save.instance.SaveSfxVolume(sfxGroup.volume);
	}
	
	public function SetMusicVolume (volume : Float) : Void
	{
		FlxG.sound.music.volume += volume;
		Save.instance.SaveMusicVolume(FlxG.sound.music.volume);
	}
	
	public function PlayMusic (song : String) : Void
	{
		switch (song) 
		{
			case "MainMenu":
				FlxG.sound.playMusic(mainMenuMusic);	
			default:
				FlxG.sound.pause();
		}		
		FlxG.sound.music.looped = true;
		FlxG.sound.music.volume = Save.instance.LoadMusicVolume();
	}
}
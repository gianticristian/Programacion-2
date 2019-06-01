package;

import flixel.util.FlxSave;

class Save
{
	public static var instance (default, null) : Save = new Save();
	
	private var save : FlxSave;
	
	private function new () : Void 
	{
		Save.instance = this;
		save = new FlxSave();
		save.bind("musicVolume");
		save.bind("sfxVolume");
	}
	
	public function Close () : Void
	{
		save.close();
	}
	
	public function SaveMusicVolume (volume : Float) : Void
	{
		save.data.musicVolume = volume;
		save.flush();
	}
	
	public function LoadMusicVolume () : Float
	{
		if (save.data.musicVolume != null)
			return save.data.musicVolume;
		else
		{
			return 1;
		}
	}
	
	public function SaveSfxVolume (volume : Float) : Void
	{
		save.data.sfxVolume = volume;
		save.flush();
	}
	
	public function LoadSfxVolume () : Float
	{
		if (save.data.sfxVolume != null)
			return save.data.sfxVolume;	
		else
			return 1;			
	}
}
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.system.FlxSound;
import flash.system.System;
import flixel.util.FlxSave;

using flixel.util.FlxSpriteUtil;

class MenuState extends FlxState
{
	private var title : FlxText;
	private var version : FlxText;
	private var start : FlxText;
	private var options : FlxText;
	private var credits : FlxText;
	private var exit : FlxText;	
	
	private var pointer: FlxSprite; 
	private var menu : Array<FlxText>;
	private var selected : Int = 0;
	private var menuChange : FlxSound;
	private var menuSelected : FlxSound;
	private var menuMusic : FlxSound;
	
	private var creditsState : Credits;
	private var optionsState : Options;
	
	public var save : FlxSave;
	
	override public function create () : Void
	{
		super.create();
		set_bgColor(FlxColor.fromRGB(255, 77, 77));
		// Title
		title = new FlxText(0, 70, FlxG.width);
		title.text = "Titulo Principal";
		title.setFormat("assets/fonts/Minercraftory.ttf", 50, FlxColor.WHITE, FlxTextAlign.CENTER);
		title.antialiasing = true;
		add(title);
		// Start
		start = new FlxText();
		start.text = "Start";
		start.setFormat("assets/fonts/Minercraftory.ttf", 30, FlxColor.WHITE, FlxTextAlign.CENTER);
		start.setPosition(FlxG.width / 2 - start.width / 2, FlxG.height / 2);
		start.antialiasing = true;
		// Options
		options = new FlxText();
		options.text = "Options";
		options.setFormat("assets/fonts/Minercraftory.ttf", 30, FlxColor.WHITE, FlxTextAlign.CENTER);
		options.setPosition(FlxG.width / 2 - options.width / 2, FlxG.height / 2 + options.height);
		options.alpha = 0.5;
		options.antialiasing = true;
		// Credits
		credits = new FlxText();
		credits.text = "Credits";
		credits.setFormat("assets/fonts/Minercraftory.ttf", 30, FlxColor.WHITE, FlxTextAlign.CENTER);
		credits.setPosition(FlxG.width / 2 - credits.width / 2, FlxG.height / 2 + credits.height * 2);
		credits.alpha = 0.5;
		credits.antialiasing = true;
		// Exit
		exit = new FlxText();
		exit.text = "Exit";
		exit.setFormat("assets/fonts/Minercraftory.ttf", 30, FlxColor.WHITE, FlxTextAlign.CENTER);
		exit.setPosition(FlxG.width / 2 - exit.width / 2, FlxG.height / 2 + exit.height * 3);
		exit.alpha = 0.5;
		exit.antialiasing = true;
		// Menu
		menu = new Array<FlxText>();
		menu.push(start);
		menu.push(options);
		menu.push(credits);
		menu.push(exit);
		for (item in menu)
			add(item);
		// Pointer
		pointer = new FlxSprite();
		pointer.makeGraphic(250, 50, FlxColor.TRANSPARENT, true);
		pointer.setPosition(FlxG.width / 2 - pointer.width / 2, menu[selected].y); 
		pointer.drawRect(5, 0, 240, 5, FlxColor.WHITE);
		pointer.drawRect(5, 45, 240, 5, FlxColor.WHITE);
		pointer.drawRect(0, 5, 5, 40, FlxColor.WHITE);
		pointer.drawRect(245, 5, 5, 40, FlxColor.WHITE);
		add(pointer);
		// Sound
		menuChange = FlxG.sound.load("assets/sounds/MenuChange.wav");
		menuChange.volume = 1;
		menuSelected = FlxG.sound.load("assets/sounds/MenuSelected.wav");
		menuSelected.volume = 1;
		if (FlxG.sound.music == null)
			FlxG.sound.playMusic("assets/sounds/MenuMusic.wav", 1, true);
		// Save file
		save = new FlxSave();
	}

	override public function update (elapsed : Float) : Void
	{
		if (FlxG.keys.anyJustPressed([UP, W]))
		{
			if (selected > 0)
			{
				menu[selected].alpha = 0.5;
				selected--;
				menu[selected].alpha = 1;
				pointer.y = menu[selected].y;
				menuChange.play();
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
				menuChange.play();
			}
		}
		if (FlxG.keys.anyJustPressed([ENTER, SPACE]))
		{
			FlxG.camera.fade(FlxColor.BLACK, 0.5, false, ChangeState);
			menuSelected.play();
		}
		super.update(elapsed);
	}
	
	private function ChangeState () : Void
	{
		switch (menu[selected].text) 
		{
			case "Start":
				FlxG.switchState(new PlayState());
			case "Options":			
				optionsState = new Options();
				openSubState(optionsState);	
				camera.fade(FlxColor.TRANSPARENT, 0.5, true);	
			case "Credits":			
				creditsState = new Credits();
				openSubState(creditsState);	
				camera.fade(FlxColor.TRANSPARENT, 0.5, true);
			case "Exit":
				System.exit(0);
			default:
				trace("State not found");
		}
	}	
}
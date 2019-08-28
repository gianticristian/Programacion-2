package;

import flixel.FlxSprite;



class Paracuhte extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, player : Player) 
	{
		super(X, Y);
		loadGraphicFromSprite(player);
		
		
		trace(graphic);
		
		
		
		
	}
	
}
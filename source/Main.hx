package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		flixel.FlxSprite.defaultAntialiasing = true;
		addChild(new FlxGame(0, 0, PlayState, 60, 60, true));
	}
}

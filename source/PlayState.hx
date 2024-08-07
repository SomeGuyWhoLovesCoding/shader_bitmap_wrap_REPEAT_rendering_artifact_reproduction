package;

import flixel.*;

class PlayState extends FlxState
{
	var sustainNote1:SustainNote;
	var sustainNote2:SustainNote;

	override public function create()
	{
		sustainNote1 = new SustainNote();
		sustainNote1.x = 400;
		sustainNote1.y = 200;
		add(sustainNote1);

		sustainNote2 = new SustainNote();
		sustainNote2.x = 800;
		sustainNote2.y = 200;
		add(sustainNote2);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.A)
			sustainNote1.length += 20;

		if (FlxG.keys.justPressed.B)
			sustainNote2.length += 20;

		if (FlxG.keys.justPressed.Z)
			sustainNote1.length -= 20;

		if (FlxG.keys.justPressed.X)
			sustainNote2.length -= 20;

		if (FlxG.keys.justPressed.C)
			sustainNote1.direction += 10;

		if (FlxG.keys.justPressed.D)
			sustainNote2.direction += 10;

		if (FlxG.keys.justPressed.N)
			sustainNote1.direction -= 10;

		if (FlxG.keys.justPressed.M)
			sustainNote2.direction -= 10;

		if (FlxG.keys.justPressed.O)
			sustainNote1.downScroll = !sustainNote1.downScroll;

		if (FlxG.keys.justPressed.P)
			sustainNote2.downScroll = !sustainNote2.downScroll;

		if (FlxG.keys.justPressed.LEFT)
			sustainNote1.scale.x += 0.1;

		if (FlxG.keys.justPressed.UP)
			sustainNote2.scale.x += 0.1;

		if (FlxG.keys.justPressed.RIGHT)
			sustainNote1.scale.y += 0.1;

		if (FlxG.keys.justPressed.DOWN)
			sustainNote2.scale.y += 0.1;

		super.update(elapsed);
	}
}

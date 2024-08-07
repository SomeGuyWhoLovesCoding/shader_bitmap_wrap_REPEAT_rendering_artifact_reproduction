package;

import flixel.math.FlxAngle;
import flixel.math.FlxRect;
import flixel.math.FlxMath;
import flixel.*;

class SustainNote extends FlxSprite
{
	public var tail:FlxSprite;

	public var downScroll(default, set):Bool;

	inline function set_downScroll(newDownScroll:Bool)
	{
		downScroll = newDownScroll;
		set_direction(direction);
		return newDownScroll;
	}

	public var direction(default, set):Float;

	inline function set_direction(newDirection:Float)
	{
		return angle = (direction = newDirection) + (downScroll ? 180 : 0);
	}

	public var length(default, set):Int;

	inline function set_length(newLength:Int)
	{
		@:bypassAccessor
		{
			//flipY = _scrollMult < 0;

			//var _scrollMult = strum.scrollMult;

			_frame.frame.y = -newLength/* * ((Gameplay.instance.songSpeed * 0.45) / strum.scale.y)*/;
			_frame.frame.height = (-_frame.frame.y/* * (_scrollMult < 0 ? -_scrollMult : _scrollMult)*/);

			if (_frame.frame.height < 0)
				_frame.frame.height = 0;

			var scaleY = scale.y;
			height = _frame.frame.height * (scaleY < 0 ? -scaleY : scaleY);
		}

		return length = newLength;
	}

	override function set_clipRect(rect:FlxRect):FlxRect
	{
		return clipRect = rect;
	}

	public function new()
	{
		super();

		loadGraphic('assets/images/Sustain.png');
		_frame.frame.width *= 0.5;
		tail = new FlxSprite().loadGraphic('assets/images/Sustain.png');

		@:privateAccess
		{
			tail._frame.frame.width = tail._frame.frame.x = _frame.frame.width;
			tail._frame.frame.y = FlxMath.EPSILON;
		}

		@:bypassAccessor
		{
			offset.x = offset.y = origin.y = tail.offset.x = tail.offset.y = tail.origin.y = direction = length = 0;
			origin.x = tail.origin.x = frameWidth * 0.25;
			active = tail.active = moves = tail.moves = false;
		}
	}

	/**
	 * Calculates the smallest globally aligned bounding box that encompasses this sprite's graphic as it
	 * would be displayed. Honors scrollFactor, rotation, scale, offset and origin.
	 * @param newRect Optional output `FlxRect`, if `null`, a new one is created.
	 * @param camera  Optional camera used for scrollFactor, if null `FlxG.camera` is used.
	 * @return A globally aligned `FlxRect` that fully contains the input sprite.
	 * @since 4.11.0
	 */
	override public function getScreenBounds(?newRect:FlxRect, ?cam:FlxCamera)
	{
		if (newRect == null)
			newRect = FlxRect.get();

		if (_frame == null)
			return newRect.getRotatedBounds(@:bypassAccessor angle, _scaledOrigin, newRect);

		var camera = cam;

		if (camera == null)
			camera = FlxG.camera;

		@:bypassAccessor
		{
			newRect.x = x;
			newRect.y = y;

			var scaleX = scale.x;
			var scaleY = scale.y;

			var originX = origin.x;
			var originY = origin.y;

			_scaledOrigin.x = originX * scaleX;
			_scaledOrigin.y = originY * scaleY;

			newRect.x += (-Std.int(camera.scroll.x * scrollFactor.x) - offset.x + originX - _scaledOrigin.x);
			newRect.y += (-Std.int(camera.scroll.y * scrollFactor.y) - offset.y + originY - _scaledOrigin.y);

			newRect.width = _frame.frame.width * (scaleX < 0 ? -scaleX : scaleX);
			newRect.height = _frame.frame.height * (scaleY < 0 ? -scaleY : scaleY);
		}

		return newRect.getRotatedBounds(@:bypassAccessor angle, _scaledOrigin, newRect);
	} // Please don't remove this

	override function draw()
	{
		var _angle = FlxAngle.asRadians(angle);

		@:bypassAccessor
		{
			if (height != 0)
			{
				super.draw();
			}

			tail.x = x + (height * -Math.sin(_angle));
			tail.y = y + (height * Math.cos(_angle));
			tail.angle = angle;
			tail.scale.set(scale.x, scale.y);
		}

		tail.draw();
	}
}
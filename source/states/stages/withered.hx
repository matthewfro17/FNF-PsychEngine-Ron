package states.stages;

import states.stages.objects.*;
import objects.Character;
import flixel.addons.effects.chainable.FlxGlitchEffect;

class happy extends BaseStage
{
  var glitchEffect:FlxGlitchEffect;
	override function create()
	{
				var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('updateron/bg/bobtwerked/annoyed_sky'));
				bg.setGraphicSize(Std.int(bg.width * 0.75));
				bg.scrollFactor.set(0.2,0.2);
				bg.updateHitbox();
				bg.screenCenter(XY);
				add(bg);
				var sun:FlxSprite = new FlxSprite().loadGraphic(Paths.image('updateron/bg/bobtwerked/annoyed_sun'));
				sun.setGraphicSize(Std.int(sun.width * 0.75));
				sun.scrollFactor.set(0.2,0.2);
				sun.updateHitbox();
				sun.screenCenter(XY);
				add(sun);
				witheredRa = new FlxSprite(-512, -260);
				witheredRa.frames = Paths.getSparrowAtlas('updateron/bg/annoyed_rain');
				witheredRa.setGraphicSize(Std.int(witheredRa.width * 4));
				witheredRa.animation.addByPrefix('rain', 'rain', 24, true);
				witheredRa.updateHitbox();
				witheredRa.antialiasing = true;
				witheredRa.scrollFactor.set(0.5,0.1);
				witheredRa.screenCenter(XY);
				add(witheredRa);
				witheredRa.animation.play('rain');
				var wBackground:FlxSprite = new FlxSprite().loadGraphic(Paths.image('updateron/bg/bobtwerked/annoyed_back'));
				wBackground.setGraphicSize(Std.int(wBackground.width * 0.95));
				wBackground.scrollFactor.set(0.4,0.2);
				wBackground.updateHitbox();
				wBackground.screenCenter(XY);
				add(wBackground);
				witheredClouds = new FlxBackdrop(Paths.image('updateron/bg/bobtwerked/annoyed_cloud'), 0.2, 0, true, false);
				witheredClouds.scrollFactor.set(0.2,0);
				witheredClouds.screenCenter(XY);
				witheredClouds.scale.set(0.5,0.5);
				witheredClouds.y -= 180;
				add(witheredClouds);
				var ground:FlxSprite = new FlxSprite(260, -375).loadGraphic(Paths.image('updateron/bg/bobtwerked/annoyed_ground'));
				ground.scale.set(1.1,1.1);
				ground.scrollFactor.set(1,1);
				ground.updateHitbox();
				ground.screenCenter(X);
				add(ground);
		}
}

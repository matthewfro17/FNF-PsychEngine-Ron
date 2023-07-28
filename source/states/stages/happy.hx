package states.stages;

import states.stages.objects.*;
import objects.Character;
import flixel.addons.effects.chainable.FlxGlitchEffect;

class happy extends BaseStage
{
  var glitchEffect:FlxGlitchEffect;
	override function create()
	{
				defaultCamZoom = 0.9;
				curStage = 'happy';
				var bg:FlxSprite = new FlxSprite(-100,10).loadGraphic(Paths.image('updateron/bg/happyRon_sky'));
				bg.updateHitbox();
				bg.scale.x = 1.2;
				bg.scale.y = 1.2;
				bg.active = false;
				bg.antialiasing = true;
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);
				var glitchEffect = new FlxGlitchEffect(8,10,0.4,FlxGlitchDirection.HORIZONTAL);
				var glitchSprite = new FlxEffectSprite(bg, [glitchEffect]);
				add(glitchSprite);*/
				
				var ground:FlxSprite = new FlxSprite(-537, -290).loadGraphic(Paths.image('updateron/bg/happyRon_ground'));
				ground.updateHitbox();
				ground.active = false;
				ground.antialiasing = true;
				add(ground);
		}
}

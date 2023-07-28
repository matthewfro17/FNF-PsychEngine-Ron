package states.stages;

import states.stages.objects.*;
import objects.Character;

class StageWeek1 extends BaseStage
{
	override function create()
	{
				defaultCamZoom = 0.9;
				curStage = 'mad';
				var bg:FlxSprite = new FlxSprite(-100,10).loadGraphic(Paths.image('updateron/bg/pissedRon_sky'));
				bg.updateHitbox();
				bg.scale.x = 1;
				bg.scale.y = 1;
				bg.active = false;
				bg.antialiasing = true;
				bg.screenCenter();
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);
				
				var clouds:FlxSprite = new FlxSprite(-100,10).loadGraphic(Paths.image('updateron/bg/pissedRon_clouds'));
				clouds.updateHitbox();
				clouds.scale.x = 0.7;
				clouds.scale.y = 0.7;
				clouds.screenCenter();
				clouds.active = false;
				clouds.antialiasing = true;
				clouds.scrollFactor.set(0.2, 0.2);
				add(clouds);
				/*var glitchEffect = new FlxGlitchEffect(8,10,0.4,FlxGlitchDirection.HORIZONTAL);
				var glitchSprite = new FlxEffectSprite(bg, [glitchEffect]);
				add(glitchSprite);*/
				
				var ground:FlxSprite = new FlxSprite(-537, -250).loadGraphic(Paths.image('updateron/bg/pissedRon_ground'));
				ground.updateHitbox();
				ground.active = false;
				ground.antialiasing = true;
				add(ground);
				
				var wastedbg = new FlxSprite();
				wastedbg.frames = Paths.getSparrowAtlas('updateron/bg/wastedbg');
				wastedbg.scale.set(4,4);
				wastedbg.animation.addByPrefix('idle', 'bg instance 1', 24, true);
				wastedbg.animation.play('idle');
				wastedbg.screenCenter();
				wastedbg.alpha = 0;
				add(wastedbg);
		}
}

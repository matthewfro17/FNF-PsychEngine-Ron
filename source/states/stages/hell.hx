package states.stages;

import states.stages.objects.*;
import objects.Character;

class hell extends BaseStage
{
	override function create()
	{
			case 'hell':
			{
				defaultCamZoom = 0.85;
				curStage = 'hell';
				var hellbg = new FlxSprite();
				hellbg.frames = Paths.getSparrowAtlas('updateron/bg/hell_bg');
				hellbg.scale.set(5,5);
				hellbg.animation.addByPrefix('idle instance 1', 'idle instance 1', 48, true);
				hellbg.animation.play('idle instance 1');
				hellbg.antialiasing = true;
				hellbg.screenCenter(XY);
				hellbg.y += hellbg.height / 5;
				hellbg.scrollFactor.set(0.05, 0.05);
				add(hellbg);
				var firebg = new FlxSprite();
				firebg.frames = Paths.getSparrowAtlas('updateron/bg/escape_fire');
				firebg.scale.set(6,6);
				firebg.animation.addByPrefix('idle', 'fire instance 1', 24, true);
				firebg.animation.play('idle');
				firebg.scrollFactor.set();
				firebg.screenCenter();
				firebg.alpha = 0;
				add(firebg);
				satan = new FlxSprite(300, 200).loadGraphic(Paths.image('updateron/bg/hellRon_satan'));
				satan.antialiasing = true;
				satan.scale.set(1.2,1.2);
				satan.screenCenter(XY);
				satan.scrollFactor.set(0.15, 0.15);
				satan.y -= 100;
				satan.active = true;
				add(satan);	
				var ground:FlxSprite = new FlxSprite(300,200).loadGraphic(Paths.image('updateron/bg/hellRon_ground'));
				ground.antialiasing = true;
				ground.screenCenter(XY);
				ground.scrollFactor.set(0.9, 0.9);
				ground.active = false;
				add(ground);
				var fx = new FlxSprite().loadGraphic(Paths.image('updateron/bg/effect'));
				fx.setGraphicSize(Std.int(2560 * 0.25));
				fx.updateHitbox();
				fx.antialiasing = true;
				fx.screenCenter(XY);
				fx.scrollFactor.set(0, 0);
				fx.alpha = 0.3;		
				var blackeffect = new FlxSprite().makeGraphic(FlxG.width*3, FlxG.height*3, FlxColor.BLACK);
				blackeffect.updateHitbox();
				blackeffect.antialiasing = true;
				blackeffect.screenCenter(XY);
				blackeffect.scrollFactor.set();
				blackeffect.alpha = 1;
				if (SONG.song != 'Bloodshed-b')
					blackeffect.alpha = 0;
				add(blackeffect);
				var Estatic = new FlxSprite().loadGraphic(Paths.image('updateron/bg/deadly'));
				Estatic.scrollFactor.set();
				Estatic.screenCenter();
				Estatic.alpha = 0;
				var Estatic2 = new FlxSprite();
				Estatic2.frames = Paths.getSparrowAtlas('updateron/bg/trojan_static');
				Estatic2.scale.set(4,4);
				Estatic2.animation.addByPrefix('idle', 'static instance 1', 24, true);
				Estatic2.animation.play('idle');
				Estatic2.scrollFactor.set();
				Estatic2.screenCenter();
				Estatic2.alpha = 0;
		}
}

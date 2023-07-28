package states.stages;

import states.stages.objects.*;
import objects.Character;
import flixel.addons.effects.chainable.FlxGlitchEffect;

class daveHouse extends BaseStage
{
	override function create()
	{
				var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('updateron/bg/sky'));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.75, 0.75);
				bg.active = false;

				add(bg);
	
				var stageHills:FlxSprite = new FlxSprite(-225, -125).loadGraphic(Paths.image('updateron/bg/hills'));
				stageHills.setGraphicSize(Std.int(stageHills.width * 1.25));
				stageHills.updateHitbox();
				stageHills.antialiasing = true;
				stageHills.scrollFactor.set(0.8, 0.8);
				stageHills.active = false;
				
				add(stageHills);
	
				var gate:FlxSprite = new FlxSprite(-200, -125).loadGraphic(Paths.image('updateron/bg/gate'));
				gate.setGraphicSize(Std.int(gate.width * 1.2));
				gate.updateHitbox();
				gate.antialiasing = true;
				gate.scrollFactor.set(0.9, 0.9);
				gate.active = false;

				add(gate);
	
				var stageFront:FlxSprite = new FlxSprite(-225, -125).loadGraphic(Paths.image('updateron/bg/grass'));
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.2));
				stageFront.updateHitbox();
				stageFront.antialiasing = true;
				stageFront.active = false;
				
				add(stageFront);
		}
}

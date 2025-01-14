package psychlua;

import objects.Character;
import psychlua.FunkinLua;
import psychlua.CustomSubstate;

#if (HSCRIPT_ALLOWED && SScript >= "3.0.0")
import tea.SScript;
class HScript extends SScript
{
	public var parentLua:FunkinLua;
	
	public static function initHaxeModule(parent:FunkinLua)
	{
		#if (SScript >= "3.0.0")
		if(parent.hscript == null)
		{
			trace('initializing haxe interp for: ${parent.scriptName}');
			parent.hscript = new HScript(parent, parent.scriptName);
		}
		#end
	}

	public var interpName:String = null;
	override public function new(?parent:FunkinLua = null, interpName:String)
	{
		super("", false);
		parentLua = parent;
		this.interpName = interpName;
		preset();
	}

	override function preset()
	{
		#if (SScript >= "3.0.0")
		super.preset();

		// Some very commonly used classes
		set('FlxG', flixel.FlxG);
		set('FlxSprite', flixel.FlxSprite);
		set('FlxCamera', flixel.FlxCamera);
		set('FlxTimer', flixel.util.FlxTimer);
		set('FlxTween', flixel.tweens.FlxTween);
		set('FlxEase', flixel.tweens.FlxEase);
		set('PlayState', PlayState);
		set('Paths', Paths);
		set('Conductor', Conductor);
		set('ClientPrefs', ClientPrefs);
		set('Character', Character);
		set('Alphabet', Alphabet);
		set('Note', objects.Note);
		set('CustomSubstate', CustomSubstate);
		set('Countdown', backend.BaseStage.Countdown);
		#if (!flash && sys)
		set('FlxRuntimeShader', flixel.addons.display.FlxRuntimeShader);
		#end
		set('ShaderFilter', openfl.filters.ShaderFilter);
		set('StringTools', StringTools);

		// Functions & Variables
		set('setVar', function(name:String, value:Dynamic)
		{
			PlayState.instance.variables.set(name, value);
		});
		set('getVar', function(name:String)
		{
			var result:Dynamic = null;
			if(PlayState.instance.variables.exists(name)) result = PlayState.instance.variables.get(name);
			return result;
		});
		set('removeVar', function(name:String)
		{
			if(PlayState.instance.variables.exists(name))
			{
				PlayState.instance.variables.remove(name);
				return true;
			}
			return false;
		});
		set('debugPrint', function(text:String, ?color:FlxColor = null) {
			if(color == null) color = FlxColor.WHITE;
			FunkinLua.luaTrace(text, true, false, color);
		});

		// For adding your own callbacks

		// not very tested but should work
		set('createGlobalCallback', function(name:String, func:Dynamic)
		{
			#if LUA_ALLOWED
			for (script in PlayState.instance.luaArray)
				if(script != null && script.lua != null && !script.closed)
					Lua_helper.add_callback(script.lua, name, func);
			#end
			FunkinLua.customFunctions.set(name, func);
		});

		// tested
		set('createCallback', function(name:String, func:Dynamic, ?funk:FunkinLua = null)
		{
			if(funk == null) funk = parentLua;
			
			if(parentLua != null) funk.addLocalCallback(name, func);
			else FunkinLua.luaTrace('createCallback ($name): 3rd argument is null', false, false, FlxColor.RED);
		});

		set('addHaxeLibrary', function(libName:String, ?libPackage:String = '') {
			try {
				var str:String = '';
				if(libPackage.length > 0)
					str = libPackage + '.';

				set(libName, Type.resolveClass(str + libName));
			}
			catch (e:Dynamic) {
				var msg:String = e.toString();
				if(parentLua != null)
				{
					FunkinLua.lastCalledScript = parentLua;
					msg = parentLua.scriptName + ":" + parentLua.lastCalledFunction + " - " + msg;
				}
				else msg = '$interpName - $msg';
				FunkinLua.luaTrace(msg, parentLua == null, false, FlxColor.RED);
			}
		});
		set('parentLua', parentLua);
		set('game', PlayState.instance);
		set('buildTarget', FunkinLua.getBuildTarget());
		set('customSubstate', CustomSubstate.instance);
		set('customSubstateName', CustomSubstate.name);

		set('Function_Stop', FunkinLua.Function_Stop);
		set('Function_Continue', FunkinLua.Function_Continue);
		set('Function_StopLua', FunkinLua.Function_StopLua); //doesnt do much cuz HScript has a lower priority than Lua
		set('Function_StopHScript', FunkinLua.Function_StopHScript);
		set('Function_StopAll', FunkinLua.Function_StopAll);
		#end
	}

	public function executeCode(codeToRun:String, ?funcToRun:String = null, ?funcArgs:Array<Dynamic> = null):SCall
	{
		doString(codeToRun);

		if (funcToRun != null)
		{
			if(!exists(funcToRun))
			{
				FunkinLua.luaTrace(parentLua.scriptName + ' - No HScript function named: $funcToRun', false, false, FlxColor.RED);
				return null;
			}
			var callValue = call(funcToRun, funcArgs);
			if (callValue.succeeded)
				return callValue;
			else
			{
				var e = callValue.exceptions[0];
				if (e != null)
				{
					var msg:String = e.toString();
					if(parentLua != null) msg = parentLua.scriptName + ":" + parentLua.lastCalledFunction + " - " + msg;
					else msg = '$interpName - $msg';
					FunkinLua.luaTrace(msg, parentLua == null, false, FlxColor.RED);
				}
				return null;
			}
		}
		return null;
	}

	public function executeFunction(funcToRun:String = null, funcArgs:Array<Dynamic>):SCall
	{
		if (funcToRun == null)
			return null;

		return call(funcToRun, funcArgs);
	}

	public static function implement(funk:FunkinLua)
	{
		#if LUA_ALLOWED
		funk.addLocalCallback("runHaxeCode", function(codeToRun:String, ?varsToBring:Any = null, ?funcToRun:String = null, ?funcArgs:Array<Dynamic> = null) {
			var retVal:SCall = null;
			#if (SScript >= "3.0.0")
			initHaxeModule(funk);
			if(varsToBring != null)
			{
				for (key in Reflect.fields(varsToBring))
				{
					//trace('Key $key: ' + Reflect.field(varsToBring, key));
					funk.hscript.set(key, Reflect.field(varsToBring, key));
				}
			}
			retVal = funk.hscript.executeCode(codeToRun, funcToRun, funcArgs);
			if (retVal != null)
			{
				if(retVal.succeeded)
					return (retVal.returnValue == null || LuaUtils.isOfTypes(retVal.returnValue, [Bool, Int, Float, String, Array])) ? retVal.returnValue : null;

				var e = retVal.exceptions[0];
				if (e != null)
					FunkinLua.luaTrace(funk.scriptName + ":" + funk.lastCalledFunction + " - " + e, false, false, FlxColor.RED);
				return null;
			}
			#else
			FunkinLua.luaTrace("runHaxeCode: HScript isn't supported on this platform!", false, false, FlxColor.RED);
			#end
			return null;
		});
		
		funk.addLocalCallback("runHaxeFunction", function(funcToRun:String, ?funcArgs:Array<Dynamic> = null) {
			#if (SScript >= "3.0.0")
			var callValue = funk.hscript.executeFunction(funcToRun, funcArgs);
			if (!callValue.succeeded)
			{
				var e = callValue.exceptions[0];
				if (e != null)
					FunkinLua.luaTrace('ERROR (${funk.scriptName}: ${callValue.calledFunction}) - ' + e.message.substr(0, e.message.indexOf('\n')), false, false, FlxColor.RED);
				return null;
			}
			else
				return callValue.returnValue;
			#else
			FunkinLua.luaTrace("runHaxeFunction: HScript isn't supported on this platform!", false, false, FlxColor.RED);
			#end
		});
		// This function is unnecessary because import already exists in SScript as a native feature
		funk.addLocalCallback("addHaxeLibrary", function(libName:String, ?libPackage:String = '') {
			#if (SScript >= "3.0.0")
			initHaxeModule(funk);
			try {
				var str:String = '';
				if(libPackage.length > 0)
					str = libPackage + '.';

				var c = Type.resolveClass(str + libName);
				if (c != null)
					funk.hscript.set(libName, c);
			}
			catch (e:Dynamic) {
				FunkinLua.luaTrace(funk.scriptName + ":" + funk.lastCalledFunction + " - " + e, false, false, FlxColor.RED);
			}
			#else
			FunkinLua.luaTrace("addHaxeLibrary: HScript isn't supported on this platform!", false, false, FlxColor.RED);
			#end
		});
		#end
	}
}
#end
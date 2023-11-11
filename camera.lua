-- not used

function onCreatePost()
	addCamera('camChars', 0)

	setObjectCamera('dad', 'camChars')
	setObjectCamera('gf', 'camChars')
	setObjectCamera('boyfriend', 'camChars')
end

local modchartCameras = {}

local oldSOC = setObjectCamera
setObjectCamera = function(obj, camera)
	for i, k in ipairs(modchartCameras) do
		if k == camera then
			addToCamera(obj, camera)
			return true
		end
	end

	return setObjectCamera(obj, camera)
end

-- order: 0 is behind camHUD, 1 is behind camOther, other numbers is before camOther
function addCamera(tag, order)
	runHaxeCode([[
		var camera = new FlxCamera();
		camera.bgColor = 0;
		setVar(']]..tag..[[', camera);

		switch(]]..order..[[) {
			case 0:
				FlxG.cameras.remove(game.camOther, false);
				FlxG.cameras.remove(game.camHUD, false);
				FlxG.cameras.add(camera, false);
				FlxG.cameras.add(game.camHUD, false);
				FlxG.cameras.add(game.camOther, false);
			case 1:
				FlxG.cameras.remove(game.camOther, false);
				FlxG.cameras.add(camera, false);
				FlxG.cameras.add(game.camOther, false);
			default:
				FlxG.cameras.add(camera, false);
		}
	]])
	table.insert(modchartCameras, tag)
end

function addToCamera(obj, camera)
	runHaxeCode([[
		var camera = getVar(']]..camera..[[');
		var obj = game.getLuaObject(']]..obj..[[');
		if (obj == null)
			obj = Reflect.getProperty(game, ']]..obj..[[');

		obj.camera = camera;
	]])
end

function setCameraShader(camera, shader)
	local cameraGet = "LuaUtils.cameraFromString('"..camera.."')"
	for i, k in ipairs(modchartCameras) do
		if k == camera then
			cameraGet = "getVar('"..camera.."')"
			break
		end
	end

	runHaxeCode(cameraGet..".setFilters([new ShaderFilter(game.createRuntimeShader('"..shader.."'))])")
end

-- cool fix of runHaxeCode for 0.7.1h !!!!!
runHaxeCode([[
	import Reflect;
	import psychlua.LuaUtils;

	createCallback('runHaxeCode', (code:String) -> {
		this.doString(code);
		return this.returnValue;
	});
]])

function onUpdate(elapsed)
	setProperty('camChars.scroll.x', getProperty('camGame.scroll.x'))
	setProperty('camChars.scroll.y', getProperty('camGame.scroll.y'))
	setProperty('camChars.zoom', getProperty('camGame.zoom'))
end
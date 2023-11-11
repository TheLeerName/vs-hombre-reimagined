--luaDebugMode = true


-- bg elemetns
makeLuaSprite('bg', 'hombre_room', -600, -300)
addLuaSprite('bg')


-- cool fix of runHaxeCode for 0.7.1h !!!!!
runHaxeCode([[
	import Type;
	createCallback('runHaxeCode', (code:String) -> {
		this.doString(code);
		return this.returnValue;
	});
]])

function onCreatePost()
	makeLuaSprite('curve')

	if not shadersEnabled then
		setShaderFloat = function(a, b, c) end -- Shader is not FlxRuntimeShader!
		return
	end

	initLuaShader('wobbl')
	setCameraShader('camGame', 'wobbl')

	initLuaShader('curve')
	setSpriteShader('curve', 'curve')
	runHaxeCode("game.camHUD.setFilters([new ShaderFilter(game.modchartSprites.get('curve').shader)]);")
end

local doCurveOnSectionHit = false
local doCurveOnBeatHit = false

function onBeatHit()
	if doCurveOnBeatHit then
		doCurve(nil, seconds(2))
	end
end
function onSectionHit()
	if doCurveOnSectionHit then
		doCurve(nil, seconds(2))
	end
end

local wasNegativeLastTime = false
function doCurve(strength, duration)
	strength = strength or 0.15
	duration = duration or 1

	if getRandomBool(50) then strength = strength * -1 end
	if rating ~= 0 then strength = strength * rating end -- if you have skill issue, then game will make weaker curves
	strength = strength * getRandomFloat(0.75, 1) -- and a bit of random ofc

	--             skill issue affects to it too
	local tween = getRandomBool(50) and doTweenY or doTweenX

	tween('435', 'curve', strength, duration)
end
function doFlash()
	cameraFlash('camOther', 'ffffff', seconds(16))
end

-- 640
local stepEvents = {
	[256] = function()
		doFlash()
	end,

	[512] = function()
		doFlash()
	end,

	[639] = function()
		doCurveOnBeatHit = true
	end,
	[640] = function()
		doFlash()
	end,
	[669] = function()
		doCurveOnBeatHit = false
	end,
	[672] = function()
		doFlash()
	end,

	[703] = function()
		doCurveOnBeatHit = true
	end,
	[704] = function()
		doFlash()
	end,
	[733] = function()
		doCurveOnBeatHit = false
	end,
	[736] = function()
		doFlash()
	end,

	[767] = function()
		doCurveOnSectionHit = true
	end,
	[768] = function()
		doFlash()
	end,
	[1009] = function()
		doCurveOnSectionHit = false
	end,
	[1024] = function()
		doFlash()
	end,

	[1280] = function()
		doFlash()
	end,

	[1407] = function()
		doCurveOnBeatHit = true
	end,
	[1408] = function()
		doFlash()
	end,
	[1437] = function()
		doCurveOnBeatHit = false
	end,
	[1440] = function()
		doFlash()
	end,

	[1471] = function()
		doCurveOnBeatHit = true
	end,
	[1472] = function()
		doFlash()
	end,
	[1501] = function()
		doCurveOnBeatHit = false
	end,
	[1504] = function()
		doFlash()
	end,
}
function onStepHit()
	local fuck = stepEvents[curStep]
	if fuck ~= nil then
		fuck()
	end
end

function onUpdate(elapsed)
	local spd = 60 * elapsed * getProperty('cameraSpeed') * seconds(2)
	setProperty('curve.x', lerp(getProperty('curve.x'), 0, spd))
	setProperty('curve.y', lerp(getProperty('curve.y'), 0, spd))

	setShaderFloat('curve', 'curveX', getProperty('curve.x'))
	setShaderFloat('curve', 'curveY', getProperty('curve.y'))
end

function lerp(a, b, t)
	return a + (b - a) * t
end

function seconds(steps)
	return getPropertyFromClass('backend.Conductor', 'stepCrochet') / 1000 * steps
end

function setCameraShader(camera, shader)
	local cameraGet = "Type.resolveClass('psychlua.LuaUtils').cameraFromString('"..camera.."')"
	runHaxeCode(cameraGet..".setFilters([new ShaderFilter(game.createRuntimeShader('"..shader.."'))]);")
end

--addHScript('stages/opengl_imean_openfl')
import flixel.math.FlxMath;

var bg = new FlxSprite(-550, -300).loadGraphic(Paths.image('hombre_room'));
addBehindGF(bg);

game.initHScript(Paths.modFolders("cameramovesonnotehit.hx"));

var curve = {x: 0, y: 0};
var curveShader = {data: {curveX: {value: 0}, curveY: {value: 0}}};

function onCreatePost() {
	game.addCharacterToList('hombre', 'dad');

	if (!ClientPrefs.data.shaders)
		return;

	game.initLuaShader('wobbl');
	game.camGame.setFilters([new ShaderFilter(game.createRuntimeShader('wobbl'))]);

	game.initLuaShader('curve');
	game.camHUD.setFilters([new ShaderFilter(game.createRuntimeShader('curve'))]);
	curveShader = game.camHUD._filters[0].shader;
}

function doTween(u, should, kys, ?now) {
	game.modchartTweens.set(Math.random() + '', FlxTween.tween(u, should, kys, now));
}

var doCurveOnSectionHit = false;
var doCurveOnBeatHit = false;

function onBeatHit() {
	if (doCurveOnBeatHit)
		doCurve(null, seconds(2));
}
function onSectionHit() {
	if (doCurveOnSectionHit)
		doCurve(null, seconds(2));
}

function doCurve(?strength:Float = 0.15, ?duration:Float = 1) {
	if (strength == null) strength = 0.15;
	if (duration == null) duration = 0.15;

	if (FlxG.random.bool(50))
		strength *= -1;

	if ((game.ratingPercent != 0))
		strength *= rating; // if you have skill issue, then game will make weaker curves
	strength *= FlxG.random.float(0.75, 1); // and a bit of random ofc
	//             skill issue affects to it too
	var values = FlxG.random.bool(50) ? {y: strength} : {x: strength};

	game.health += FlxG.random.float(-strength, strength);
	game.health = Math.max(0.01, game.health);

	doTween(curve, values, duration);
}

function doFlash() {
	game.camOther.flash(0xffffff, seconds(16));
	game.health = FlxG.random.float(0.01, 2);
}
function onStepHit() {
	switch(curStep) {
		case 256:
			doFlash();
		case 512:
			doFlash();
		case 639:
			doCurveOnBeatHit = true;
		case 640:
			doFlash();
		case 669:
			doCurveOnBeatHit = false;
		case 672:
			doFlash();
		case 703:
			doCurveOnBeatHit = true;
		case 704:
			doFlash();
		case 733:
			doCurveOnBeatHit = false;
		case 736:
			doFlash();
		case 767:
			doCurveOnSectionHit = true;
		case 768:
			doFlash();
		case 1009:
			doCurveOnSectionHit = false;
		case 1024:
			doFlash();
			game.triggerEvent('Change Character', 'dad', 'hombre');
			game.cameraSpeed = 1.5;
		case 1280:
			doFlash();
		case 1407:
			doCurveOnBeatHit = true;
		case 1408:
			doFlash();
		case 1437:
			doCurveOnBeatHit = false;
		case 1440:
			doFlash();
		case 1471:
			doCurveOnBeatHit = true;
		case 1472:
			doFlash();
		case 1501:
			doCurveOnBeatHit = false;
		case 1504:
			doFlash();
	}
}

function onUpdate(elapsed) {
	var spd = 60 * elapsed * game.cameraSpeed * seconds(2);
	curve.x = FlxMath.lerp(curve.x, 0, spd);
	curve.y = FlxMath.lerp(curve.y, 0, spd);

	curveShader.data.curveX.value = [curve.x];
	curveShader.data.curveY.value = [curve.y];
}

function seconds(steps) {
	return Conductor.stepCrochet / 1000 * steps;
}

//game.initHScript(Paths.modFolders("stages/opengl_imean_openfl.hx"));
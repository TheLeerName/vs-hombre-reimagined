function onCreate() {}

function setMult(ct, red = 0, green = 0, blue = 0) {
	ct.redMultiplier = red;
	ct.greenMultiplier = green;
	ct.blueMultiplier = blue;
}

game.initLuaShader('dustglitch');
var glitch = game.createRuntimeShader('dustglitch');
glitch.setFloat('GLITCH_STRENGTH', 0);

var GAY = new FlxSprite(-100, 200).loadGraphic(Paths.image('problemo'));
GAY.scale.set(1, 1);
GAY.scrollFactor.set(0.9, 0.9);
addBehindGF(GAY);

game.initHScript(Paths.modFolders("cameramovesonnotehit.hx"));
setVar('cameraMoveStrength', 20);

var songLength_real = 0;
function onSongStart() {
	songLength_real = game.songLength;
	game.songLength = 125320;
}

var dadOffsetOrig = {x: 0, y: 0};
var dadShake = false;
var glitched = false;
// i can tween that as basic vars :( 
var t = {
	dadShakeVal: 10,
	glitchValue: 0
}
function onCreatePost() {
	setMult(game.dad.colorTransform, 1, 0.6, 0.6);
	setMult(game.boyfriend.colorTransform, 1, 0.5, 0.5);

	game.addCharacterToList('xci-p-fullscreen', 'dad');
}
function onStepHit() {
	switch(curStep) {
		case 1502:
			game.modchartTweens.set('afdsf', FlxTween.tween(game, {songLength: songLength_real}, 2));
		case 1536:
			game.triggerEvent('Change Character', 'dad', 'xci-p-fullscreen');
			dadShake = true;
			glitched = true;
			game.camHUD._filters.push(new ShaderFilter(glitch));
			GAY.shader = glitch;
			dadOffsetOrig = {x: game.dad.offset.x, y: game.dad.offset.y};
			setMult(game.dad.colorTransform, 1, 0.6, 0.6);
			game.boyfriendGroup.visible = false;
		case 1920:
			glitched = false;
			game.modchartTweens.set('dfghsdfg', FlxTween.tween(t, {glitchValue: 0}, 4), {ease: FlxEase.expoOut});
			game.modchartTweens.set('dfgashsdfg', FlxTween.tween(t, {dadShakeVal: 0}, 4, {ease: FlxEase.expoOut}));
	}
}

var time = 0;
function onUpdate(elapsed) {
	if (dadShake)
		game.dad.offset.set(dadOffsetOrig.x + FlxG.random.float(-t.dadShakeVal, t.dadShakeVal), dadOffsetOrig.y + FlxG.random.float(-t.dadShakeVal, t.dadShakeVal));

	if (glitched)
		t.glitchValue += elapsed / 2500;
	glitch.data.GLITCH_STRENGTH.value[0] = t.glitchValue;
	glitch.setFloat('iTime', time);

	time += elapsed;
}
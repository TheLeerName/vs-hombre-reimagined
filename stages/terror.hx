var bg = new FlxSprite(100, 200).loadGraphic(Paths.image('terror-bg'));
bg.scale.set(2.5, 2.5);
addBehindGF(bg);

game.initHScript(Paths.modFolders("cameramovesonnotehit.hx"));
setVar('cameraMoveStrength', 30);

var addcamspeed = .5;
function onSectionHit() {
	game.cameraSpeed = addcamspeed + Conductor.bpm / PlayState.SONG.bpm;
}

var dadshader = new FlxRuntimeShader("
	#pragma header
	void main() {
		#pragma body
		if (gl_FragColor.rgb != vec3(1, 0, 0))
			gl_FragColor.rgb *= 0.35;
	}
");
var bfshader = new FlxRuntimeShader("
	#pragma header
	void main() {
		#pragma body
		if (gl_FragColor.rgb != vec3(1))
			gl_FragColor.rgb *= 0.35;
	}
");

function onStepHit() {
	switch(curStep) {
		case 568:
			addcamspeed = -.25;
			onSectionHit();

			game.dad.shader = null;
			game.boyfriend.shader = null;
			FlxTween.tween(game.dad.colorTransform, {redOffset: 255, greenOffset: 255, blueOffset: 255}, 2);
			FlxTween.tween(game.boyfriend.colorTransform, {redOffset: 255, greenOffset: 255, blueOffset: 255}, 2);
			FlxTween.tween(bg.colorTransform, {redMultiplier: 0, greenMultiplier: 0, blueMultiplier: 0}, 2);
		case 640:
			addcamspeed = .5;
			onSectionHit();

			FlxTween.tween(game.dad.colorTransform, {redOffset: 0, greenOffset: 0, blueOffset: 0}, 0.25);
			FlxTween.tween(game.boyfriend.colorTransform, {redOffset: 0, greenOffset: 0, blueOffset: 0}, 0.25);
			FlxTween.tween(bg.colorTransform, {redMultiplier: 1, greenMultiplier: 1, blueMultiplier: 1}, 0.25, {onComplete: twn -> {
				game.dad.shader = dadshader;
				game.boyfriend.shader = bfshader;
			}});
	}
}

function onCreatePost() {
	//game.dad.colorTransform.redMultiplier = game.dad.colorTransform.greenMultiplier = game.dad.colorTransform.blueMultiplier = 0.5;
	game.dad.shader = dadshader;
	game.boyfriend.shader = bfshader;

	game.initLuaShader('vignette');
	FlxG.game.setFilters([new ShaderFilter(game.createRuntimeShader('vignette'))]);
}
var time:Float = 0;
function onUpdate(elapsed:Float) {
	time += elapsed;
	if (FlxG.game.filters[0] != null) FlxG.game.filters[0].shader.data.iTime.value = [time];
}

function onDestroy() {
	FlxG.game.setFilters([]);
}
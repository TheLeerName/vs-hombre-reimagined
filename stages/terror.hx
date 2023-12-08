var bg = new FlxSprite(100, 200).loadGraphic(Paths.image('terror-bg'));
bg.scale.set(2.5, 2.5);
addBehindGF(bg);

game.initHScript(Paths.modFolders("cameramovesonnotehit.hx"));
setVar('cameraMoveStrength', 30);

function onSectionHit() {
	game.cameraSpeed = .5 + Conductor.bpm / PlayState.SONG.bpm;
}

function onCreatePost() {
	//game.dad.colorTransform.redMultiplier = game.dad.colorTransform.greenMultiplier = game.dad.colorTransform.blueMultiplier = 0.5;
	game.dad.shader = new FlxRuntimeShader("
		#pragma header
		void main() {
			#pragma body
			if (gl_FragColor.rgb != vec3(1, 0, 0))
				gl_FragColor.rgb *= 0.35;
		}
	");

	game.boyfriend.shader = new FlxRuntimeShader("
		#pragma header
		void main() {
			#pragma body
			if (gl_FragColor.rgb != vec3(1))
				gl_FragColor.rgb *= 0.35;
		}
	");

	game.initLuaShader('vignette');
	FlxG.game.setFilters([new ShaderFilter(game.createRuntimeShader('vignette'))]);
}
var time:Float = 0;
function onUpdate(elapsed:Float) {
	time += elapsed;
	if (FlxG.game.filters != null) FlxG.game.filters[0].shader.data.iTime.value = [time];
}

function onDestroy() {
	FlxG.game.setFilters([]);
}
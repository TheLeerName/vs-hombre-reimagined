import backend.Conductor;

var bg = new FlxSprite().loadGraphic(Paths.image('train/bg'));
bg.scale.set(1.75, 1.5);
addBehindGF(bg);
var table = new FlxSprite().loadGraphic(Paths.image('train/table'));
table.scale.set(1.75, 1.5);
addBehindDad(table);
var handles = new FlxSprite().loadGraphic(Paths.image('train/handles'));
handles.scale.set(1.75, 1.5);
add(handles);

function onCreatePost() {
	game.camFollow.setPosition(500, 304);
	game.camGame.snapToTarget();

	game.remove(game.boyfriendGroup, true);
	game.insert(game.members.indexOf(table), game.boyfriendGroup);

	game.initLuaShader('curve');
	game.dad.shader = game.createRuntimeShader('curve');

	game.dad.useFramePixels = true;
	game.dad.shader.data.curveX.value = [0.1];
	game.dad.shader.data.curveY.value = [0.1];
	game.dad.angle = -5;
}
/*
function onUpdatePost(elapsed) {
	if (FlxG.mouse.wheel != 0) {
		if (FlxG.keys.pressed.SHIFT)
			game.boyfriend.shader.data.curveX.value[0] += FlxG.mouse.wheel / 100;
		else if (FlxG.keys.pressed.ALT)
			game.boyfriend.angle += FlxG.mouse.wheel;
		else
			game.boyfriend.shader.data.curveY.value[0] += FlxG.mouse.wheel / 100;
		trace(game.boyfriend.shader.data.curveX.value[0], game.boyfriend.angle, game.boyfriend.shader.data.curveY.value[0]);
	}
}
*/
import substates.GameOverSubstate;
import sys.FileSystem;

var lies = new FlxSprite(-400, -50).loadGraphic(Paths.image('bald'));
lies.scrollFactor.set(0.9, 0.9);
addBehindGF(lies);

var death = new FlxSprite(600, 350).loadGraphic(Paths.image('fuck'));
death.camera = game.camOther;
death.visible = false;
add(death);

game.initHScript(Paths.modFolders("cameramovesonnotehit.hx"));

function doTween(u, should, kys, ?now) {
	game.modchartTweens.set(Math.random() + '', FlxTween.tween(u, should, kys, now));
}
// WTF WHY FlxG.random.getObject IS NULL????????????????????????????????????
function getRandomObject(objects:Array) {
	return objects[FlxG.random.int(0, objects.length - 1)];
}
function hasBFNote() {
	for (note in game.notes) if (note.mustPress) return true;
	return false;
}

var defaultCS = game.cameraSpeed;
var doshitbeathitmother = true;
function onStepHit() {
	switch(curStep) {
		case 288:
			game.cameraSpeed = defaultCS * 2;
		case 544:
			game.cameraSpeed = defaultCS;
	}
}



var deathSounds = FileSystem.readDirectory(Paths.modFolders('sounds/gameover'));
for (i in 0...deathSounds.length) deathSounds[i] = 'gameover/' + deathSounds[i].substring(0, deathSounds[i].length - 4);
function onBeatHit() {
	if (game.camZooming && curBeat % 2 == 0)
		game.triggerEvent('Add Camera Zoom', 0.005, 0.03);

	if (FlxG.random.bool(25))
		doSlip(getRandomObject([game.dad, game.gf, game.boyfriend]));
	else if (!hasBFNote() && FlxG.random.bool(25))
		kys();
}
function kys() {
	var sound = FlxG.sound.play(Paths.sound(getRandomObject(deathSounds)));

	death.visible = true;
	game.camGame.alpha = 0.0001;
	game.camHUD.alpha = 0.0001;
	FlxG.sound.music.volume = game.vocals.volume = 0;
	FlxG.sound.music.exists = game.vocals.exists = false;

	var count = Math.max(Conductor.crochet, sound.length) / 1000;
	new FlxTimer().start(count, tmr -> {
		game.setSongTime(Conductor.songPosition - count);
		death.visible = false;
		game.camGame.alpha = 1;
		game.camHUD.alpha = 1;

		FlxG.sound.music.volume = game.vocals.volume = 1;
		FlxG.sound.music.exists = game.vocals.exists = true;
	});
}

function doSlip(obj) {
	var initX = obj.x;
	FlxG.sound.play(Paths.sound('slip'));
	doTween(obj, {x: initX + FlxG.random.int(-20, 20) * 10, angle: -720}, 0.35, {ease: FlxEase.linear, onComplete: twn -> {
		obj.x = initX;
		obj.angle = 0;
	}});
}


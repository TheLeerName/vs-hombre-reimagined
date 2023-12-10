import flixel.text.FlxText;
import flixel.math.FlxMath;

var text = "A NEW SONG HAS APPEARED IN FREEPLAY!";

var bg = new FlxSprite().loadGraphic(Paths.image('challenger'));
bg.camera = game.camOther;

var txt = new FlxText(100, 350, 0, text);
txt.setFormat(Paths.font('vcr.ttf'), 48);
txt.camera = game.camOther;

bg.setPosition(txt.x - 10, txt.y - 4);

var ended = false;
function onEndSong() {
	if (!ended) {
		ended = true;
		game.camGame.alpha = 0;
		game.camHUD.alpha = 0;
		new FlxTimer().start(2, tmr -> {
			add(bg);
			add(txt);

			FlxG.sound.play(Paths.sound('challenger'));

			new FlxTimer().start(4, tmr -> {
				game.KillNotes();
				game.endSong();
			});
		});
		return Function_Stop;
	}
}



var hue:Float = 0;
function onUpdate(elapsed) {
	hue += elapsed * 1000;
	hue %= 360;

	var clr = FlxColor.fromHSB(hue, 1, 1);
	bg.color = txt.color = clr;
}
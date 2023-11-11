var beats = [134, 138, 214, 218, 230, 234];
var doit = () -> {
	//trace('hi its ' + curBeat + ' beat');
	game.cameraSpeed = 2.25;
	game.moveCamera(PlayState.SONG.notes[game.curSection].mustHitSection);
};



var femboy = [0 => () -> {}];
for (beat in beats) femboy.set(beat, doit);

function onBeatHit() {
	if (femboy[game.curBeat] != null) femboy[game.curBeat]();
}

function onSectionHit() {
	game.cameraSpeed = 1.25;
}
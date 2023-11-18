setVar('cameraMoveStrength', 60);
var doit_onGhostTap:Bool = true;



var ballz = {x: 0, y: 0};

function setPosition(?x:Float = 0, ?y:Float = 0) {
	game.camFollow.setPosition(ballz.x + x, ballz.y + y);
}

function makeMove(noteData:Float) {
	var st = getVar('cameraMoveStrength');
	switch(noteData) {
		case 0: setPosition(-st);
		case 1: setPosition(0, st);
		case 2: setPosition(0, -st);
		case 3: setPosition(st);
	}
}

function onMoveCamera(who) {
	ballz.x = game.camFollow.x;
	ballz.y = game.camFollow.y;
}

function onKeyPress(key) {
	if (doit_onGhostTap)
		makeMove(key);
}

function goodNoteHit(note) {
	if (PlayState.SONG.notes[game.curSection].mustHitSection)
		makeMove(note.noteData);
}

function opponentNoteHit(note) {
	if (!PlayState.SONG.notes[game.curSection].mustHitSection)
		makeMove(note.noteData);
}
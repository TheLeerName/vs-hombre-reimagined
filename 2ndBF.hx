// Author: TheLeerName
// they cant sing together i know i dont need that
/* Example .hx script:
game.initHScript(Paths.modFolders('2ndBF.hx'));
var changeBF = getVar('changeBF');

changeBF(true); // if true then now playing 2nd bf
*/

function onCreate() {} // i love debugging so i put it here (game not printing "initialized sscript interp successfully" thing without this)

var bf2Name = PlayState.SONG.player1_2nd;
var bf2;
function onCountdownStarted() {
	game.addCharacterToList(bf2Name, 0);
	bf2 = game.boyfriendMap.get(bf2Name);
	bf2.alpha = 1;
    setVar('bf2', bf2);
}

function onCountdownTick(tick, swagCounter) {
	if (game.startTimer.loopsLeft % bf2.danceEveryNumBeats == 0 && bf2.animation.curAnim != null && !bf2.stunned)
		bf2.dance();
}

function onBeatHit() {
	if (curBeat % bf2.danceEveryNumBeats == 0 && bf2.animation.curAnim != null && !bf2.stunned)
		bf2.dance();
}

function changeBF(to2nd:Bool) {
	trace('now playing ' + (to2nd ? bf2Name : PlayState.SONG.player1) + '!');
	game.boyfriend = to2nd ? game.boyfriendMap.get(bf2Name) : game.boyfriendGroup.members[0];
	bf2 = to2nd ? game.boyfriendGroup.members[0] : game.boyfriendMap.get(bf2Name);
}
setVar('changeBF', changeBF);
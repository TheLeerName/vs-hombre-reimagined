var zooms = false;
var saveZoom = ClientPrefs.data.camZooms;

function onCreate() {}

function add(METH, LEAN) {
	game.camGame.zoom += METH * game.camZoomingMult;
	game.camHUD.zoom += LEAN * game.camZoomingMult;
}

function onEvent(n, v1, v2) {
	if (n == 'Add Camera Zoom' && saveZoom) {
		add(0.015, 0.03);
		return;
	}

	if (n != 'StepZoom') return;

	zooms = v1 == '1';
}

function onStepHit() {
	if (zooms && curStep % 6 == 0)
		add(0.015, 0.03);
}

ClientPrefs.data.camZooms = false;
function onDestroy() {
	ClientPrefs.data.camZooms = saveZoom;
	ClientPrefs.saveSettings();
}
FlxG.stage.window.onClose(onDestroy);
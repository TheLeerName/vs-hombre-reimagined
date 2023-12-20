var zooms = false;
var strength = 250;

function onEvent(n, v1, v2) {
	if (n != 'BlurZoom') return;

	zooms = v1 == '1';
	trace(zooms);
}

game.initLuaShader('zoomblur');

var zoomblur = game.createRuntimeShader('zoomblur');
var camshaders = [new ShaderFilter(zoomblur)];
game.camGame.setFilters(camshaders);
game.camHUD.setFilters(camshaders);

function onCreate() {}

function onUpdatePost(elapsed) {
	zoomblur.setFloat('focusPower', zooms ? ((game.camHUD.zoom - 1) * strength) : 0);
}
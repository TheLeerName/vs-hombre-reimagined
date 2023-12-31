var bg = new FlxSprite(-330, -250).loadGraphic(Paths.image('BGbruj'));
bg.scale.set(1.75, 1.75);
bg.scrollFactor.set(0.95, 0.95);
addBehindGF(bg);

game.initHScript(Paths.modFolders("cameramovesonnotehit.hx"));
setVar('cameraMoveStrength', 30);

function setColorTransformOffset(colorTransform, red:Float, green:Float, blue:Float) {
	colorTransform.redOffset = red;
	colorTransform.greenOffset = green;
	colorTransform.blueOffset = blue;
}

function onCreatePost() {
	setColorTransformOffset(game.gf.colorTransform, 75, 75, 75);
}
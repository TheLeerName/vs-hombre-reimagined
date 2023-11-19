var bg = new FlxSprite(-330, -250).loadGraphic(Paths.image('BGbruj'));
bg.scale.set(1.75, 1.75);
addBehindGF(bg);

game.initHScript(Paths.modFolders("cameramovesonnotehit.hx"));
setVar('cameraMoveStrength', 30);
var bg = new FlxSprite(-300, -300).loadGraphic(Paths.image('BGsubway'));
bg.scale.set(2, 2);
addBehindGF(bg);

game.initHScript(Paths.modFolders("cameramovesonnotehit.hx"));
setVar('cameraMoveStrength', 40);
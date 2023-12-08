import backend.StageData;

var bg = new FlxSprite(-500, -500).loadGraphic(Paths.image('xci-bg'));
bg.scale.set(1, 0.75);
addBehindGF(bg);

game.initHScript(Paths.modFolders("cameramovesonnotehit.hx"));
setVar('cameraMoveStrength', 40);

game.initLuaShader('static');
game.camGame._filters = game.camHUD._filters = [new ShaderFilter(game.createRuntimeShader('static'))];

var statics = {alpha: 0};

game.initHScript(Paths.modFolders('2ndBF.hx'));
var bf2; // will be initialized in onCreatePost()
var bf2XOffset = 400;

function onChangeBF(val:Bool) {
	game.boyfriendCameraOffset = StageData.getStageFile(PlayState.curStage).camera_boyfriend;
	if (val)
		game.boyfriendCameraOffset[0] -= bf2XOffset;
}

var changeBF = val -> {
	getVar('changeBF')(val);
	onChangeBF(val);
};

function setColorTransformMult(colorTransform, red:Float, green:Float, blue:Float) {
	colorTransform.redMultiplier = red;
	colorTransform.greenMultiplier = green;
	colorTransform.blueMultiplier = blue;
}

function onCreatePost() {
	bf2 = getVar('bf2');
	bf2.x += bf2XOffset;

	// changing some gamma
	game.dad.shader = new FlxRuntimeShader("
		#pragma header
		void main() {
			#pragma body
			vec4 color256 = floor(gl_FragColor * 255);
			if (color256.rgb != vec3(255, 0, 0) && color256.rgb != vec3(87, 65, 51))
				gl_FragColor.rgb *= 0.5;
		}
	");
	game.gf.shader = new FlxRuntimeShader("
		#pragma header
		void main() {
			#pragma body
			if (gl_FragColor.rgb != vec3(1, 84. / 255., 147. / 255.))
				gl_FragColor.rgb *= 0.5;
			else
				gl_FragColor.rgb *= 0.75;
		}
	");
	game.boyfriend.shader = new FlxRuntimeShader("
		#pragma header
		void main() {
			#pragma body
			vec4 color256 = floor(gl_FragColor * 255);
			if (color256.r <= 140 && color256.g >= 230 && color256.b >= 230)
			{
			}
			else
				gl_FragColor.rgb *= 0.5;
		}
	");
	bf2.shader = new FlxRuntimeShader("
		#pragma header
		void main() {
			#pragma body
			if (gl_FragColor.rgb != vec3(1))
				gl_FragColor.rgb *= 0.8;
		}
	");
	
	game.cameraSpeed = 0.75;
}

function onCreate() {} // i love debugging so i put it here (game not printing "initialized sscript interp successfully" thing without this)

// 368
function onStepHit() {
	switch(curStep) {
		case 372:
			salphatwn(0.5, 12);
		case 384:
			game.cameraSpeed = 1;
			salphatwn(0, 8);
		case 500:
			salphatwn(0.5, 12);
		case 512:
			salphatwn(0, 2);
		case 528:
			game.cameraSpeed = 2;
		case 580:
			salphatwn(0.5, 12);
		case 592:
			salphatwn(0, 2);
		case 656:
			arrowsbounce();
		case 664:
			arrowsbounce();
		case 672:
			arrowsbounce();
		case 680:
			arrowsbounce();
		case 720:
			arrowsbounce();
		case 728:
			arrowsbounce();
		case 736:
			arrowsbounce();
		case 744:
			arrowsbounce();
		case 768:
			salphatwn(0.5, 8);
		case 776:
			salphatwn(0, 2);
		case 784:
			game.cameraSpeed = 1;
		case 798:
			changeBF(true);
		case 1028:
			salphatwn(0.5, 12);
		case 1040:
			salphatwn(0, 8);
			game.cameraSpeed = 1.5;
		case 1102:
			changeBF(false);
		case 1168:
			game.cameraSpeed = 1;
		case 1230:
			changeBF(true);
		case 1268:
			salphatwn(0.5, 8);
		case 1280:
			salphatwn(0, 2);
		case 1296:
			game.cameraSpeed = 1.5;
		case 1342:
			changeBF(false);
		case 1422:
			changeBF(true);
		case 1486:
			changeBF(false);
		case 1550:
			changeBF(true);
		case 1552:
			game.cameraSpeed = 1;
	}
}

var bounced = false;
function arrowsbounce() {
	var duration = seconds(2);
	twn(game, {health: FlxG.random.float(0.01, 1.99)}, seconds(1));
	reloadHealthBar(!bounced);
	for (note in game.strumLineNotes) {
		var initY = note.y;
		var initAngle = note.angle;
		twn(note, {y: note.y - 40 - FlxG.random.int(-10, 50), angle: note.angle + FlxG.random.int(-90, 90)}, duration, {
			ease: FlxEase.backOut,
			onComplete: t -> {
				twn(note, {y: initY, angle: initAngle}, duration, {ease: FlxEase.backOut});
			}
		});
	}
	bounced = !bounced;
	for (obj in [game.healthBar, game.iconP1, game.iconP2, game.scoreTxt, game.botplayTxt, game.timeBar, game.timeTxt]) {
		var initY = obj.y;
		var initAngle = obj.angle;
		twn(obj, {y: obj.y - 40 - FlxG.random.int(-10, 80), angle: obj.angle + FlxG.random.int(-20, 20)}, duration, {
			ease: FlxEase.backOut,
			onComplete: t -> {
				twn(obj, {y: initY, angle: initAngle}, duration, {ease: FlxEase.backOut});
			}
		});
	}
}

function reloadHealthBar(reversed:Bool = false) {
	var clrs = [FlxColor.fromRGB(game.dad.healthColorArray[0], game.dad.healthColorArray[1], game.dad.healthColorArray[2]),
	FlxColor.fromRGB(game.boyfriend.healthColorArray[0], game.boyfriend.healthColorArray[1], game.boyfriend.healthColorArray[2])];
	var icons = [game.dad.healthIcon, game.boyfriend.healthIcon];
	if (reversed) {
		clrs = [clrs[1], clrs[0]];
		icons = [icons[1], icons[0]];
	}
	game.healthBar.setColors(clrs[0], clrs[1]);
	game.iconP2.changeIcon(icons[0]);
	game.iconP1.changeIcon(icons[1]);
}

function salphatwn(value:Float, durationInSteps:Float, ?options:Dynamic) {
	var duration = seconds(durationInSteps);
	twn(game.camGame, {zoom: game.camGame.zoom + value}, duration, options);
	twn(game, {health: value + 0.01}, duration, options);
	return twn(statics, {alpha: value}, duration, options);
}

function twn(obj:Dynamic, val:Dynamic, ?duration:Float = 1, ?options:Dynamic) {
	var tween = FlxTween.tween(obj, val, duration, options);
	game.modchartTweens.set(Math.random() + '', tween);
	return tween;
}

var asd = false;
var time = 0;
function onUpdate(elapsed) {
	time += elapsed;
	game.camGame._filters[0].shader.data.ALPHA.value = [statics.alpha];
	game.camGame._filters[0].shader.data.SIZE.value = [5 + statics.alpha * 10, 5 + statics.alpha * 10];
	game.camGame._filters[0].shader.data.iTime.value = [time];
}

function seconds(?steps:Int = 1) {
	return Conductor.stepCrochet / 1000 * steps;
}
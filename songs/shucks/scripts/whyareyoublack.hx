var chairSprites = []; // chair

function postCreate() {
	for (obj in FlxG.state.stage.stageSprites.keys())
		FlxG.state.stage.stageSprites.get(obj).visible = false;

	for (i => char in strumLines.members[1].characters)
		if (i != 1)
			char.visible = false;
		else
			char.visible = true;

	for (i => char in strumLines.members[2].characters)
		char.visible = false;

	for (i => char in strumLines.members[0].characters)
		if (i != 1)
			char.visible = false;
		else
			char.visible = true;

	var chairBG = new FlxSprite(1500, -210).loadGraphic(Paths.image("bg/shuck/shuckchairbg"));
	chairBG.setGraphicSize(chairBG.width * 3.5);
	chairBG.updateHitbox();
	chairSprites.push(chairBG);
	insert(0, chairBG);

	var chairFG = new FlxSprite(1000, -250).loadGraphic(Paths.image("bg/shuck/shuckchairfg"));
	chairFG.setGraphicSize(chairBG.width * 2.5);
	chairSprites.push(chairFG);
	add(chairFG);

	for (obj in chairSprites)
		obj.visible = false;

	new FlxTimer().start(30, function(timer) {
		cleanupUnusedBitmaps();
		timer.reset(); // Repeat
	});
}

function cleanupUnusedBitmaps() {
	// Clean chair sprites if not visible
	for (obj in chairSprites) {
		if (!obj.visible && obj.bitmapData != null) {
			obj.bitmapData.dispose();
			obj.bitmapData = null;
		}
	}

	// Clean invisible characters from all strum lines
	for (line in strumLines.members) {
		for (char in line.characters) {
			if (!char.visible && char.frames != null && char.frames.bitmap != null) {
				char.frames.bitmap.dispose();
				char.frames.bitmap = null;
				char.frames = null;
			}
		}
	}
}


function postUpdate(elapsed) {
	if (curStep == 2000)
		dad.debugMode = true;
	if (curStep == 2200)
		dad.debugMode = false;
}

function nightmareMarvin() {
	for (i => char in strumLines.members[1].characters)
		if (i != 2)
			char.visible = false;
		else
			char.visible = true;
}

function lightsOnFirst() {
	for (obj in FlxG.state.stage.stageSprites.keys())
		FlxG.state.stage.stageSprites.get(obj).visible = true;

	camHUD.flash();
	camHUD.alpha = 1;

	for (i => char in strumLines.members[1].characters)
		if (i != 0)
			char.visible = false;
		else
			char.visible = true;

	for (i => char in strumLines.members[2].characters)
		if (i != 0)
			char.visible = false;
		else
			char.visible = true;

	for (i => char in strumLines.members[0].characters)
		if (i != 0)
			char.visible = false;
		else
			char.visible = true;
}

function lightsOnSecond() {
	for (obj in FlxG.state.stage.stageSprites.keys())
		FlxG.state.stage.stageSprites.get(obj).visible = true;

	camHUD.flash();
	camHUD.alpha = 1;

	for (i => char in strumLines.members[1].characters)
		if (i != 0)
			char.visible = false;
		else
			char.visible = true;

	for (i => char in strumLines.members[0].characters)
		if (i != 0)
			char.visible = false;
		else
			char.visible = true;
}

function shutUpMF() {
	gf.visible = false;

	for (i => char in strumLines.members[0].characters)
		if (i == 2) {
			char.visible = true;
			char.playAnim("gay", true); // looped
		} else
			char.visible = false;

	for (i => char in strumLines.members[1].characters)
		if (i == 4) {
			char.visible = true;
			char.playAnim("gay", true); // looped
		} else {
			char.visible = false;
		}

	FlxTween.tween(camHUD, {alpha: 0}, 0.35);

	new FlxTimer().start(3.0, function(_) {
		gf.visible = true;

		for (i => char in strumLines.members[0].characters)
			char.visible = true;

		for (i => char in strumLines.members[1].characters)
			char.visible = true;

		FlxTween.tween(camHUD, {alpha: 1}, 0.35);
	});
}

function deadWoman() {
	for (obj in FlxG.state.stage.stageSprites.keys())
		FlxG.state.stage.stageSprites.get(obj).visible = true;

	camHUD.flash();
	camHUD.alpha = 1;

	// Show GF at index 1, hide others
	for (i => char in strumLines.members[2].characters)
		char.visible = (i == 1);

	for (i => char in strumLines.members[1].characters)
		char.visible = (i == 5);
}


function dingleBerry() {
	for (obj in FlxG.state.stage.stageSprites.keys())
		FlxG.state.stage.stageSprites.get(obj).kill();

	camHUD.flash();
	camHUD.alpha = 1;

	defaultCamZoom = 0.4;

	for (i => char in strumLines.members[1].characters)
		if (i != 3)
			char.visible = false;
		else
			char.visible = true;

	for (i => char in strumLines.members[2].characters)
		char.visible = false;

	for (i => char in strumLines.members[0].characters)
		if (i != 3)
			char.visible = false;
		else
			char.visible = true;

	for (obj in chairSprites)
		obj.visible = true;
}
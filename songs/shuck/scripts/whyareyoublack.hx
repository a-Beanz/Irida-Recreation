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
}

function postUpdate(elapsed) {
    if (curStep == 2000)
        dad.debugMode = true;
    if (curStep == 2200)
        dad.debugMode = false;
}

function lightsOn() {
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

function shutUpMF() {
    gf.visible = false;

    for (i => char in strumLines.members[0].characters)
        if (i == 2) {
            char.visible = true;
            char.playAnim("gay");
        } else
            char.visible = false;

    FlxTween.tween(camHUD, {alpha: 0}, 0.35);
}

function dingleBerry() {
    trace(FlxG.state.stage.stageSprites);

    for (obj in FlxG.state.stage.stageSprites.keys())
	FlxG.state.stage.stageSprites.get(obj).kill();

    camHUD.flash();
    camHUD.alpha = 1;

    defaultCamZoom += 0.25;

    for (i => char in strumLines.members[1].characters)
        if (i != 2)
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
}
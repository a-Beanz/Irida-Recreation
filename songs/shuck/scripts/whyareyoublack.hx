var black;

function postCreate() {
    insert(5, black = new FlxSprite().makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.BLACK));

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
    black.kill();

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
    camHUD.flash();
    camHUD.alpha = 1;
    
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
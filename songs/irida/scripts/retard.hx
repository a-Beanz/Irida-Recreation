var bg:FlxSprite; // so we can get rid of this garbage when we're done using it.
var floor:FlxSprite;

function postCreate() {
    for (obj in FlxG.state.stage.stageSprites.keys())
        FlxG.state.stage.stageSprites.get(obj).visible = false;

    defaultCamZoom += 0.3;

    bg = new FlxSprite().loadGraphic(Paths.image("bg/irida/irida1bg"));
    bg.updateHitbox();
    bg.scale.set(2, 2);
    insert(1, bg);

    floor = new FlxSprite(0, -50).loadGraphic(Paths.image("bg/irida/irida1piano"));
    floor.scale.set(2, 2);
    insert(1, floor);

    for (i => char in strumLines.members[0].characters) {
        if (i != 1)
            char.visible = false;
        else {
            char.x -= 150;
            char.y -= 85;
            char.cameraOffset.y -= 50;
            char.visible = true;
        }
    }

    for (i => char in strumLines.members[1].characters) {
        if (i != 1)
            char.visible = false;
        else {
            char.x += 150;
            char.y -= 85;
            char.cameraOffset.x -= 400;
            char.cameraOffset.y -= 75;
            char.visible = true;
        }
    }
}

function fuck() {
    defaultCamZoom = 0.6;
   camGame.zoom = 0.6;

    for (obj in FlxG.state.stage.stageSprites.keys())
        FlxG.state.stage.stageSprites.get(obj).visible = true;

    // FUCK i have to manually position them now...
    for (i => char in strumLines.members[0].characters) { // bootleg jerry
        if (i == 0) {
            char.visible = true;
            char.x = 100;
            char.y = -50;
        } else {
            char.visible = false;
        }
    }

    for (i => char in strumLines.members[1].characters) { // marbips
        if (i == 0) {
            char.visible = true;
            char.x = 900;
            char.y = 200;
        } else {
            char.visible = false;
        }
    }

    if (bg != null)
        remove(bg, true);
    if (floor != null)
        remove(floor, true);
}
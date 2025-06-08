import funkin.backend.FunkinSprite;

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

function animated() {
    for (obj in FlxG.state.stage.stageSprites.keys())
        FlxG.state.stage.stageSprites.get(obj).visible = false;

    var altBG = new FlxSprite().loadGraphic(Paths.image("bg/irida/Boom"));
    altBG.updateHitbox();
    altBG.scale.set(1.25, 1.25);
   defaultCamZoom = 0.6;
   camGame.zoom = 0.6;

    altBG.x = -350;
    altBG.y = -350;

    insert(2, altBG);

    for (i => char in strumLines.members[0].characters) { // animated jeffy
        if (i != 0)
            char.visible = false;
        else {
            char.x -= -1500;
            char.y -= 20;
            char.visible = true;
        }
    }

    for (i => char in strumLines.members[1].characters) { //animated marbips
        if (i != 0)
            char.visible = false;
        else {
            char.x += -600;
            char.y -= 350;
            char.visible = true;
        }
    }
}


function transition() {
    for (obj in FlxG.state.stage.stageSprites.keys())
        FlxG.state.stage.stageSprites.get(obj).visible = false;

    var transition:FunkinSprite = new FunkinSprite();
    
    transition.loadSprite("images/bg/irida/Pianoportal");

    transition.addAnim("idle", "ezgif-3-c33f84cd69", 24, true);

    transition.addOffset("idle", 53, 13);

    transition.playAnim("idle");

    transition.scale.set(2.50, 2.50);
    transition.updateHitbox();
    transition.screenCenter();
    
    insert(3, transition);
}



function fuck() {
    defaultCamZoom = 0.5;
   camGame.zoom = 0.5;

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

function maybeswapstrums() {
    var opponentStrumline = strumLines.members[0];
    var playerStrumline = strumLines.members[1];

    var tempX = opponentStrumline.x;
    opponentStrumline.x = playerStrumline.x;
    playerStrumline.x = tempX;
}





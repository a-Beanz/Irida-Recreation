function postCreate() {
    for (obj in FlxG.state.stage.stageSprites.keys())
		FlxG.state.stage.stageSprites.get(obj).visible = false;

    defaultCamZoom += 0.3;

    var bg = new FlxSprite().loadGraphic(Paths.image("bg/irida/irida1bg"));
    bg.updateHitbox();
    bg.scale.set(2, 2);
    insert(1, bg);

    var floor = new FlxSprite(0, -50).loadGraphic(Paths.image("bg/irida/irida1piano"));
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
    defaultCamZoom -= 0.3;

    for (obj in FlxG.state.stage.stageSprites.keys())
		FlxG.state.stage.stageSprites.get(obj).visible = true;

    for (i => char in strumLines.members[0].characters)
		if (i != 0)
			char.visible = false;
		else
			char.visible = true;

    for (i => char in strumLines.members[1].characters)
		if (i != 0)
			char.visible = false;
		else
			char.visible = true;
}
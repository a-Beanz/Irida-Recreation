var iridaHealthBar;

function postCreate() {
    iridaHealthBar = new FlxSprite(0, healthBar.y - 95).loadGraphic(Paths.image("game/iridaHealthBar"));
    iridaHealthBar.cameras = [camHUD];
    insert(FlxG.state.members.indexOf(iconP1), iridaHealthBar);

    healthBar.setGraphicSize(iridaHealthBar.width * 0.8, 20);
}

function postUpdate(elapsed) {
    iconP1.setPosition(iridaHealthBar.width * 0.84, iridaHealthBar.y + 15);
    iconP2.setPosition(iridaHealthBar.width * 0.05, iridaHealthBar.y);
}
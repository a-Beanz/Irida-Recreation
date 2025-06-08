import flixel.FlxCamera;
import funkin.backend.utils.WindowUtils;

var iridaHealthBar;
var scoreTxtPos = [250, 0, -250];
var shouldFlipHealthBar = false;

function create() {
	// No Irida song has a countdown
	introLength = 0;
}

function postCreate() {
	iridaHealthBar = new FlxSprite(0, healthBar.y - 95).loadGraphic(Paths.image("game/iridaHealthBar"));
	iridaHealthBar.cameras = [camHUD];
	insert(FlxG.state.members.indexOf(iconP1), iridaHealthBar);

	healthBar.setGraphicSize(iridaHealthBar.width * 0.8, 20);

	for (i => txt in [accuracyTxt, missesTxt, scoreTxt]) {
		txt.clearFormats();
		txt.font = Paths.font("Mario Font.ttf");
		txt.color = 0xFF8B0000;
		txt.borderColor = 0xFF3E0408;
		txt.size += 5;
		txt.x = scoreTxtPos[i];
		txt.y -= 5;
		txt.fieldWidth = iridaHealthBar.width;
	}

	WindowUtils.suffix = " - " + FlxG.state.SONG.meta.displayName;
	WindowUtils.updateTitle();
}

function postUpdate(elapsed) {
	var icon1PosX = iridaHealthBar.width * 0.84;
	var icon2PosX = iridaHealthBar.width * 0.05;

	if (shouldFlipHealthBar) {
		iconP1.setPosition(icon2PosX, iridaHealthBar.y + 15);
		iconP2.setPosition(icon1PosX, iridaHealthBar.y);
	} else {
		iconP1.setPosition(icon1PosX, iridaHealthBar.y + 15);
		iconP2.setPosition(icon2PosX, iridaHealthBar.y);
	}

	healthBar.flipX = shouldFlipHealthBar;
}

function onGamePause(e) {
	e.cancel();
	persistentUpdate = false;
	persistentDraw = true;
	paused = true;

	openSubState(new ModSubState("IridaPause"));
	updateDiscordPresence();
}

function swapIcons() { // function for hscript to call for swapping icons in certian songs.
	shouldFlipHealthBar = true;
}

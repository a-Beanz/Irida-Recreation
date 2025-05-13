import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import funkin.backend.utils.WindowUtils;
import flixel.group.FlxTypedSpriteGroup;

var menuItems = [
    {
        "name": "Resume",
        onPress: function() {
            camera.destroy();
            FlxG.state.closeSubState();
            WindowUtils.prefix = "";
            WindowUtils.updateTitle();
        }
    },
    {
        "name": "Restart Song",
        onPress: function() {
            FlxG.resetState();
        }
    },
    {
        "name": "Exit To Menu",
        onPress: function() {
            FlxG.state.endSong();
        }
    }
];

var menuObjects:Array<FlxTypedSpriteGroup> = [];
var menuTexts:Array<FlxText> = [];

var curSelected:Int = 0;
var canMove:Bool = true;

// UI elements that need repositioning on resize
var left:FlxSprite;
var right:FlxSprite;
var bottom:FlxSprite;
var render:FlxSprite;
var pauseCam:FlxCamera;

var lastWidth:Int = 0;
var lastHeight:Int = 0;

function create() {
    pauseCam = new FlxCamera();
    FlxG.cameras.add(pauseCam, false);
    pauseCam.bgColor = 0x8b000000;
    camera = pauseCam;

    left = new FlxSprite(-5000).loadGraphic(Paths.image("pause/left"));
    FlxTween.tween(left, {x: 0}, 0.5, {ease: FlxEase.circInOut});
    add(left);

    right = new FlxSprite(5000).loadGraphic(Paths.image("pause/right"));
    FlxTween.tween(right, {x: FlxG.width * 0.6}, 0.5, {ease: FlxEase.circInOut});
    add(right);

    var songName = FlxG.state.SONG.meta.name.toLowerCase();
    render = new FlxSprite(FlxG.width * 0.4, 5000).loadGraphic(Paths.image("pause/renders/" + songName));
    render.setGraphicSize(666, 580);
    render.updateHitbox();
    FlxTween.tween(render, {y: FlxG.height * 0.25}, 0.6, {ease: FlxEase.quartInOut});
    add(render);

    bottom = new FlxSprite(FlxG.width * 0.4, 5000).loadGraphic(Paths.image("pause/bottom"));
    FlxTween.tween(bottom, {y: FlxG.height * 0.9}, 0.6, {ease: FlxEase.quartInOut});
    add(bottom);

    for (i => item in menuItems) {
        var group = new FlxTypedSpriteGroup(-5000, 120 + (i * 190));
        menuObjects.push(group);
        add(group);

        var obj = new FlxSprite().loadGraphic(Paths.image("pause/button"));
        group.add(obj);

        var text = new FlxText(50, 40, obj.width, item.name, 32);
        text.font = Paths.font("NES.ttf");
        menuTexts.push(text);
        group.add(text);
    }

    updateTextColors();

    lastWidth = FlxG.width;
    lastHeight = FlxG.height;

    WindowUtils.prefix = "Paused - ";
    WindowUtils.updateTitle();

    // Optional: Register resize signal
    // FlxG.signals.resize.add(onResize);
}

function update(elapsed) {
    if (FlxG.width != lastWidth || FlxG.height != lastHeight) {
        lastWidth = FlxG.width;
        lastHeight = FlxG.height;
        onResize();
    }

    for (i => obj in menuObjects) {
        if (i == curSelected)
            obj.x = FlxMath.lerp(obj.x, 0, 0.35 * elapsed * 60);
        else
            obj.x = FlxMath.lerp(obj.x, -35, 0.35 * elapsed * 60);
    }

    if (controls.UP_P)
        changeSelection(-1);
    if (controls.DOWN_P)
        changeSelection(1);
    if (controls.ACCEPT)
        menuItems[curSelected].onPress();
}

function onResize() {
    if (pauseCam != null) {
        pauseCam.setSize(FlxG.width, FlxG.height);
        pauseCam.updateFlashOffset(); // Fixes engine-side crash on resize
    }

    if (right != null)
        right.x = FlxG.width * 0.6;

    if (bottom != null)
        bottom.setPosition(FlxG.width * 0.4, FlxG.height * 0.9);

    if (render != null && bottom != null)
        render.setPosition(bottom.x, FlxG.height * 0.25);
}

function changeSelection(amt:Int = 0) {
    curSelected = FlxMath.wrap(curSelected + amt, 0, menuItems.length - 1);
    updateTextColors();
    trace(curSelected);
}

function updateTextColors() {
    for (i in 0...menuTexts.length) {
        menuTexts[i].color = (i == curSelected) ? FlxColor.RED : FlxColor.GRAY;
    }
}

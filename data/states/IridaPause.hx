import flixel.FlxCamera;
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

var menuObjects = [];

var curSelected:Int = 0;
var canMove:Bool = true;

function create() {
    var pauseCam = FlxG.cameras.add(new FlxCamera(), false);
    pauseCam.bgColor = 0x8b000000;
    camera = pauseCam;

    var left = new FlxSprite(-5000).loadGraphic(Paths.image("pause/left"));
    FlxTween.tween(left, {x: 0}, 0.5, {ease: FlxEase.circInOut});
    add(left);

    var right = new FlxSprite(5000).loadGraphic(Paths.image("pause/right"));
    FlxTween.tween(right, {x: FlxG.width * 0.6}, 0.5, {ease: FlxEase.circInOut});
    add(right);

    var bottom = new FlxSprite(FlxG.width * 0.4, 5000).loadGraphic(Paths.image("pause/bottom"));
    FlxTween.tween(bottom, {y: FlxG.height * 0.9}, 0.6, {ease: FlxEase.quartInOut});

    var render = new FlxSprite(bottom.x, 5000).loadGraphic(Paths.image("pause/renders/" + FlxG.state.SONG.meta.name.toLowerCase()));
    FlxTween.tween(render, {y: FlxG.height * 0.25}, 0.6, {ease: FlxEase.quartInOut});
    render.setGraphicSize(666, 580);
    render.updateHitbox();
    add(render);

    for (i => item in menuItems) {
        var group = new FlxTypedSpriteGroup(-5000, 120 + (i * 200));
        menuObjects.push(group);
        add(group);

        var obj = new FlxSprite().loadGraphic(Paths.image("pause/button"));
        group.add(obj);

        var text = new FlxText(50, 40, obj.width, item.name, 50);
        text.font = Paths.font("Mario Font.ttf");
        text.color = FlxColor.RED;
        group.add(text);
    }

    add(bottom);

    WindowUtils.prefix = "Paused - ";
    WindowUtils.updateTitle();        
}

function update(elapsed) {
    for (i => obj in menuObjects)
        if (i == curSelected)
            obj.x = FlxMath.lerp(obj.x, 0, 0.35 * elapsed * 60);
        else
            obj.x = FlxMath.lerp(obj.x, -35, 0.35 * elapsed * 60);

    if (controls.UP_P)
        changeSelection(-1);
    if (controls.DOWN_P)
        changeSelection(1);
    if (controls.ACCEPT)
        menuItems[curSelected].onPress();
}

function changeSelection(amt:Int = 0) {
    curSelected = FlxMath.wrap(curSelected + amt, 0, menuItems.length - 1);
    trace(curSelected);
}
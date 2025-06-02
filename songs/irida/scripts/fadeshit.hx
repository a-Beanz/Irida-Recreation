var fadeInSpeed:Float = 1.8;
var fadeOutSpeed:Float = 1.0;

var blackScreen:FlxSprite = null;
var fadeOverlayCam:FlxCamera = null;
var isFading:Bool = false;
var fadeTween:FlxTween = null;

function create() {
    fadeOverlayCam = new FlxCamera();
    fadeOverlayCam.bgColor = 0x00000000;
    FlxG.cameras.add(fadeOverlayCam, false);

    blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackScreen.scrollFactor.set();
    blackScreen.alpha = 0;

    blackScreen.cameras = [fadeOverlayCam];

    add(blackScreen);
}

function fade() {
    isFading = true;
    if (fadeTween != null) fadeTween.cancel();

    fadeTween = FlxTween.tween(blackScreen, {alpha: 1}, fadeInSpeed, {
        ease: FlxEase.linear
    });
}

function endFade(fadeOutSpeedStr:String) {
    if (isFading) {
        isFading = false;
        var fadeOutSpeed:Float = Std.parseFloat(fadeOutSpeedStr);

        if (Math.isNaN(fadeOutSpeed) || fadeOutSpeed <= 0) {
            fadeOutSpeed = 1.0;
        }

        FlxTween.tween(blackScreen, {alpha: 0}, fadeOutSpeed, {
            ease: FlxEase.linear
        });
    }
}

import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import funkin.backend.utils.WindowUtils;
import flixel.system.FlxSound;
import flixel.input.keyboard.FlxKey;
import funkin.backend.MusicBeatState;

var pauseCam:FlxCamera;
var flashCam:FlxCamera;

var bg1:FlxSprite;
var bg2:FlxSprite;
var warning:FlxSprite;
var enterImage:FlxSprite;
var logoImage:FlxSprite;
var topImage:FlxSprite;
var topImage2:FlxSprite;
var bottomImage:FlxSprite;
var bottomImage2:FlxSprite;

var flashImage:FlxSprite;
var selectSound:FlxSound;

var lastWidth:Int;
var lastHeight:Int;
var showBG:Bool = false;
var imagesSlidingInDone:Bool = false;
var warningSound:FlxSound;
var menuSound:FlxSound;

var BPM:Int = 76;
var beatTimer:Float = 0;
var beatInterval:Float = 60 / BPM;

var enterPressed:Bool = false;

function create() {
    warningSound = FlxG.sound.load(Paths.music('Warning'));
    menuSound = FlxG.sound.load(Paths.music('freakyMenu'));
    selectSound = FlxG.sound.load(Paths.sound('menu/confirm'));

    warningSound.play();

    pauseCam = new FlxCamera();
    flashCam = new FlxCamera();
    flashCam.bgColor = 0x00000000;
    flashCam.setFilters([]);
    flashCam.zoom = 1;

    FlxG.cameras.add(pauseCam, false);
    FlxG.cameras.add(flashCam, true);

    pauseCam.bgColor = 0xFF000000;
    camera = pauseCam;

    warning = new FlxSprite().loadGraphic(Paths.image("MenuAssets/WARNING"));
    warning.alpha = 0;
    warning.screenCenter();
    add(warning);

    FlxTween.tween(warning, {alpha: 1}, 1, {
        ease: FlxEase.quadOut,
        onComplete: function(_) {
            FlxTween.tween(warning, {alpha: 0}, 1, {
                startDelay: 7,
                ease: FlxEase.quadIn,
                onStart: function(_) {
                    FlxTween.tween(warningSound, {volume: 0}, 1);
                },
                onComplete: function(_) {
                    remove(warning);
                    startScrollingBG();
                }
            });
        }
    });

    enterImage = new FlxSprite(-FlxG.width, 0).loadGraphic(Paths.image("MenuAssets/enter"));
    enterImage.alpha = 0;
    enterImage.scale.set(1, 1);

    logoImage = new FlxSprite(FlxG.width, 0).loadGraphic(Paths.image("MenuAssets/Logo"));
    logoImage.alpha = 0;
    logoImage.scale.set(1, 1);

    topImage = new FlxSprite(0, -FlxG.height).loadGraphic(Paths.image("MenuAssets/top"));
    topImage.scrollFactor.set(0, 0);
    topImage.visible = false;

    topImage2 = new FlxSprite(topImage.width, -FlxG.height).loadGraphic(Paths.image("MenuAssets/top"));
    topImage2.scrollFactor.set(0, 0);
    topImage2.visible = false;

    bottomImage = new FlxSprite(0, FlxG.height).loadGraphic(Paths.image("MenuAssets/bottom"));
    bottomImage.scrollFactor.set(0, 0);
    bottomImage.visible = false;

    bottomImage2 = new FlxSprite(-bottomImage.width, FlxG.height).loadGraphic(Paths.image("MenuAssets/bottom"));
    bottomImage2.scrollFactor.set(0, 0);
    bottomImage2.visible = false;

    flashImage = new FlxSprite(0, 0).loadGraphic(Paths.image("MenuAssets/red"));
    flashImage.alpha = 0;
    flashImage.scrollFactor.set();
    flashImage.cameras = [flashCam];
    add(flashImage);

    lastWidth = FlxG.width;
    lastHeight = FlxG.height;
}

function startScrollingBG() {
    menuSound.play();
    menuSound.volume = 0;
    FlxTween.tween(menuSound, {volume: 1}, 1);
    showBG = true;

    bg1 = new FlxSprite(0, 0).loadGraphic(Paths.image("MenuAssets/iridabg"));
    bg2 = new FlxSprite(0, bg1.height).loadGraphic(Paths.image("MenuAssets/iridabg"));
    bg1.alpha = 0;
    bg2.alpha = 0;
    bg1.scrollFactor.set(1, 1);
    bg2.scrollFactor.set(1, 1);

    insert(0, bg1);
    insert(1, bg2);

    FlxTween.tween(bg1, {alpha: 1}, 1);
    FlxTween.tween(bg2, {alpha: 1}, 1);

    topImage.visible = true;
    bottomImage.visible = true;
    topImage2.visible = true;
    bottomImage2.visible = true;

    add(topImage);
    add(topImage2);
    add(bottomImage);
    add(bottomImage2);

    add(enterImage);
    add(logoImage);

    FlxTween.tween(topImage, {y: 0}, 1, {ease: FlxEase.quadOut});
    FlxTween.tween(topImage2, {y: 0}, 1, {ease: FlxEase.quadOut});
    FlxTween.tween(bottomImage, {y: FlxG.height - bottomImage.height}, 1, {ease: FlxEase.quadOut});
    FlxTween.tween(bottomImage2, {y: FlxG.height - bottomImage.height}, 1, {
        ease: FlxEase.quadOut,
        onComplete: function(_) {
            imagesSlidingInDone = true;

            FlxTween.tween(enterImage, {alpha: 1}, 1, {ease: FlxEase.quadOut});
            FlxTween.tween(logoImage, {alpha: 1}, 1, {ease: FlxEase.quadOut});
            FlxTween.tween(enterImage, {x: 0}, 1, {ease: FlxEase.cubeOut});
            FlxTween.tween(logoImage, {x: 0}, 1, {ease: FlxEase.cubeOut});
        }
    });
}

function update(elapsed) {
    if (FlxG.width != lastWidth || FlxG.height != lastHeight) {
        lastWidth = FlxG.width;
        lastHeight = FlxG.height;
        onResize();
    }

    if (showBG) {
        var speed = 30;
        bg1.y -= speed * elapsed;
        bg2.y -= speed * elapsed;

        if (bg1.y <= -bg1.height)
            bg1.y = bg2.y + bg2.height;
        if (bg2.y <= -bg2.height)
            bg2.y = bg1.y + bg1.height;

        if (imagesSlidingInDone) {
            var scrollSpeed = 60;
            topImage.x -= scrollSpeed * elapsed;
            topImage2.x -= scrollSpeed * elapsed;
            bottomImage.x += scrollSpeed * elapsed;
            bottomImage2.x += scrollSpeed * elapsed;

            if (topImage.x <= -topImage.width)
                topImage.x = topImage2.x + topImage2.width;
            if (topImage2.x <= -topImage2.width)
                topImage2.x = topImage.x + topImage.width;
            if (bottomImage.x >= FlxG.width)
                bottomImage.x = bottomImage2.x - bottomImage.width;
            if (bottomImage2.x >= FlxG.width)
                bottomImage2.x = bottomImage.x - bottomImage.width;
        }

        beatTimer += elapsed;
        if (beatTimer >= beatInterval) {
            beatTimer -= beatInterval;
            enterImage.scale.set(1.075, 1.075);
            logoImage.scale.set(1.075, 1.075);
            FlxTween.tween(enterImage.scale, {x: 1, y: 1}, 0.35, {ease: FlxEase.quadOut});
            FlxTween.tween(logoImage.scale, {x: 1, y: 1}, 0.35, {ease: FlxEase.quadOut});
        }

        if (FlxG.keys.justPressed.check(FlxKey.ENTER) && !enterPressed) {
            enterPressed = true;
            selectSound.play();

            // Only fade in flash, do NOT fade it out automatically
            flashImage.alpha = 0;
            FlxTween.tween(flashImage, {alpha: 1}, 1, {
                ease: FlxEase.quadOut,
                onComplete: function(_) {
                    FlxTween.tween(flashImage, {alpha: 0}, 0.5, {
                        ease: FlxEase.quadOut,
                        onComplete: function(_) {
                            // Instantly load state after flash fades out
                            MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
                            FlxG.switchState(new MainMenuState());
                        }
                    });
                }
            });

            // Fade other elements normally
            FlxTween.tween(enterImage, {alpha: 0}, 1.5);
            FlxTween.tween(logoImage, {alpha: 0}, 1.5);
            FlxTween.tween(bg1, {alpha: 0}, 1.5);
            FlxTween.tween(bg2, {alpha: 0}, 1.5);
            FlxTween.tween(topImage, {alpha: 0}, 1.5);
            FlxTween.tween(topImage2, {alpha: 0}, 1.5);
            FlxTween.tween(bottomImage, {alpha: 0}, 1.5);
            FlxTween.tween(bottomImage2, {alpha: 0}, 1.5);
        }
    }
}

function onResize() {
    pauseCam.setSize(FlxG.width, FlxG.height);
    pauseCam.updateFlashOffset();

    flashCam.setSize(FlxG.width, FlxG.height);
    flashCam.updateFlashOffset();

    flashImage.setGraphicSize(FlxG.width, FlxG.height);
    flashImage.updateHitbox();
}

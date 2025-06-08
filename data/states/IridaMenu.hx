import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import funkin.backend.utils.WindowUtils;
import funkin.backend.utils.CoolUtil; // <-- added
import flixel.input.keyboard.FlxKey;
import funkin.backend.MusicBeatState;
import funkin.game.cutscenes.VideoCutscene;

var pauseCam:FlxCamera;
var flashCam:FlxCamera;

var shade:FlxSprite;
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

var lastWidth:Int;
var lastHeight:Int;
var showBG:Bool = false;
var imagesSlidingInDone:Bool = false;

var BPM:Int = 72;
var beatTimer:Float = 0;
var beatInterval:Float = 60 / BPM;

var enterPressed:Bool = false;
var currentVideo:VideoCutscene = null;

function create() {
    // Play warning sound as menu SFX
    CoolUtil.playMusic(Paths.music('Warning'), false, 1, false, BPM);

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
                    // Fade out music with the image
                    FlxTween.num(1, 0, 1, {
                        ease: FlxEase.quadIn
                    }, function(vol:Float) {
                        if (Conductor.inst != null) {
                            Conductor.inst.volume = vol;
                        }
                    });
                },
                onComplete: function(_) {
                    remove(warning);
                    var videoPath = Paths.video("intro");
                    currentVideo = new VideoCutscene(videoPath, function() {
                        currentVideo = null;
                        closeSubState();
                        startScrollingBG();
                    });
                    openSubState(currentVideo);
                }
            });
        }
    });


    enterImage = new FlxSprite(-FlxG.width, 0).loadGraphic(Paths.image("MenuAssets/enter"));
    enterImage.alpha = 0;
    logoImage = new FlxSprite(FlxG.width, 0).loadGraphic(Paths.image("MenuAssets/Logo"));
    logoImage.alpha = 0;
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
    // Start menu music using Conductor
    CoolUtil.playMusic(Paths.music('freakyMenu'), true, 1, true, BPM);
    showBG = true;

    bg1 = new FlxSprite(0, 0).loadGraphic(Paths.image("MenuAssets/iridabg"));
    bg2 = new FlxSprite(0, bg1.height).loadGraphic(Paths.image("MenuAssets/iridabg"));
    bg1.alpha = 0;
    bg2.alpha = 0;
    bg1.scrollFactor.set(1, 1);
    bg2.scrollFactor.set(1, 1);

    shade = new FlxSprite(0, 0).loadGraphic(Paths.image("MenuAssets/shade"));
    shade.scrollFactor.set(0, 0);
    shade.alpha = 1;

    insert(0, bg1);
    insert(1, bg2);
    insert(2, shade);

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
    if (currentVideo != null && FlxG.keys.justPressed.check(FlxKey.ENTER)) {
        var videoCamera = currentVideo.camera;
        if (videoCamera != null && FlxG.cameras.list.contains(videoCamera)) {
            FlxG.cameras.remove(videoCamera);
        }
        currentVideo.stop();
        currentVideo.destroy();
        currentVideo = null;
        closeSubState();
        startScrollingBG();
        return;
    }

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
        FlxG.sound.play(Paths.sound('confirm'), 1);


            flashImage.alpha = 0;
            FlxTween.tween(flashImage, {alpha: 1}, 0.3, {
                ease: FlxEase.quadOut,
                onComplete: function(_) {
                    // fade out visual elements
                    FlxTween.tween(enterImage, {alpha: 0}, 0.3);
                    FlxTween.tween(logoImage, {alpha: 0}, 0.3);
                    FlxTween.tween(bg1, {alpha: 0}, 0.3);
                    FlxTween.tween(bg2, {alpha: 0}, 0.3);
                    FlxTween.tween(topImage, {alpha: 0}, 0.3);
                    FlxTween.tween(topImage2, {alpha: 0}, 0.3);
                    FlxTween.tween(bottomImage, {alpha: 0}, 0.3);
                    FlxTween.tween(bottomImage2, {alpha: 0}, 0.3);

                    FlxTween.tween(flashImage, {alpha: 0}, 0.3, {
                        ease: FlxEase.quadOut,
                        startDelay: 0.3,
                        onComplete: function(_) {
                            MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
                            FlxG.switchState(new MainMenuState());
                        }
                    });
                }
            });
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

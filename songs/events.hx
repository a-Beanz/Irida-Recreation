import hxvlc.flixel.FlxVideoSprite; // WE USING HXVCL NOW YIPPIE!!
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxAxes;

var video:FlxVideoSprite = null;
var camHudElements:Array<FlxObject> = [];
var camVideo:FlxCamera = null;

function create() {
    camVideo = new FlxCamera();
    camVideo.bgColor = 0x00000000;
    FlxG.cameras.add(camVideo, false);
}

function intro() {
    var songName = FlxG.state.SONG.meta.name;
    var coolIntroThing = new FlxSprite(-5000).loadGraphic(Paths.image("introThings/" + songName));
    coolIntroThing.cameras = [camHUD];
    coolIntroThing.setGraphicSize(coolIntroThing.width * 0.4);
    coolIntroThing.updateHitbox();
    coolIntroThing.screenCenter(FlxAxes.Y);

    camHudElements.push(coolIntroThing);

    FlxTween.tween(coolIntroThing, {x: (FlxG.width / 2) - (coolIntroThing.width / 2)}, 0.5, {
        ease: FlxEase.expoInOut,
        onComplete: function(_) {
            FlxTween.tween(coolIntroThing, {x: 5000}, 0.5, {
                ease: FlxEase.expoInOut,
                startDelay: 2.5
            });
        }
    });
    add(coolIntroThing);
}

function onEvent(event) {
    switch (event.event.name) {
        case "addDefaultCamZoom":
            var zoomAdd = event.event.params[0];
            defaultCamZoom += zoomAdd;

            if (event.event.params[1])
                FlxG.camera.zoom = zoomAdd;

        case "Play Video":
            playVideo(event.event.params[0]);
    }
}

function playVideo(videoFile:String) {
    video = new FlxVideoSprite(0, 0);
    video.antialiasing = true;
    video.alpha = 1;
    video.visible = true;
    video.cameras = [camVideo];

    video.bitmap.onFormatSetup.add(function():Void {
        if (video.bitmap != null && video.bitmap.bitmapData != null) {
            final scale:Float = Math.min(FlxG.width / video.bitmap.bitmapData.width, FlxG.height / video.bitmap.bitmapData.height);
            video.setGraphicSize(video.bitmap.bitmapData.width * scale, video.bitmap.bitmapData.height * scale);
            video.updateHitbox();
            video.screenCenter();

            video.alpha = 1;
            video.visible = true;
        }
    });

    video.bitmap.onEndReached.add(function():Void {
        video.destroy();

        for (item in camHudElements)
            item.visible = true;
    });

    add(video);
    video.alpha = 1;
    video.visible = true;

    for (item in camHudElements)
        item.visible = false;

    if (video.load(Paths.video(videoFile))) {
        new FlxTimer().start(0.001, (_) -> {
            video.alpha = 1;
            video.visible = true;
            video.play();
        });
    }
}

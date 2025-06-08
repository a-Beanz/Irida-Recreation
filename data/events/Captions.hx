// Made by Estoy and messed up by Two Ef lol

import flixel.util.FlxAxes;
import flixel.text.FlxTextAlign;

var captions:FunkinText;
var camCaptions:FlxCamera;

function postCreate() {
    camCaptions = new FlxCamera();
    camCaptions.bgColor = 0x00000000;
    FlxG.cameras.add(camCaptions, false);

    captions = new FunkinText(0, 640, FlxG.width, "", 32);
    captions.cameras = [camCaptions];
    captions.alignment = FlxTextAlign.CENTER;
    add(captions);
}

var alphaTween:FlxTween;
function onEvent(eventEvent) {
    if (eventEvent.event.name != "Captions") return;
    if (eventEvent.event.params[0]) {
        alphaTween = FlxTween.tween(camCaptions, {alpha: 0}, 0.3);
        return;
    }

    if (alphaTween != null && alphaTween.active) alphaTween.cancel();

    camCaptions.alpha = 1;
    captions.text = '\n' + eventEvent.event.params[1];
}
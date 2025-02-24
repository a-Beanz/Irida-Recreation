function intro() {
    var coolIntroThing = new FlxSprite(-5000).loadGraphic(Paths.image("introThings/" + FlxG.state.SONG.meta.name));
    coolIntroThing.cameras = [camHUD];
    coolIntroThing.setGraphicSize(coolIntroThing.width * 0.4);
    coolIntroThing.updateHitbox();
    coolIntroThing.screenCenter(FlxAxes.Y);
    FlxTween.tween(coolIntroThing, {x: (FlxG.width / 2) - (coolIntroThing.width / 2)}, 0.5, {ease: FlxEase.expoInOut, onComplete: function(tween) {
        FlxTween.tween(coolIntroThing, {x: 5000}, 0.5, {ease: FlxEase.expoInOut, startDelay: 2.5});
    }});
    add(coolIntroThing);
}
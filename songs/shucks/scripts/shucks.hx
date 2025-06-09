import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;

var logo:FlxSprite = null;

function stepHit(curStep:Int) {
    if (curStep == 3061) {
        logo = new FlxSprite(0, 0);
        logo.loadGraphic(Paths.image("introThings/sucks")); // basically loads the sprite and shows it at a specific step.
        logo.scrollFactor.set(0, 0);
        logo.alpha = 1;

        // Optional: center it manually for 720p
        logo.x = (FlxG.width  - logo.width) / 2;
        logo.y = (FlxG.height - logo.height) / 2;

        add(logo);

        new FlxTimer().start(3, function(tmr:FlxTimer) {
            FlxTween.tween(logo, { alpha: 0 }, 1, {
                ease: FlxEase.quadOut,
                onComplete: function(_) {
                    logo.destroy();
                }
            });
        });
    }
}

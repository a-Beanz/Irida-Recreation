import flixel.FlxG;
import flixel.math.FlxMath;

var RotateAmount:Float = 0.7; // Reduced from 1 to 0.4 for less intense rotation
var MoveAmount:Float = 4.5;   // Reduced from 6 to 2.5 for more subtle camera movement
var RotateTime:Float = 1.8;
var returnSpeed:Float = 1; 
var direction:Int = 1;
var angleTimer:Float = 0;
var targetAngle:Float = 0;
var targetOffsetX:Float = 0;
var targetOffsetY:Float = 0;


function onCreate() {
    FlxG.camera.angle = 0;
    FlxG.camera.x = 0;
    FlxG.camera.y = 0;
}

function update(elapsed:Float) {
    if (angleTimer > 0) {
        angleTimer -= elapsed;
        FlxG.camera.angle = FlxMath.lerp(FlxG.camera.angle, targetAngle, elapsed * 6);

        // Subtle movement in sync with rotation
        FlxG.camera.x = FlxMath.lerp(FlxG.camera.x, targetOffsetX, elapsed * 6);
        FlxG.camera.y = FlxMath.lerp(FlxG.camera.y, targetOffsetY, elapsed * 6);
    } else {
        // Return to original position and angle
        targetAngle = 0;
        FlxG.camera.angle = FlxMath.lerp(FlxG.camera.angle, 0, elapsed * returnSpeed);
        FlxG.camera.x = FlxMath.lerp(FlxG.camera.x, 0, elapsed * returnSpeed);
        FlxG.camera.y = FlxMath.lerp(FlxG.camera.y, 0, elapsed * returnSpeed);
    }
}

function onNoteHit(event) {
    idkrotate();
}

function idkrotate() {
    direction *= -1;
    targetAngle = RotateAmount * direction;

    // Movement offsets based on direction
    targetOffsetX = MoveAmount * direction;
    targetOffsetY = MoveAmount * 0.5 * direction; // Y movement is less intense

    angleTimer = RotateAmount;
}

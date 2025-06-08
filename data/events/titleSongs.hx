/*
claro, usar dos tween es una pendejada y deben haber mejores formas pero esta es la que encontre mas sencilla xd

of course, using two tween is bullshit and there must be better ways but this is the one I found the easiest xd

-Valdibee
*/

var titleShit:FlxSprite = new FlxSprite();
var titeTweenAlpha:FlxTween;
var titeTweenScale:FlxTween;
var titleTime:FLxTimer = new FlxTimer();
var titleSongsCamera:FlxCamera = new FlxCamera(); //made this for problems in sweet dude

function onEvent(e) 
{
	if (e.event.name == "titleSongs") 
	{

		titleSongsCamera.bgColor = FlxColor.TRASPARENT;
		FlxG.cameras.add(titleSongsCamera, false);

		titleShit.loadGraphic(Paths.image('game/titlesSong/' + e.event.params[1]));
		titleShit.scale.set(0.6,0.6);
		titleShit.updateHitbox();
		titleShit.camera = titleSongsCamera;
		titleShit.screenCenter();
		titleShit.alpha = 0;
		insert(0, titleShit);

		titeTweenAlpha = FlxTween.tween(titleShit, {alpha:1}, 1);
		titeTweenScale = FlxTween.tween(titleShit, {"scale.x":0.5, "scale.y":0.5}, 1, {ease: FlxEase.quadOut});

		titleTime.start(e.event.params[0], function sex()
		{
			titeTweenAlpha = FlxTween.tween(titleShit, {alpha:0}, 2);
			titeTweenScale = FlxTween.tween(titleShit.scale, {x:0.6, y:0.6}, 2, {ease: FlxEase.quadOut});
		});
	}
}
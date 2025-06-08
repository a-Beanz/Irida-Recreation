//Goofy event created by Two Ef :] (I stole part of the code from Alan and theMAJigsaw77 sample lol)
import hxvlc.flixel.FlxVideoSprite;

var blackBG:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
var daVideo:FlxVideoSprite = new FlxVideoSprite(0, 0);

function onEvent(event)
{
    if(event.event.name == "Play Video")
    {
        if(daVideo != null)
        {
            blackBG.cameras = [camHUD];
            daVideo.camera = camHUD;

            if(event.event.params[1])
            {
                add(blackBG);
                add(daVideo);
            }
            else
            {
                insert(0, daVideo);
                insert(0, blackBG);
            }

            daVideo.load(Assets.getPath(Paths.video(event.event.params[0])));
            
            //just in case
            if(daVideo == null)
            {
                blackBG.kill();
                blackBG.destroy();
                daVideo.kill();
                daVideo.destroy();
                return;
            }
            
            if(daVideo.bitmap != null)
                daVideo.bitmap.onEndReached.add(function()
                {   
                    blackBG.kill();
                    blackBG.destroy();

                    daVideo.stop();
                    daVideo.kill();
                    daVideo.destroy();
                });

            
            daVideo.bitmap.onFormatSetup.add(function():Void
            {
                if(daVideo.bitmap != null && daVideo.bitmap.bitmapData != null)
                {
                    //IF YOU'RE IN CHARTING MODE SET MATH.MAX TO MATH.MIN (I don't know why)
                    var daScale:Float = Math.max(FlxG.width/daVideo.bitmap.bitmapData.width, FlxG.height/daVideo.bitmap.bitmapData.height);
                    
                    //IN CASE YOU'RE IN CHARTING MODE USE THIS INSTEAD OF SCREENCENTER
                    // daVideo.x = FlxG.width/2 - daVideo.bitmap.bitmapData.width * daScale/2;
                    // daVideo.y = FlxG.height/2 - daVideo.bitmap.bitmapData.height * daScale/2;

                    daVideo.setGraphicSize(daVideo.bitmap.bitmapData.width * daScale, daVideo.bitmap.bitmapData.height * daScale);
                    daVideo.updateHitbox();
                    daVideo.screenCenter();
                }
                else
                {
                    blackBG.kill();
                    blackBG.remove();
                    daVideo.x = daVideo.y = 0;
                }
            });
            
            daVideo.play();
        }
    }
}

//DON'T SWITCH WINDOW WHILE YOU'VE PAUSED DURING A VIDEO (I still have no clue why autoPause doesn't work)
function onGamePause()
{
    if(daVideo != null)
    {
        daVideo.pause();
    }
}

function onSubstateClose()
{
    if(daVideo != null)
    {
        daVideo.resume();
    }
}

import funkin.game.cutscenes.VideoCutscene;

var currentVideo:VideoCutscene = null;

function intro() {
	var songName = FlxG.state.SONG.meta.name;
	var coolIntroThing = new FlxSprite(-5000).loadGraphic(Paths.image("introThings/" + songName));
	coolIntroThing.cameras = [camHUD];
	coolIntroThing.setGraphicSize(coolIntroThing.width * 0.4);
	coolIntroThing.updateHitbox();
	coolIntroThing.screenCenter(FlxAxes.Y);

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
			var videoPath = Paths.video(event.event.params[0]);
			currentVideo = new VideoCutscene(videoPath, function() {
				currentVideo = null;
				closeSubState();
			});
			openSubState(currentVideo);

		case "Stop Video":
			if (currentVideo != null) {
				currentVideo.onEnd(); // safely triggers the video’s end callback
				closeSubState();      // forcefully close the SubState
				currentVideo = null;
			}
	}
}

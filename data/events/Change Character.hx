public var preloadedCharacters:Map<String, Character> = [];
public var preloadedIcons:Map<String, FlxSprite> = [];
function postCreate() {
    for (event in PlayState.SONG.events) {
        if (event.name != "Change Character") continue;

        var preExistingCharacter:Bool = false;
        for (strum in strumLines)
            for (char in strum.characters)
                if (char.curCharacter == event.params[1]) {
                    preloadedCharacters.set(event.params[1], char);
                    preExistingCharacter = true;
                    break;
                }

        var oldCharacter = strumLines.members[event.params[0]].characters[0];
        // Create New Character
        if (!preExistingCharacter) {
            var newCharacter = new Character(oldCharacter.x, oldCharacter.y, event.params[1], oldCharacter.isPlayer);
            newCharacter.active = newCharacter.visible = false;
            newCharacter.drawComplex(FlxG.camera); // Push to GPU
            preloadedCharacters.set(event.params[1], newCharacter);

            //Adjust character to follow stage offsets
						var stagePos:String;
            if (newCharacter.isGF) stagePos = "gf";
            else if (oldCharacter.isPlayer) stagePos = "boyfriend";
            else stagePos = "dad";
						stage.applyCharStuff(newCharacter, stagePos, 0);
        }
        
        // Create New Icon
        var character:Character = preloadedCharacters.get(event.params[1]) ?? oldCharacter;
        var iconName:String = character.getIcon();
        if (preloadedIcons.exists(iconName) || oldCharacter.icon == iconName) continue;

        newIcon = new HealthIcon(character.getIcon(), character.isPlayer);
        newIcon.y = healthBar.y - (newIcon.height / 2);
        newIcon.active = newIcon.visible = false;
        newIcon.drawComplex(FlxG.camera); // Push to GPU
        newIcon.cameras = [camHUD];
        preloadedIcons.set(iconName, newIcon);
    }
}
function onEvent(_) {
    var params:Array = _.event.params;
    if (_.event.name == "Change Character") {
        // Change Character
        var oldCharacter = strumLines.members[params[0]].characters[0];
        var newCharacter = preloadedCharacters.get(params[1]);
        if (oldCharacter.curCharacter == newCharacter.curCharacter) return;

        newCharacter.setPosition(oldCharacter.x, oldCharacter.y);
        newCharacter.playAnim(oldCharacter.animation.name);
        newCharacter.animation?.curAnim?.curFrame = oldCharacter.animation?.curAnim?.curFrame;
        strumLines.members[params[0]].characters[0] = newCharacter;
        newCharacter.active = true;
				newCharacter.visible = oldCharacter.visible;
				newCharacter.alpha = oldCharacter.alpha;
        insert(members.indexOf(oldCharacter), newCharacter);
        remove(oldCharacter, true);

        // Change Icon
        var oldIcon = oldCharacter.isPlayer ? iconP1 : iconP2;
        var newIcon = preloadedIcons.get(newCharacter.getIcon());

        if (newIcon == null || oldIcon.curCharacter == newIcon.curCharacter) return;
        insert(members.indexOf(oldIcon), newIcon);
        newIcon.active = newIcon.visible = true;
        //remove(oldIcon);
        oldIcon.visible = false;
        if (oldCharacter.isPlayer) iconP1 = newIcon;
        else iconP2 = newIcon;
				preloadedIcons.remove(newCharacter.getIcon());

				if (Options.colorHealthBar)
				{
					switch (oldCharacter.isPlayer)
					{
						case false: healthBar.createColoredEmptyBar(newCharacter.iconColor);
						case true: healthBar.createColoredFilledBar(newCharacter.iconColor);
					}
					healthBar.updateBar();
				}
    }
}
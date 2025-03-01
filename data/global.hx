import funkin.backend.system.macros.GitCommitMacro;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.DiscordUtil;
import funkin.backend.system.Main;

import funkin.backend.utils.WindowUtils;
import funkin.game.GameOverSubstate;
import funkin.menus.PauseSubState;

function update(elapsed:Float) {
	if (FlxG.keys.justPressed.F5)
		FlxG.resetState();
    
	Framerate.codenameBuildField.text = WindowUtils.winTitle = 'Jeffys Infinite Irida';
}

function destroy() {
	Framerate.codenameBuildField.text = 'Codename Engine ' + Main.releaseCycle + "\nCommit " + GitCommitMacro.commitNumber + " (" + GitCommitMacro.commitHash + ")";
}
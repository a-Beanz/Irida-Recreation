import funkin.backend.system.macros.GitCommitMacro;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.DiscordUtil;
import funkin.backend.system.Main;
import funkin.backend.utils.WindowUtils;
import funkin.game.GameOverSubstate;
import funkin.menus.PauseSubState;
import funkin.menus.BetaWarningState;
import funkin.menus.TitleState;

static var redirectStates:Map<FlxState, String> = [
    BetaWarningState => 'SMLReuploadedWarning',
    TitleState => 'IridaMenu'
];

function preStateSwitch() {
    for (redirectState in redirectStates.keys()) {
        if (Std.isOfType(FlxG.game._requestedState, redirectState)) {
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
        }
    }
}

function update(elapsed:Float) {
    // Handling state redirection before any update logic
    preStateSwitch();

    // Handle F5 key press to reset the state
    if (FlxG.keys.justPressed.F5) {
        FlxG.resetState();
    }

    // Update the window title and framerate information
    Framerate.codenameBuildField.text = WindowUtils.winTitle = "Jeffy's Infinite Irida";
}

function destroy() {
    // Destroy logic including display of build and commit information
    Framerate.codenameBuildField.text = 'Codename Engine ' + Main.releaseCycle + "\nCommit " + GitCommitMacro.commitNumber + " (" + GitCommitMacro.commitHash + ")";
}

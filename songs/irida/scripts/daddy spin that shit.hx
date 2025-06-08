var swapped = false;

function swapStrumlines() {
    swapped = true;

    var playerStrum = strumLines.members[1];
    var opponentStrum = strumLines.members[0];

    for (i in 0...4) {
        var tempX = playerStrum.members[i].x;
        playerStrum.members[i].x = opponentStrum.members[i].x; // moves player strums to the opponent side for irida
        opponentStrum.members[i].x = tempX;
    }
}

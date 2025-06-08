
function onEvent(event) {
    if (event.event.name == "Zoom Camera") {
        var value:Float = event.event.params[0];
        defaultCamZoom =  value;
    
    }
}
import Toybox.Graphics;
import Toybox.System;
import Toybox.Timer;
import Toybox.WatchUi;



class StayAwakeHelperView extends WatchUi.View {

    var myTimer;

    function setupTimer() {
        System.println("SETTING UP TIMER");
        myTimer = new Timer.Timer();
        myTimer.start(method(:doUpdate), 1000, true);
    }

    function doUpdate() as Void {
        WatchUi.requestUpdate();
    }

    function initialize() {
        View.initialize();
        setupTimer();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        var clockTime = Toybox.System.getClockTime();
        var clockTimeString = clockTime.hour.format("%02d") + ":" + clockTime.min.format("%02d") + ":" + clockTime.sec.format("%02d");
        var clockTimeLabel = View.findDrawableById("clockTime") as WatchUi.Text;
        clockTimeLabel.setText(clockTimeString);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}

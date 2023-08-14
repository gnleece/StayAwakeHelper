import Toybox.Graphics;
import Toybox.System;
import Toybox.Timer;
import Toybox.WatchUi;

class StayAwakeHelperView extends WatchUi.View {

    var isRunning = false;

    var updateTimer;

    var alertInterval = 5;
    var secondsUntilNextAlert = alertInterval;

    function setupTimers() {
        updateTimer = new Timer.Timer();
        updateTimer.start(method(:onTimerUpdate), 1000, true);
    }

    function onTimerUpdate() as Void {
        if (isRunning) {
            secondsUntilNextAlert--;
        }
        if (secondsUntilNextAlert <= 0) {
            triggerAlert();
            secondsUntilNextAlert = alertInterval;
        }

        WatchUi.requestUpdate();
    }

    function triggerAlert() as Void {
        if (Toybox.Attention has :vibrate) {
            var vibeData =
            [
                new Attention.VibeProfile(25, 2000)
            ];

            Toybox.Attention.vibrate(vibeData);
        }
    }

    function initialize() {
        View.initialize();
        setupTimers();
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
        updateClockTimeLabel();
        updateAlertCountdownLabel();

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function onSelect() {
        System.println("View - onselect");

        isRunning = !isRunning;

        if (isRunning) {
            System.println("Alert timer start");
        } else {
            System.println("Alert timer stop");
        }
    }

    function updateClockTimeLabel() {
        var clockTime = Toybox.System.getClockTime();

        var ampm = clockTime.hour > 12 ? "pm" : "am";
        var clockTimeString = (clockTime.hour%12) + ":" + clockTime.min.format("%02d") + " " + ampm;

        var clockTimeLabel = View.findDrawableById("clockTime") as WatchUi.Text;
        clockTimeLabel.setText(clockTimeString);
    }

    function updateAlertCountdownLabel() {
        if (!isRunning) {
            return;
        }

        var alertCountdownLabel = View.findDrawableById("countdownTime") as WatchUi.Text;
        alertCountdownLabel.setText(secondsUntilNextAlert.toString());
    }

}

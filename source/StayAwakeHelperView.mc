import Toybox.Graphics;
import Toybox.System;
import Toybox.Timer;
import Toybox.WatchUi;

class StayAwakeHelperView extends WatchUi.View {

    var _userSettings;

    var _isRunning = false;
    var _secondsUntilNextAlert = 0;

    var _updateTimer;
    
    function setupTimers() {
        _updateTimer = new Timer.Timer();
        _updateTimer.start(method(:onTimerUpdate), 1000, true);
    }

    function onTimerUpdate() as Void {
        if (_isRunning) {
            _secondsUntilNextAlert--;

            if (_secondsUntilNextAlert <= 0) {
                triggerAlert();
                _secondsUntilNextAlert = _userSettings.AlertIntervalSeconds;
            }
        }

        WatchUi.requestUpdate();
    }

    function triggerAlert() as Void {
        if (Toybox.Attention has :vibrate) {
            var vibeData =
            [
                new Attention.VibeProfile(
                    _userSettings.VibrationStrengthPercent,
                    _userSettings.VibrationDurationSeconds * 1000
                )
            ];

            Toybox.Attention.vibrate(vibeData);
        }
    }

    function initialize() {
        View.initialize();
        setupTimers();

        _userSettings = new UserSettings();
        _userSettings.LoadSettings();
        _userSettings.DebugPrint();
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

        _isRunning = !_isRunning;

        if (_isRunning) {
            System.println("Alert timer start");
        } else {
            System.println("Alert timer stop");
        }
    }

    function setAlertInterval(intervalSeconds) {
        _userSettings.SetAlertInterval(intervalSeconds);
        _secondsUntilNextAlert = _userSettings.AlertIntervalSeconds;
    }

    function setVibrationStrength(strengthPercent) {
        _userSettings.SetVibrationStrength(strengthPercent);
    }

    function updateClockTimeLabel() {
        var clockTime = Toybox.System.getClockTime();

        var ampm = clockTime.hour > 12 ? "pm" : "am";
        var clockTimeString = (clockTime.hour%12) + ":" + clockTime.min.format("%02d") + " " + ampm;

        var clockTimeLabel = View.findDrawableById("clockTime") as WatchUi.Text;
        clockTimeLabel.setText(clockTimeString);
    }

    function updateAlertCountdownLabel() {
        if (!_isRunning) {
            return;
        }

        var alertCountdownLabel = View.findDrawableById("countdownTime") as WatchUi.Text;
        alertCountdownLabel.setText(_secondsUntilNextAlert.toString());
    }

}

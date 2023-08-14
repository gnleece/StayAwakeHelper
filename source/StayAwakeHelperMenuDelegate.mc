import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class StayAwakeHelperMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :alert_interval) {
            onAlertInterval();
        } else if (item == :vibration_duration) {
            onVibrationDuration();
        } else if (item == :vibration_strength) {
            onVibrationDuration();
        }
    }

    function onAlertInterval() as Void {
        System.println("Selected menu option: alert interval");

        WatchUi.pushView(
            new NumberPicker(1, 60, Rez.Strings.duration_minutes),
            new NumberPickerDelegate(method(:pickerDelegateCallback)),
            WatchUi.SLIDE_DOWN
        );
    }

    function pickerDelegateCallback(success, value) {
        System.println("Picker delegate callback: " + success + ", " +  value.toString());
    }

    function onVibrationDuration() as Void {
        System.println("Selected menu option: vibration duration");
    }

    function onVibrationStrength() as Void {
        System.println("Selected menu option: vibration strength");
    }
}


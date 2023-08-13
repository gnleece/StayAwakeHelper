import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class StayAwakeHelperMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :vibration_interval) {
            onVibrationInterval();
        } else if (item == :vibration_duration) {
            onVibrationDuration();
        } else if (item == :vibration_strength) {
            onVibrationDuration();
        }
    }

    function onVibrationInterval() as Void {
        System.println("Selected menu option: vibration interval");

        WatchUi.pushView(
            new NumberPicker(1, 60, Rez.Strings.duration_minutes),
            new NumberPickerDelegate(),
            WatchUi.SLIDE_DOWN
        );
    }

    function onVibrationDuration() as Void {
        System.println("Selected menu option: vibration duration");
    }

    function onVibrationStrength() as Void {
        System.println("Selected menu option: vibration strength");
    }
}


import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class StayAwakeHelperMenuDelegate extends WatchUi.MenuInputDelegate {

    hidden var _view;

    function initialize(view) {
        _view = view;

        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :alert_interval) {
            onAlertIntervalMenuItem();
        } else if (item == :vibration_duration) {
            onVibrationDurationMenuItem();
        } else if (item == :vibration_strength) {
            onVibrationStrengthMenuItem();
        }
    }

    function onAlertIntervalMenuItem() as Void {
        System.println("Selected menu option: alert interval");

        WatchUi.pushView(
            new NumberPicker(1, 60, Rez.Strings.duration_minutes),
            new NumberPickerDelegate(method(:alertIntervalPickerCallback)),
            WatchUi.SLIDE_DOWN
        );
    }

    function onVibrationDurationMenuItem() as Void {
        System.println("Selected menu option: vibration duration");
    }

    function onVibrationStrengthMenuItem() as Void {
        System.println("Selected menu option: vibration strength");

        WatchUi.pushView(
            new NumberPicker(0, 100, Rez.Strings.strength_percent),
            new NumberPickerDelegate(method(:vibrationStrengthPickerCallback)),
            WatchUi.SLIDE_DOWN
        );
    }

    function alertIntervalPickerCallback(success, value) {
        System.println("Alert interval callback: " + success + ", " +  value.toString());

        if (success) {
            _view.setAlertInterval(value);
        }
    }

    function vibrationStrengthPickerCallback(success, value) {
        System.println("Vibration strength callback: " + success + ", " +  value.toString());

        if (success) {
            _view.setVibrationStrength(value);
        }
    }
}


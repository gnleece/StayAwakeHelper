import Toybox.Application.Storage;

class UserSettings {
    var AlertIntervalSeconds;
    var VibrationDurationSeconds;
    var VibrationStrength;

    hidden var alertIntervalKeyName = "alert_interval";
    hidden var vibrationDurationKeyName = "vibration_duration";
    hidden var vibrationStrengthKeyName = "vibration_strength";

    hidden var defaultAlertInterval = 5;
    hidden var defaultVibrationDuration = 1;
    hidden var defaultVibrationStrength = 25;

    function LoadSettings() {
        AlertIntervalSeconds = Storage.getValue(alertIntervalKeyName);
        VibrationDurationSeconds = Storage.getValue(vibrationDurationKeyName);
        VibrationStrength = Storage.getValue(vibrationStrengthKeyName);

        if (AlertIntervalSeconds == null) {
            AlertIntervalSeconds = defaultAlertInterval;
        }
        if (VibrationDurationSeconds == null) {
            VibrationDurationSeconds = defaultVibrationDuration;
        }
        if (VibrationStrength == null) {
            VibrationStrength = defaultVibrationStrength;
        }
    }

    function SetAlertInterval(intervalSeconds) {
        AlertIntervalSeconds = intervalSeconds;
        Storage.setValue(alertIntervalKeyName, AlertIntervalSeconds);
    }

    function SetVibrationDuration(durationSeconds) {
        VibrationDurationSeconds = durationSeconds;
        Storage.setValue(vibrationDurationKeyName, VibrationDurationSeconds);
    }

    function SetVibrationStrength(strength) {
        VibrationStrength = strength;
        Storage.setValue(vibrationStrengthKeyName, VibrationStrength);
    }

    function DebugPrint() {
        System.println("User settings: --------------------");
        System.println("    Alert interval: " + AlertIntervalSeconds);
        System.println("    Vibration duration: " + VibrationDurationSeconds);
        System.println("    Vibration strength: " + VibrationStrength);
        System.println("-----------------------------------");
    }
}
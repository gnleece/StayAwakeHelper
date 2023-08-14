import Toybox.Application.Storage;

class UserSettings {
    
    hidden var alertIntervalKeyName = "alert_interval";
    hidden var vibrationDurationKeyName = "vibration_duration";
    hidden var vibrationStrengthKeyName = "vibration_strength";

    hidden var defaultAlertInterval = 5;
    hidden var defaultVibrationDuration = 1;
    hidden var defaultVibrationStrength = 25;

    var AlertIntervalSeconds = defaultAlertInterval;
    var VibrationDurationSeconds = defaultVibrationDuration;
    var VibrationStrengthPercent = defaultVibrationStrength;

    function LoadSettings() {
        AlertIntervalSeconds = Storage.getValue(alertIntervalKeyName);
        VibrationDurationSeconds = Storage.getValue(vibrationDurationKeyName);
        VibrationStrengthPercent = Storage.getValue(vibrationStrengthKeyName);

        if (AlertIntervalSeconds == null) {
            AlertIntervalSeconds = defaultAlertInterval;
        }
        if (VibrationDurationSeconds == null) {
            VibrationDurationSeconds = defaultVibrationDuration;
        }
        if (VibrationStrengthPercent == null) {
            VibrationStrengthPercent = defaultVibrationStrength;
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

    function SetVibrationStrength(strengthPercent) {
        VibrationStrengthPercent = strengthPercent;
        Storage.setValue(vibrationStrengthKeyName, VibrationStrengthPercent);
    }

    function DebugPrint() {
        System.println("User settings: --------------------");
        System.println("    Alert interval: " + AlertIntervalSeconds);
        System.println("    Vibration duration: " + VibrationDurationSeconds);
        System.println("    Vibration strength: " + VibrationStrengthPercent);
        System.println("-----------------------------------");
    }
}
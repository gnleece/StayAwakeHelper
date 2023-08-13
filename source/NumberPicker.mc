import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class NumberPicker extends WatchUi.Picker {

    hidden var minValue;
    hidden var maxValue;
    hidden var titleString;

	function initialize(min, max, title){

        minValue = min;
        maxValue = max;

		var titleText = new WatchUi.Text({
            :text=>title,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_TOP,
            :color=>Graphics.COLOR_WHITE
        });

		WatchUi.Picker.initialize({ :title => titleText, :pattern => createPickerPattern() });

		WatchUi.requestUpdate();
	}

	function createPickerPattern() {
		var pattern = new [1];
	    pattern[0] = new NumberPickerFactory(minValue, maxValue);
		return pattern;
	}
}

class NumberPickerDelegate extends WatchUi.PickerDelegate {
    
    function initialize() {
        PickerDelegate.initialize();
    }

    function onAccept(values) as Boolean {
        var val = values[0];
        System.println("Picked value: " + val.toString());

        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return true;
    }

    function onCancel() as Boolean {
        System.println("Picker canceled.");
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return false;
    }
}

class NumberPickerFactory extends WatchUi.PickerFactory {

    hidden var minValue;
    hidden var maxValue;
    
    function initialize(min, max) {
        minValue = min;
        maxValue = max;

        PickerFactory.initialize();
    }

    function getDrawable(index, selected) {
        return new WatchUi.Text( { 
            :text => getValue(index).toString(),
            :color => Graphics.COLOR_WHITE,
            :font => Graphics.FONT_NUMBER_HOT,
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => WatchUi.LAYOUT_VALIGN_CENTER
        } );
    }

    function getValue(index) {
        return index + minValue;
    }

    function getSize() {
        return maxValue - minValue + 1;
    }
}
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class NumberPicker extends WatchUi.Picker {

    hidden var _minValue;
    hidden var _maxValue;

	function initialize(minValue, maxValue, titleString){

        _minValue = minValue;
        _maxValue = maxValue;

		var titleText = new WatchUi.Text({
            :text => titleString,
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => WatchUi.LAYOUT_VALIGN_TOP,
            :color => Graphics.COLOR_WHITE
        });

		WatchUi.Picker.initialize({ :title => titleText, :pattern => createPickerPattern() });

		WatchUi.requestUpdate();
	}

	function createPickerPattern() {
		var pattern = new [1];
	    pattern[0] = new NumberPickerFactory(_minValue, _maxValue);
		return pattern;
	}
}

class NumberPickerDelegate extends WatchUi.PickerDelegate {
    
    hidden var _callback;

    // callback:
    //  - success (bool)
    //  - picked value (number) (0 if success is false)
    function initialize(callback) {
        _callback = callback;
        PickerDelegate.initialize();
    }

    function onAccept(values) as Boolean {
        var val = values[0];
        System.println("Picked value: " + val.toString());

        _callback.invoke(true, val);
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return true;
    }

    function onCancel() as Boolean {
        System.println("Picker canceled.");
        _callback.invoke(false, 0);
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return false;
    }
}

class NumberPickerFactory extends WatchUi.PickerFactory {

    hidden var _minValue;
    hidden var _maxValue;
    
    function initialize(minValue, maxValue) {
        _minValue = minValue;
        _maxValue = maxValue;

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
        return index + _minValue;
    }

    function getSize() {
        return _maxValue - _minValue + 1;
    }
}
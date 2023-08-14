import Toybox.Lang;
import Toybox.WatchUi;

class StayAwakeHelperDelegate extends WatchUi.BehaviorDelegate {

    hidden var _view;

    function initialize(view) {
        _view = view;

        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new StayAwakeHelperMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onSelect() as Boolean {
        _view.onSelect();
        return true;
    }

}
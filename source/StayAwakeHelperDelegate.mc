import Toybox.Lang;
import Toybox.WatchUi;

class StayAwakeHelperDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new StayAwakeHelperMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}
pragma Singleton
import QtQuick 2.0


Item {

    property string strFontFamiliy: "Helvetica"

    readonly property real refScreenWidth: 1389
    readonly property real refScreenHeight: 699
    property real screenWidth: 1389
    property real screenHeight: 699


    function hscale(size) {
        return Math.round(size * (screenWidth / refScreenWidth))
    }

    function vscale(size) {
        return Math.round(size * (screenHeight / refScreenHeight))
    }

    function tscale(size) {
        return Math.round((hscale(size) + vscale(size)) / 2)
    }
}

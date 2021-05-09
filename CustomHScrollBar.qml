import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import UiSchemes 1.0

ScrollBar {
    id: customHScrollbarID
    property var targetView: undefined
    height: UiSchemes.vscale(10)

    background: Rectangle {
        id: upDownScrollId
        width: customHScrollbarID.width
        height: UiSchemes.vscale(10)
        color: "#002ed1e6"
        border.color: "#12c5d9"
        border.width:1
        radius: UiSchemes.tscale(4)
    }

    contentItem: Rectangle {
        color: "#2ed1e6"
        implicitWidth: upDownScrollId.width * targetView.visibleArea.widthRatio
        implicitHeight: UiSchemes.hscale(8)
        radius: UiSchemes.tscale(2)
    }
}

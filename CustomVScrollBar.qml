import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import UiSchemes 1.0

ScrollBar {
    id: customVScrollbarID
    property var targetView: undefined
    width: UiSchemes.hscale(10)

    background: Rectangle {
        id: upDownScrollId
        width: UiSchemes.hscale(10)
        height: customVScrollbarID.height
        color: "#002ed1e6"
        border.color: "#12c5d9"
        border.width:1
        radius: UiSchemes.tscale(4)
    }

    contentItem: Rectangle {
        color: "#2ed1e6"
        implicitWidth: UiSchemes.hscale(8)
        implicitHeight: upDownScrollId.height * targetView.visibleArea.widthRatio
        radius: UiSchemes.tscale(2)
    }
}

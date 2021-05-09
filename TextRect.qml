import QtQuick 2.12
import UiSchemes 1.0

Item {
    id: textRectItem
    property var textData: ""
    property var fontPixel: UiSchemes.tscale(26)
    property var bgColor: "#A0FFFFFF"
    property var borderColor: "#f9c2c2"
    property var fontColor: "black"
    property var fontHorizontalAlign: Text.AlignHCenter
    property var fontVerticalAlign: Text.AlignVCenter

    Rectangle {
        id: nameTitle
        color: textRectItem.bgColor
        border.color: textRectItem.borderColor
        border.width: UiSchemes.tscale(1)
        anchors.fill: textRectItem

        Text {
            id: nameText
            text: textRectItem.textData
            width: parent.width * 0.95
            height: parent.height * 0.95
            verticalAlignment: textRectItem.fontVerticalAlign
            horizontalAlignment: textRectItem.fontHorizontalAlign
            color: textRectItem.fontColor
            wrapMode: Text.WordWrap
            clip: true
            font { family:UiSchemes.strFontFamiliy; pixelSize: textRectItem.fontPixel }
            anchors.centerIn: parent
        }
    }
}


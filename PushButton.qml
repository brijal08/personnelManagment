import QtQuick 2.0
import UiSchemes 1.0

Item {
    id: pushButtonId
    property color buttonColor: "#3f797e"
    property bool isChecked: false
    property string strButtonId

    signal buttonClicked(var isChecked);

    Rectangle {
        id: addUserPushButton
        border.color: buttonColor
        border.width: UiSchemes.tscale(2)
        radius: UiSchemes.tscale(5)
        anchors.fill: pushButtonId

        Text {
            id: addUserText
            text: strButtonId
            color: buttonColor
            font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(18) }
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                buttonColor = "#5aadb3"
            }

            onExited: {
                buttonColor = "#3f797e"
            }

            onClicked: {
                isChecked = !isChecked
                buttonClicked(isChecked);
                parent.forceActiveFocus();
            }
        }
    }

}

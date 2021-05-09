import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.VirtualKeyboard 2.4
import QtQuick.Controls 2.12
import UiSchemes 1.0

Window {
    id: window
    visible: true
    width: 1389
    height: 699
    title: qsTr("Personnel Managment")

    Connections {
        target: EmployeeManagment

        onAddEmployeeSuccessFull : {
            addUserPushButton.isChecked = false;
            employeeDetailsTitle.forceActiveFocus();
        }

        onPrintCSVMessage: {
            infoMessage.text = pMessage
            showtextAnimation.start();
        }
    }

    Text {
        id: employeeDetailsTitle
        text: addUserPushButton.isChecked ? qsTr("Add Employee") : qsTr("Employee details:")
        color: "#3f797e"
        font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(32) }
        anchors.left: employeeListRect.left
        anchors.bottom: employeeListRect.top
        anchors.bottomMargin: UiSchemes.vscale(10)
    }

    PushButton {
        id: printPushButton
        visible: (!addUserPushButton.isChecked) && (employeeDetails.employeeCount > 0) && (!backPushButton.visible)
        width: UiSchemes.hscale(150)
        height: UiSchemes.vscale(50)
        strButtonId: qsTr("Save")
        anchors.right: addUserPushButton.left
        anchors.top: parent.top
        anchors.rightMargin: UiSchemes.hscale(10)
        anchors.topMargin: UiSchemes.vscale(10)

        onButtonClicked: {
            EmployeeManagment.printIntoCSVFormate();
        }
    }

    PushButton {
        id: addUserPushButton
        width: UiSchemes.hscale(150)
        height: UiSchemes.vscale(50)
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: UiSchemes.hscale(10)
        anchors.topMargin: UiSchemes.vscale(10)
        strButtonId: isChecked ? qsTr("Cancel") : qsTr("Add Employee")
        visible: !backPushButton.visible
        onButtonClicked: {
            addEmployee.resetData();
            parent.forceActiveFocus();
        }
    }

    PushButton {
        id: backPushButton
        width: UiSchemes.hscale(150)
        height: UiSchemes.vscale(50)
        strButtonId: qsTr("Back")
        visible: monthlyPaidEmployeeDetail.visible || hourlyPaidEmployeeDetail.visible || salesmanEmployeeDetail.visible
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: UiSchemes.hscale(10)
        anchors.topMargin: UiSchemes.vscale(10)
        onButtonClicked: {
            monthlyPaidEmployeeDetail.visible = false
            hourlyPaidEmployeeDetail.visible = false
            salesmanEmployeeDetail.visible = false
        }
    }

    Rectangle {
        id: employeeListRect
        width:  window.width * 0.81
        height: window.height * 0.82
        color: "#aedde4"
        anchors.centerIn: parent

        EmployeeDetails {
            id: employeeDetails
            visible: !addUserPushButton.isChecked && addUserPushButton.visible
            anchors.fill: parent
        }

        AddEmployee {
            id: addEmployee
            width:  window.width * 0.74
            height: window.height * 0.73
            anchors.centerIn: parent
            visible: !employeeDetails.visible && addUserPushButton.visible
            onUpdateKeyboardPosition: {
                inputPanel.width = Qt.binding(function() { return UiSchemes.hscale(width); })
                inputPanel.x = Qt.binding(function() { return UiSchemes.hscale(x); })
                inputPanel.y = Qt.binding(function() { return UiSchemes.vscale(y); })
            }
        }

        MonthlyPaidEmployeeDetail {
            id: monthlyPaidEmployeeDetail
            visible: false
            width:  window.width * 0.74
            height: window.height * 0.73
            anchors.centerIn: parent
            onUpdateKeyboardPosition: {
                inputPanel.width = Qt.binding(function() { return UiSchemes.hscale(width); })
                inputPanel.x = Qt.binding(function() { return UiSchemes.hscale(x); })
                inputPanel.y = Qt.binding(function() { return UiSchemes.vscale(y); })
            }
        }

        HourlyPaidEmployeeDetail {
            id:hourlyPaidEmployeeDetail
            visible: false
            width:  window.width * 0.74
            height: window.height * 0.73
            anchors.centerIn: parent
            onUpdateKeyboardPosition: {
                inputPanel.width = Qt.binding(function() { return UiSchemes.hscale(width); })
                inputPanel.x = Qt.binding(function() { return UiSchemes.hscale(x); })
                inputPanel.y = Qt.binding(function() { return UiSchemes.vscale(y); })
            }
        }

        SalesmanEmployeeDetail {
            id:salesmanEmployeeDetail
            visible: false
            width:  window.width * 0.74
            height: window.height * 0.73
            anchors.centerIn: parent
            onUpdateKeyboardPosition: {
                inputPanel.width = Qt.binding(function() { return UiSchemes.hscale(width); })
                inputPanel.x = Qt.binding(function() { return UiSchemes.hscale(x); })
                inputPanel.y = Qt.binding(function() { return UiSchemes.vscale(y); })
            }
        }

    }

    InputPanel {
        id: inputPanel
        width: parent.width * 0.75
        visible: Qt.inputMethod.visible
    }

    Text {
        id: infoMessage
        text: qsTr("")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "#3f797e"
        font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(32) }
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: UiSchemes.vscale(10)

        PropertyAnimation {
            id: showtextAnimation
            target: infoMessage
            property: "opacity"
            to: 0
            from: 1
            duration: 3000

            onFinished: {
                infoMessage.text = ""
            }
        }
    }

    Component.onCompleted: {
        UiSchemes.screenWidth = Qt.binding(function() { return window.width; })
        UiSchemes.screenHeight = Qt.binding(function() { return window.height; })
        EmployeeManagment.initPage();
    }
}

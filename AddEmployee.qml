import QtQuick 2.12
import UiSchemes 1.0
import QtQuick.Controls 2.12

Item {
    id: addEmployee

    function resetData() {
        employeeTypeList.currentIndex = 0;
        employeeNameData.text = "";
        employeeSrData.text = "";
        errorMessage.text = "";
        showListPushButton.isChecked = false;
    }

    signal updateKeyboardPosition(var x,var y,var width);

    Connections {
        target: EmployeeManagment

        onErrorAddingEmployee : {
            errorMessage.text = pMessage;
        }
    }

    Column {
        id: addEmployeeColumn
        width: addEmployee.width
        height: addEmployee.height
        anchors.left: parent.left
        anchors.top: addEmployee.top
        anchors.topMargin: UiSchemes.vscale(5)
        spacing: UiSchemes.tscale(5)

        Row {
            id: employeeNameDetails
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: UiSchemes.hscale(5)
            spacing: UiSchemes.tscale(5)

            Text {
                id: employeeNameTitle
                height: UiSchemes.vscale(50)
                text: qsTr("Name: ")
                width: UiSchemes.hscale(300)
                verticalAlignment: Text.AlignVCenter
                font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(26) }
                anchors.verticalCenter: employeeName.verticalCenter
            }

            Rectangle {
                id: employeeName
                width: parent.width - employeeNameTitle.width - UiSchemes.hscale(20)
                height: UiSchemes.vscale(50)
                color: "#A0FFFFFF"
                border.color: "#f9c2c2"
                border.width: UiSchemes.tscale(1)
                radius: UiSchemes.tscale(3)

                TextInput {
                    id: employeeNameData
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(26) }
                    anchors.fill: parent
                    onEditingFinished: parent.forceActiveFocus()
                    Keys.onReturnPressed: parent.forceActiveFocus()
                    Keys.onEnterPressed: parent.forceActiveFocus()
                    onFocusChanged: {
                        if(employeeNameData.focus)
                            updateKeyboardPosition(490, 150, employeeNameData.width)
                        showListPushButton.isChecked = false;
                    }
                }
            }
        }

        Row {
            id: employeeSrDetails
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: UiSchemes.hscale(5)
            spacing: UiSchemes.tscale(5)

            Text {
                id: employeeSrTitle
                height: UiSchemes.vscale(50)
                width: UiSchemes.hscale(300)
                text: qsTr("Social security number: ")
                verticalAlignment: Text.AlignVCenter
                font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(26) }
                anchors.verticalCenter: employeeSr.verticalCenter
            }

            Rectangle {
                id: employeeSr
                width: parent.width - employeeSrTitle.width - UiSchemes.hscale(20)
                height: UiSchemes.vscale(50)
                color: "#A0FFFFFF"
                border.color: "#f9c2c2"
                border.width: UiSchemes.tscale(1)
                radius: UiSchemes.tscale(3)

                TextInput {
                    id: employeeSrData
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(26) }
                    anchors.fill: parent
                    onEditingFinished: parent.forceActiveFocus()
                    Keys.onReturnPressed: parent.forceActiveFocus()
                    Keys.onEnterPressed: parent.forceActiveFocus()
                    onFocusChanged: {
                        if(employeeSrData.focus)
                            updateKeyboardPosition(490, 200, employeeNameData.width)
                        showListPushButton.isChecked = false;
                    }
                }
            }
        }

        Row {
            id: employeeTypeDetails
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: UiSchemes.hscale(5)
            spacing: UiSchemes.tscale(5)

            Text {
                id: employeetypeTitle
                height: UiSchemes.vscale(50)
                width: UiSchemes.hscale(300)
                text: qsTr("Employee Type: ")
                verticalAlignment: Text.AlignVCenter
                font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(26) }
                anchors.verticalCenter: employeeTypeDetails.verticalCenter
            }

            Rectangle {
                id: employeeType
                width: parent.width - employeeSrTitle.width - showListPushButton.width- UiSchemes.hscale(30)
                height: UiSchemes.vscale(50)
                color: "#A0FFFFFF"
                border.color: "#f9c2c2"
                border.width: UiSchemes.tscale(1)
                radius: UiSchemes.tscale(3)

                Text {
                    id: employeeTypeData
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: employeeTypeList.currentItem.name
                    font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(26) }
                    anchors.fill: parent
                }



            }

            PushButton {
                id: showListPushButton
                width: UiSchemes.hscale(50)
                height: UiSchemes.vscale(50)
                strButtonId: isChecked ? qsTr("<") : qsTr(">")
                rotation: 90
            }

        }

    }

    Component {
        id: contactsDelegate
        Rectangle {
            id: wrapper
            property var typeId: model.employeeTypeId
            property alias name: contactInfo.text
            width: employeeType.width
            height: contactInfo.height + UiSchemes.vscale(10)
            color: ListView.isCurrentItem ? "#3f797e" : "#5aadb3"
            Text {
                id: contactInfo
                text: model.name
                color: wrapper.ListView.isCurrentItem ? "#5aadb3" : "#3f797e"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(22) }
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    employeeTypeList.currentIndex = index;
                    showListPushButton.isChecked = false;
                    showListPushButton.forceActiveFocus();
                }
            }
        }
    }

    ListView {
        id: employeeTypeList
        visible: showListPushButton.isChecked
        width:  employeeType.width
        height: UiSchemes.vscale(250)
        spacing: UiSchemes.vscale(5)
        anchors.top: addEmployee.top
        anchors.left: addEmployee.left
        anchors.topMargin: UiSchemes.vscale(170)
        anchors.leftMargin: UiSchemes.hscale(310)

        model: ListModel {
            id: employeeTypeModel
            ListElement {
                name: "Select Type"
                employeeTypeId: -1
            }
            ListElement {
                name: "Monthly Paid"
                employeeTypeId: 0
            }
            ListElement {
                name: "Hourly Paid"
                employeeTypeId: 1
            }
            ListElement {
                name: "SalesMan"
                employeeTypeId: 2
            }
        }
        delegate: contactsDelegate
        focus: true
    }

    Text {
        id: errorMessage
        width: parent.width
        color: "#f33d3d"
        text: qsTr("")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(26) }
        anchors.bottom: submitPushButton.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: UiSchemes.vscale(10)
    }

    PushButton {
        id: submitPushButton
        width: UiSchemes.hscale(150)
        height: UiSchemes.vscale(50)
        strButtonId: qsTr("Submit")
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: UiSchemes.vscale(20)

        onButtonClicked: {
            EmployeeManagment.addEmployee(employeeNameData.text,employeeSrData.text,employeeTypeList.currentItem.typeId);
        }
    }
}

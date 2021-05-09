import QtQuick 2.12
import UiSchemes 1.0
import QtQuick.Controls 2.12

Item {
    id:hourlyPaidEmployeeDetail

    property var employeeObject: null

    signal updateKeyboardPosition(var x,var y,var width);

    Row {
        id:nameRow
        width: hourlyPaidEmployeeDetail.width
        height: UiSchemes.vscale(50)
        anchors.top: hourlyPaidEmployeeDetail.top
        anchors.left: hourlyPaidEmployeeDetail.left
        TextRect {
            id: nameTitle
            width: UiSchemes.hscale(200)
            height: UiSchemes.vscale(50)
            textData: qsTr("Name:")
            fontPixel: UiSchemes.tscale(22)
            bgColor: "transparent"
            borderColor: "transparent"
            fontHorizontalAlign: Text.AlignLeft
        }
        TextRect {
            id: nameData
            width: UiSchemes.hscale(700)
            height: UiSchemes.vscale(50)
            textData: (employeeObject !== null) ? employeeObject.employeeName : ""
            fontPixel: UiSchemes.tscale(22)
            bgColor: "transparent"
            borderColor: "transparent"
            fontHorizontalAlign: Text.AlignLeft
        }
    }

    Row {
        id:securityNumberRow
        width: hourlyPaidEmployeeDetail.width
        height: UiSchemes.vscale(50)
        anchors.top: nameRow.bottom
        anchors.left: hourlyPaidEmployeeDetail.left
        TextRect {
            id: securityNumberTitle
            width: UiSchemes.hscale(200)
            height: UiSchemes.vscale(50)
            textData: qsTr("Security Number:")
            fontPixel: UiSchemes.tscale(22)
            bgColor: "transparent"
            borderColor: "transparent"
            fontHorizontalAlign: Text.AlignLeft
        }
        TextRect {
            id: securityNumberData
            width: UiSchemes.hscale(700)
            height: UiSchemes.vscale(50)
            textData: (employeeObject !== null) ? employeeObject.securityNumber : ""
            fontPixel: UiSchemes.tscale(22)
            bgColor: "transparent"
            borderColor: "transparent"
            fontHorizontalAlign: Text.AlignLeft
        }
    }

    Row {
        id:employeeTypeRow
        width: hourlyPaidEmployeeDetail.width
        height: UiSchemes.vscale(50)
        anchors.top: securityNumberRow.bottom
        anchors.left: hourlyPaidEmployeeDetail.left
        TextRect {
            id: employeeTypeTitle
            width: UiSchemes.hscale(200)
            height: UiSchemes.vscale(50)
            textData: qsTr("Employee Type:")
            fontPixel: UiSchemes.tscale(22)
            bgColor: "transparent"
            borderColor: "transparent"
            fontHorizontalAlign: Text.AlignLeft
        }

        TextRect {
            id: employeeTypeData
            width: UiSchemes.hscale(700)
            height: UiSchemes.vscale(50)
            textData: (employeeObject !== null) ? qsTr(EmployeeModel.getEmployeeType(employeeObject.employeeType)) : ""
            fontPixel: UiSchemes.tscale(22)
            bgColor: "transparent"
            borderColor: "transparent"
            fontHorizontalAlign: Text.AlignLeft
        }
    }

    TextRect {
        id: salaryDetailsTitle
        width: UiSchemes.hscale(200)
        height: UiSchemes.vscale(50)
        textData: qsTr("Salary Detail:")
        fontPixel: UiSchemes.tscale(22)
        bgColor: "transparent"
        borderColor: "transparent"
        fontHorizontalAlign: Text.AlignLeft
        anchors.top: employeeTypeRow.bottom
        anchors.left: hourlyPaidEmployeeDetail.left
    }

    Row {
        id:salaryRow
        width: hourlyPaidEmployeeDetail.width
        height: UiSchemes.vscale(50)
        anchors.top: salaryDetailsTitle.bottom
        anchors.left: hourlyPaidEmployeeDetail.left

        TextRect {
            id: dateTitle
            width: UiSchemes.hscale(300)
            height: UiSchemes.vscale(50)
            textData: qsTr("Date")
            fontPixel: UiSchemes.tscale(22)
            bgColor: "#2ed1e6"
        }

        TextRect {
            id: compensationTitle
            width: UiSchemes.hscale(300)
            height: UiSchemes.vscale(50)
            textData: qsTr("Compansastion (US$)")
            fontPixel: UiSchemes.tscale(22)
            bgColor: "#2ed1e6"
        }

        TextRect {
            id: hourTitle
            width: UiSchemes.hscale(100)
            height: UiSchemes.vscale(50)
            textData: qsTr("Hour")
            fontPixel: UiSchemes.tscale(22)
            bgColor: "#2ed1e6"
        }

        PushButton {
            id: addButton
            width: UiSchemes.hscale(50)
            height: UiSchemes.vscale(50)
            strButtonId: qsTr("+")
            onButtonClicked: {
                addSalaryRect.visible = true;
            }
        }
    }

    ListView {
        id: salaryList
        width: UiSchemes.hscale(760)
        height: UiSchemes.vscale(250)
        anchors.top: salaryRow.bottom
        anchors.left: hourlyPaidEmployeeDetail.left

        ScrollBar.vertical: ScrollBar {
            id:scrollbarView
            anchors.left: salaryList.right
            anchors.leftMargin: UiSchemes.hscale(-8)
            policy: (salaryList.visibleArea.heightRatio < 1.0 ) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff

            contentItem: Rectangle {
                color: "#2ed1e6"
                implicitWidth: UiSchemes.hscale(8)
                radius: UiSchemes.tscale(2)
            }
        }

        clip: true
        model: employeeObject
        delegate: Row {
            id:salaryDataRow
            width: hourlyPaidEmployeeDetail.width
            height: UiSchemes.vscale(50)

            TextRect {
                id: dateData
                width: UiSchemes.hscale(300)
                height: UiSchemes.vscale(50)
                textData: Date
                fontPixel: UiSchemes.tscale(22)
            }

            TextRect {
                id: compensationData
                width: UiSchemes.hscale(300)
                height: UiSchemes.vscale(50)
                textData: Compansastion
                fontPixel: UiSchemes.tscale(22)
            }

            TextRect {
                id: hourData
                width: UiSchemes.hscale(100)
                height: UiSchemes.vscale(50)
                textData: SpentHour
                fontPixel: UiSchemes.tscale(22)
            }

            PushButton {
                id: removeButton
                width: UiSchemes.hscale(50)
                height: UiSchemes.vscale(50)
                strButtonId: qsTr("-")
                onButtonClicked: {
                    employeeObject.removeSalary(index);
                }
            }
        }
    }

    Rectangle {
        id:addSalaryRect
        anchors.fill: hourlyPaidEmployeeDetail
        color: "#FFFFFF"
        visible: false

        Row {
            id:dateRow
            height: UiSchemes.vscale(50)
            width: UiSchemes.hscale(560)
            anchors.top: addSalaryRect.top
            anchors.topMargin: UiSchemes.vscale(100)
            anchors.left: addSalaryRect.left
            anchors.leftMargin: UiSchemes.hscale(100)
            spacing: 10

            TextRect {
                id: selectedateTitle
                width: UiSchemes.hscale(200)
                height: UiSchemes.vscale(50)
                textData: qsTr("Select Date:")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "transparent"
                borderColor: "transparent"
                fontHorizontalAlign: Text.AlignLeft

            }

            DateEdit {
                id: selectedateData
                width: UiSchemes.hscale(300)
                height: UiSchemes.vscale(50)
                dateFormate: "dd,MMM,yyyy"
                anchors.verticalCenter: selectedateTitle.verticalCenter
            }
        }

        Row {
            id: employeeCMPDetails
            width: UiSchemes.hscale(500)
            height: UiSchemes.vscale(50)
            anchors.top: dateRow.bottom
            anchors.left: dateRow.left
            anchors.topMargin: UiSchemes.vscale(20)
            spacing: 10

            TextRect {
                id: employeeCMPTitle
                height: UiSchemes.vscale(50)
                width: UiSchemes.hscale(200)
                textData: qsTr("Compansation: ")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "transparent"
                borderColor: "transparent"
                fontHorizontalAlign: Text.AlignLeft
            }

            Rectangle {
                id: employeeCMP
                width: UiSchemes.hscale(300)
                height: UiSchemes.vscale(50)
                color: "#DFFFFFFF"
                border.color: "#f9c2c2"
                border.width: UiSchemes.tscale(1)
                radius: UiSchemes.tscale(3)

                TextInput {
                    id: employeeCMPData
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    inputMethodHints: Qt.ImhDigitsOnly
                    font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(26) }
                    anchors.fill: parent
                    onEditingFinished: parent.forceActiveFocus()
                    Keys.onReturnPressed: parent.forceActiveFocus()
                    Keys.onEnterPressed: parent.forceActiveFocus()
                    onFocusChanged: {
                        if(employeeCMPData.focus)
                            updateKeyboardPosition(180, 320, hourlyPaidEmployeeDetail.width)
                    }
                }
            }

            TextRect {
                id: employeeCMPUnit
                width: UiSchemes.hscale(60)
                height: UiSchemes.vscale(50)
                textData: qsTr("US$")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "transparent"
                borderColor: "transparent"
                fontHorizontalAlign: Text.AlignLeft
            }
        }

        Row {
            id: hourDetails
            width: UiSchemes.hscale(500)
            height: UiSchemes.vscale(50)
            anchors.top: employeeCMPDetails.bottom
            anchors.left: dateRow.left
            anchors.topMargin: UiSchemes.vscale(20)
            spacing: UiSchemes.hscale(10)

            TextRect {
                id: hourTitleRect
                height: UiSchemes.vscale(50)
                width: UiSchemes.hscale(200)
                textData: qsTr("Hour: ")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "transparent"
                borderColor: "transparent"
                fontHorizontalAlign: Text.AlignLeft
            }

            Rectangle {
                id: hourDataRect
                width: UiSchemes.hscale(300)
                height: UiSchemes.vscale(50)
                color: "#DFFFFFFF"
                border.color: "#f9c2c2"
                border.width: UiSchemes.tscale(1)
                radius: UiSchemes.tscale(3)

                TextInput {
                    id: hourDataInput
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    inputMethodHints: Qt.ImhDigitsOnly
                    font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(26) }
                    anchors.fill: parent
                    onEditingFinished: parent.forceActiveFocus()
                    Keys.onReturnPressed: parent.forceActiveFocus()
                    Keys.onEnterPressed: parent.forceActiveFocus()
                    onFocusChanged: {
                        if(hourDataInput.focus)
                            updateKeyboardPosition(180, 390, hourlyPaidEmployeeDetail.width - UiSchemes.hscale(50))
                    }
                }
            }
        }


        PushButton {
            id:addPushButton
            width: UiSchemes.hscale(150)
            height: UiSchemes.vscale(60)
            strButtonId: qsTr("Add Salary")
            anchors.top: hourDetails.bottom
            anchors.topMargin: UiSchemes.vscale(20)
            anchors.horizontalCenter: dateRow.horizontalCenter
            anchors.horizontalCenterOffset: UiSchemes.hscale(-90)
            onButtonClicked: {
                if(employeeObject.addSalary(selectedateData.currentDate,employeeCMPData.text,hourDataInput.text)) {
                  addSalaryRect.visible = false;
                }
            }
        }

        PushButton {
            id:cancelPushButton
            width: UiSchemes.hscale(150)
            height: UiSchemes.vscale(60)
            strButtonId: qsTr("Cancel")
            anchors.top: hourDetails.bottom
            anchors.topMargin: UiSchemes.vscale(20)
            anchors.horizontalCenter: dateRow.horizontalCenter
            anchors.horizontalCenterOffset: UiSchemes.hscale(90)
            onButtonClicked: {
                  addSalaryRect.visible = false;
            }
        }

        onVisibleChanged: {
            employeeCMPData.text = "";
            hourDataInput.text = "";
            selectedateData.closeCalendar();
        }

    }

    onVisibleChanged: {
        selectedateData.closeCalendar();
        addSalaryRect.visible = false;
    }
}

import QtQuick 2.12
import UiSchemes 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12

Item {
    id:salesmanEmployeeDetail

    property var employeeObject: null

    signal updateKeyboardPosition(var x,var y,var width);

    Row {
        id:nameRow
        height: UiSchemes.vscale(50)
        anchors.top: salesmanEmployeeDetail.top
        anchors.left: salesmanEmployeeDetail.left
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
            width: UiSchemes.hscale(300)
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
        height: UiSchemes.vscale(50)
        anchors.top: nameRow.top
        anchors.left: nameRow.right
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
            width: UiSchemes.hscale(300)
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
        height: UiSchemes.vscale(50)
        anchors.top: nameRow.bottom
        anchors.left: salesmanEmployeeDetail.left
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
        anchors.left: salesmanEmployeeDetail.left
    }

    Flickable {
        id: salaryFlickList
        width: salesmanEmployeeDetail.width
        height: UiSchemes.hscale(310)
        flickableDirection: Flickable.HorizontalFlick
        boundsBehavior: Flickable.StopAtBounds
        contentWidth: salaryRow.implicitWidth
        contentHeight: salaryRow.height + salaryList.height
        anchors.top: salaryDetailsTitle.bottom
        anchors.left: salaryDetailsTitle.left
        clip: true

        Row {
            id:salaryRow
            height: UiSchemes.vscale(60)
            anchors.top: parent.top
            anchors.left: parent.left

            PushButton {
                id: addButton
                width: UiSchemes.hscale(60)
                height: UiSchemes.vscale(60)
                strButtonId: qsTr("+")
                onButtonClicked: {
                    addSalaryRect.visible = true;
                }
            }

            TextRect {
                id: dateTitle
                width: UiSchemes.hscale(195)
                height: UiSchemes.vscale(60)
                textData: qsTr("Date")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "#2ed1e6"
            }

            TextRect {
                id: compensationTitle
                width: UiSchemes.hscale(250)
                height: UiSchemes.vscale(60)
                textData: qsTr("Compansastion (US$)")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "#2ed1e6"
            }

            TextRect {
                id: claimedOutcomeTitle
                width: UiSchemes.hscale(260)
                height: UiSchemes.vscale(60)
                textData: qsTr("Claimed Outcome (US$)")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "#2ed1e6"
            }

            TextRect {
                id: realisedOutcomeTitle
                width: UiSchemes.hscale(260)
                height: UiSchemes.vscale(60)
                textData: qsTr("Realised Outcome(US$)")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "#2ed1e6"
            }

            TextRect {
                id: totalRealisedOutcomeTitle
                width: UiSchemes.hscale(250)
                height: UiSchemes.vscale(60)
                textData: qsTr("Total Realised Outcome (US$)")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "#2ed1e6"
            }

            TextRect {
                id: bonousTitle
                width: UiSchemes.hscale(100)
                height: UiSchemes.vscale(60)
                textData: qsTr("Bonous (%)")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "#2ed1e6"
            }
        }

        ListView {
            id: salaryList
            width: salaryRow.implicitWidth
            height: UiSchemes.vscale(250)
            anchors.top: salaryRow.bottom
            anchors.left: parent.left

            ScrollBar.vertical: CustomVScrollBar {
                id:verticalScrollbar
                width: UiSchemes.hscale(10)
                height: salaryList.height
                targetView: salaryList
                anchors.bottom: parent.bottom
                anchors.right: parent.right
            }

            clip: true
            model: employeeObject
            delegate: Row {
                id:salaryDataRow
                height: realisedOutcomeData.height

                PushButton {
                    id: removeButton
                    width: UiSchemes.hscale(60)
                    height: UiSchemes.vscale(50)
                    strButtonId: qsTr("-")
                    onButtonClicked: {
                        employeeObject.removeSalary(index);
                    }
                }

                TextRect {
                    id: dateData
                    width: UiSchemes.hscale(195)
                    height: realisedOutcomeData.height
                    textData: Date
                    fontPixel: UiSchemes.tscale(22)
                    fontVerticalAlign: Text.AlignTop
                }

                TextRect {
                    id: compensationData
                    width: UiSchemes.hscale(250)
                    height: realisedOutcomeData.height
                    textData: Compansastion
                    fontPixel: UiSchemes.tscale(22)
                    fontVerticalAlign: Text.AlignTop
                }

                TextRect {
                    id: claimedOutcomeData
                    width: UiSchemes.hscale(260)
                    height: realisedOutcomeData.height
                    textData: ClaimedOutcome
                    fontPixel: UiSchemes.tscale(22)
                    fontVerticalAlign: Text.AlignTop
                }

                Rectangle {
                    id: realisedOutcomeData
                    width: UiSchemes.hscale(260)
                    height: (realisedOutcomeList.implicitHeight === 0) ? UiSchemes.vscale(50) : realisedOutcomeList.implicitHeight
                    color: "transparent"
                    border.color: "transparent"
                    border.width: UiSchemes.hscale(1)
                    Column {
                        id: realisedOutcomeList
                        Repeater {
                            model: RealisedOutcome

                            TextRect {
                                id: relaisedOutcomeData
                                width: UiSchemes.hscale(260)
                                height: UiSchemes.vscale(50)
                                textData: modelData
                                fontPixel: UiSchemes.tscale(22)
                                fontVerticalAlign: Text.AlignTop
                            }
                        }
                    }
                }

                TextRect {
                    id: totalOutcomeData
                    width: UiSchemes.hscale(250)
                    height: realisedOutcomeData.height
                    textData: TotalRealisedOutcome
                    fontPixel: UiSchemes.tscale(22)
                    fontVerticalAlign: Text.AlignTop
                }

                TextRect {
                    id: bonousData
                    width: UiSchemes.hscale(100)
                    height: realisedOutcomeData.height
                    textData: Bonous
                    fontPixel: UiSchemes.tscale(22)
                    fontVerticalAlign: Text.AlignTop
                }
            }
        }

        ScrollBar.horizontal: CustomHScrollBar {
            id:horizontalScrollbar
            width: salaryFlickList.width
            height: UiSchemes.hscale(10)
            targetView: salaryFlickList
            anchors.bottom: salaryFlickList.bottom
            anchors.left: salaryFlickList.left
        }
    }

    Rectangle {
        id:addSalaryRect
        anchors.fill: salesmanEmployeeDetail
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
                dateFormate: "MMM,yyyy"
                anchors.verticalCenter: selectedateTitle.verticalCenter

                onCalendarDateChanged: {
                    employeeCMPData.text = employeeObject.getCompensastion(selectedateData.currentDate);
                    claimedOutcomeDataInput.text = employeeObject.getClaimedOutcome(selectedateData.currentDate);
                    employeeCMPData.enabled = (employeeCMPData.text == "") ? true : false;
                    claimedOutcomeDataInput.enabled = (claimedOutcomeDataInput.text == "") ? true : false;
                }
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
                    enabled: true
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
                            updateKeyboardPosition(180, 320, salesmanEmployeeDetail.width - UiSchemes.hscale(50))
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
            id: claimedOutcomeDetails
            width: UiSchemes.hscale(500)
            height: UiSchemes.vscale(50)
            anchors.top: employeeCMPDetails.bottom
            anchors.left: dateRow.left
            anchors.topMargin: UiSchemes.vscale(20)
            spacing: 10

            TextRect {
                id: claimedOutcomeTitleRect
                height: UiSchemes.vscale(50)
                width: UiSchemes.hscale(200)
                textData: qsTr("Claimed Outcome: ")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "transparent"
                borderColor: "transparent"
                fontHorizontalAlign: Text.AlignLeft
            }

            Rectangle {
                id: claimedOutcome
                width: UiSchemes.hscale(300)
                height: UiSchemes.vscale(50)
                color: "#DFFFFFFF"
                border.color: "#f9c2c2"
                border.width: UiSchemes.tscale(1)
                radius: UiSchemes.tscale(3)

                TextInput {
                    id: claimedOutcomeDataInput
                    enabled: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    inputMethodHints: Qt.ImhDigitsOnly
                    font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(26) }
                    anchors.fill: parent
                    onEditingFinished: parent.forceActiveFocus()
                    Keys.onReturnPressed: parent.forceActiveFocus()
                    Keys.onEnterPressed: parent.forceActiveFocus()
                    onFocusChanged: {
                        if(claimedOutcomeDataInput.focus)
                            updateKeyboardPosition(250,60, salesmanEmployeeDetail.width - UiSchemes.hscale(150))
                    }
                }
            }

            TextRect {
                id: claimedOutcomeUnit
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
            id: realisedOutcomeDetails
            width: UiSchemes.hscale(500)
            height: UiSchemes.vscale(50)
            anchors.top: claimedOutcomeDetails.bottom
            anchors.left: dateRow.left
            anchors.topMargin: UiSchemes.vscale(20)
            spacing: 10

            TextRect {
                id: realisedOutcomeTitleRect
                height: UiSchemes.vscale(50)
                width: UiSchemes.hscale(200)
                textData: qsTr("Realised Outcome: ")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "transparent"
                borderColor: "transparent"
                fontHorizontalAlign: Text.AlignLeft
            }

            Rectangle {
                id: realisedOutcome
                width: UiSchemes.hscale(300)
                height: UiSchemes.vscale(50)
                color: "#DFFFFFFF"
                border.color: "#f9c2c2"
                border.width: UiSchemes.tscale(1)
                radius: UiSchemes.tscale(3)

                TextInput {
                    id: realisedOutcomeDataInput
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    inputMethodHints: Qt.ImhDigitsOnly
                    font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(26) }
                    anchors.fill: parent
                    onEditingFinished: parent.forceActiveFocus()
                    Keys.onReturnPressed: parent.forceActiveFocus()
                    Keys.onEnterPressed: parent.forceActiveFocus()
                    onFocusChanged: {
                        if(realisedOutcomeDataInput.focus)
                            updateKeyboardPosition(250, 120, salesmanEmployeeDetail.width - UiSchemes.hscale(150))
                    }
                }
            }

            TextRect {
                id: realisedOutcomeUnit
                width: UiSchemes.hscale(60)
                height: UiSchemes.vscale(50)
                textData: qsTr("US$")
                fontPixel: UiSchemes.tscale(22)
                bgColor: "transparent"
                borderColor: "transparent"
                fontHorizontalAlign: Text.AlignLeft
            }
        }

        PushButton {
            id:addPushButton
            width: UiSchemes.hscale(150)
            height: UiSchemes.vscale(60)
            strButtonId: qsTr("Add Salary")
            anchors.top: realisedOutcomeDetails.bottom
            anchors.topMargin: UiSchemes.vscale(20)
            anchors.horizontalCenter: dateRow.horizontalCenter
            anchors.horizontalCenterOffset: UiSchemes.hscale(-90)
            onButtonClicked: {
                if(employeeObject.addSalary(selectedateData.currentDate,
                                            claimedOutcomeDataInput.text,
                                            claimedOutcomeDataInput.text,
                                            realisedOutcomeDataInput.text))
                {
                    addSalaryRect.visible = false;
                }
            }
        }

        PushButton {
            id:cancelPushButton
            width: UiSchemes.hscale(150)
            height: UiSchemes.vscale(60)
            strButtonId: qsTr("Cancel")
            anchors.top: realisedOutcomeDetails.bottom
            anchors.topMargin: UiSchemes.vscale(20)
            anchors.horizontalCenter: dateRow.horizontalCenter
            anchors.horizontalCenterOffset: UiSchemes.hscale(90)
            onButtonClicked: {
                addSalaryRect.visible = false;
            }
        }

        onVisibleChanged: {
            employeeCMPData.text = employeeObject.getCompensastion(selectedateData.currentDate);
            claimedOutcomeDataInput.text = employeeObject.getClaimedOutcome(selectedateData.currentDate);
            realisedOutcomeDataInput.text = "";
            employeeCMPData.enabled = (employeeCMPData.text == "") ? true : false;
            claimedOutcomeDataInput.enabled = (claimedOutcomeDataInput.text == "") ? true : false;
            selectedateData.closeCalendar();
        }
    }

    onVisibleChanged: {
        selectedateData.closeCalendar();
        addSalaryRect.visible = false;
    }
}

import QtQuick 2.0
import UiSchemes 1.0
import QtQuick.Controls 2.12

Item {
    id: employeeDetails
    property var employeeCount: employeeList.count

    Row {
        id: listviewHeader
        width: employeeDetails.width
        height: UiSchemes.vscale(80)
        anchors.top: dateRow.bottom
        anchors.topMargin: UiSchemes.vscale(10)
        anchors.left: employeeDetails.left
        anchors.leftMargin: UiSchemes.hscale(10)

        TextRect {
            id:nameTitle
            width: UiSchemes.hscale(350)
            height: listviewHeader.height
            textData: qsTr("Name")
            fontPixel: UiSchemes.tscale(26)
            bgColor: "#2ed1e6"
            anchors.verticalCenter: parent.verticalCenter
        }
        TextRect {
            id:securityNumberTitle
            width: UiSchemes.hscale(350)
            height: listviewHeader.height
            textData: qsTr("Security number")
            fontPixel: UiSchemes.tscale(26)
            bgColor: "#2ed1e6"
            anchors.verticalCenter: parent.verticalCenter
        }
        TextRect {
            id:employeeTypeTitle
            width: UiSchemes.hscale(150)
            height: listviewHeader.height
            textData: qsTr("Employee Type")
            fontPixel: UiSchemes.tscale(26)
            bgColor: "#2ed1e6"
            anchors.verticalCenter: parent.verticalCenter
        }
        TextRect {
            id:compansastionTitle
            width: UiSchemes.hscale(250)
            height: listviewHeader.height
            textData: qsTr("Compansastion (US$)")
            fontPixel: UiSchemes.tscale(26)
            bgColor: "#2ed1e6"
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    ListView {
        id: employeeList
        width: listviewHeader.width - UiSchemes.hscale(10)
        height: employeeDetails.height - listviewHeader.height - UiSchemes.vscale(150)
        anchors.left: listviewHeader.left
        anchors.top: listviewHeader.bottom
        boundsBehavior: ListView.StopAtBounds
        clip: true

        ScrollBar.vertical: ScrollBar {
            id:scrollbarView
            anchors.left: employeeList.right
            anchors.leftMargin: UiSchemes.hscale(-10)
            policy: (employeeList.visibleArea.heightRatio < 1.0 ) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff

            contentItem: Rectangle {
                color: "#2ed1e6"
                implicitWidth: UiSchemes.hscale(8)
                radius: UiSchemes.tscale(2)
            }
        }

        model: EmployeeModel

        delegate: Item {
            id: employeeData
            width: listviewData.width
            height: UiSchemes.vscale(50)
            property var employeeObject: EmployeeObject
            property var employeeType: EmployeeType

            Rectangle {
                id: highlightRect
                anchors.fill: parent
                color: "#2ed1e6"
                visible: employeeData.ListView.isCurrentItem
            }

            Row {
                id: listviewData
                height: parent.height
                anchors.centerIn: employeeData

                TextRect {
                    id:nameData
                    width: UiSchemes.hscale(350)
                    height: employeeData.height
                    textData: EmployeeName
                    fontPixel: UiSchemes.tscale(24)
                    anchors.verticalCenter: parent.verticalCenter
                }
                TextRect {
                    id:securityNumberData
                    width: UiSchemes.hscale(350)
                    height: employeeData.height
                    textData: SocialSecurityNumber
                    fontPixel: UiSchemes.tscale(24)
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextRect {
                    id:employeeTypeData
                    width: UiSchemes.hscale(150)
                    height: employeeData.height
                    textData: qsTr(EmployeeModel.getEmployeeType(EmployeeType))
                    fontPixel: UiSchemes.tscale(24)
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextRect {
                    id:compansastionData
                    width: UiSchemes.hscale(250)
                    height: employeeData.height
                    textData: Compensastion
                    fontPixel: UiSchemes.tscale(24)
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            MouseArea {
                id:mouseArea
                anchors.fill: parent
                onClicked: {
                   employeeList.currentIndex = index;
                }
            }
        }

    }

    PushButton {
        id: showPushButton
        width: UiSchemes.hscale(150)
        height: UiSchemes.vscale(50)
        strButtonId: qsTr("Show")
        visible: (employeeList.currentIndex !== -1)
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: UiSchemes.vscale(10)
        onButtonClicked: {
            if(employeeList.currentItem.employeeType === 0) {
                monthlyPaidEmployeeDetail.employeeObject = employeeList.currentItem.employeeObject
                monthlyPaidEmployeeDetail.visible = true;
            } else if(employeeList.currentItem.employeeType === 1) {
                hourlyPaidEmployeeDetail.employeeObject = employeeList.currentItem.employeeObject
                hourlyPaidEmployeeDetail.visible = true;
            } else if(employeeList.currentItem.employeeType === 2) {
                salesmanEmployeeDetail.employeeObject = employeeList.currentItem.employeeObject;
                salesmanEmployeeDetail.visible = true;
            }
        }
    }

    Row {
        id:dateRow
        height: UiSchemes.vscale(50)
        width: UiSchemes.hscale(560)
        anchors.top: employeeDetails.top
        anchors.topMargin: UiSchemes.vscale(10)
        anchors.left: employeeDetails.left
        anchors.leftMargin: UiSchemes.hscale(10)
        spacing: 10

        TextRect {
            id: selectedateTitle
            width: UiSchemes.hscale(200)
            height: UiSchemes.vscale(50)
            textData: qsTr("Select Month:")
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
                EmployeeModel.setDate(selectedateData.currentDate);
            }
        }
    }

    onVisibleChanged: {
        selectedateData.closeCalendar();
        EmployeeModel.setDate(selectedateData.currentDate);
    }
}


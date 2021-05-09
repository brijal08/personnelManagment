import QtQuick 2.0
import QtQuick.Controls 1.4
import UiSchemes 1.0

Item {
    id: dateEdit

    readonly property date currentDate: calendar.selectedDate
    readonly property bool isCalendarOpened: calendar.visible
    property string dateFormate: "dd,MMM,yyyy"
    property string color: "#f9c2c2"

    signal calendarOpened;
    signal calendarClosed;
    signal calendarDateChanged;

    width: textFielddata.width + btnOpen.width
    height: textFielddata.height

    Row {
        spacing: 5
        width: parent.width
        height: parent.height

        Rectangle {
            id: employeeCMP
            width: UiSchemes.hscale(300)
            height: UiSchemes.vscale(50)
            color: "#D0FFFFFF"
            border.color: dateEdit.color
            border.width: UiSchemes.tscale(1)
            radius: UiSchemes.tscale(3)

            Text {
                id: textFielddata
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: Qt.formatDate(calendar.selectedDate, dateEdit.dateFormate);
                font { family:UiSchemes.strFontFamiliy; pixelSize: UiSchemes.tscale(26) }
                anchors.fill: parent
            }
        }

        PushButton {
            width: UiSchemes.hscale(50)
            height: textFielddata.height
            strButtonId: "*"
            onButtonClicked: {
                dateEdit.isCalendarOpened ?  closeCalendar() : openCalendar()
            }
        }

        Calendar {
            id: calendar
            visible: false
            width: parent.width
            dayOfWeekFormat: Locale.ShortFormat
            onClicked: {
                closeCalendar()
                calendarDateChanged()
            }

            function open()
            {
                calendar.selectedDate=new Date(currentDate);
                visible = true

            }

            function close()
            {
                visible = false
            }
        }
    }

    function openCalendar()
    {
        calendar.open()
        calendarOpened()
    }

    function closeCalendar()
    {
        calendar.close()
        calendarClosed()
    }
}

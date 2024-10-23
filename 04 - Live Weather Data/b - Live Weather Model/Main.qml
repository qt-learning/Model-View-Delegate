pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Qt.labs.folderlistmodel

ApplicationWindow {
    id: window
    width: 1280
    height: 800
    visible: true
    title: qsTr("Model View Delegates")

    color: "black"
    palette {
        windowText: "white"
    }

    Pane {
        anchors.fill: parent
        padding: 8

        background: null

        ColumnLayout {

            anchors.fill: parent

            enabled: !locationModel.busy && !weatherModel.busy

            LiveWeatherModel {
                id: weatherModel

                weatherRequest: locationComboBox.currentValue ?? ""
                fahrenheit: fahrenheitSwitch.checked
            }

            LiveLocationModel {
                id: locationModel

                onUpdated: locationComboBox.currentIndex = 0
            }

            TextField {
                id: locationTextField

                text: "London" // initial value
                font.pixelSize: 48
                Layout.preferredWidth: window.width / 2
                palette.text: "white"

                background: Rectangle {
                    color: "black"
                    opacity: 0.5
                }

                onAccepted: locationModel.update(text)
                Component.onCompleted: locationModel.update(text)

                BusyIndicator {
                    anchors.right: parent.right
                    height: parent.height
                    visible: !enabled
                    palette.dark: "white"
                }
            }

            ComboBox {
                id: locationComboBox

                Layout.preferredWidth: window.width / 2

                currentIndex: 0

                model: locationModel

                textRole: "locationText"
                valueRole: "weatherRequest"
            }

            Switch {
                id: fahrenheitSwitch
                text: "ºC / ºF" // "\u00B0" // UTF-16 code for degree º symbol
                font.pixelSize: 48
                checked: false
            }

            ListView {
                id: forecastListView

                Layout.fillWidth: true
                Layout.preferredHeight: 330
                Layout.alignment: Qt.AlignBottom

                orientation: ListView.Horizontal

                model: weatherModel

                delegate: ColumnLayout {
                    id: forecastDelegate

                    // ensure that each Delegate's width is such that all of them fill exactly the width of the ListView.
                    // (this binding also requires pragma ComponentBehavior: Bound)
                    width: ListView.view.width / forecastListView.count

                    required property string time
                    required property int weather_code
                    required property real temp_max
                    required property real temp_min
                    required property string units

                    Label {
                        // DAY NAME
                        text: Qt.formatDateTime(new Date(forecastDelegate.time), "ddd")

                        Layout.alignment: Qt.AlignHCenter
                        font.pixelSize: 48
                    }
                    Image {
                        // WEATHER ICON
                        source: Qt.resolvedUrl(`assets/icons/icon${forecastDelegate.weather_code}.svg`)

                        Layout.preferredHeight: 100
                        Layout.preferredWidth: 100
                        Layout.alignment: Qt.AlignHCenter

                        fillMode: Image.PreserveAspectFit
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                    }
                    Label {
                        // MAX TEMP
                        text: forecastDelegate.temp_max + forecastDelegate.units

                        Layout.alignment: Qt.AlignHCenter
                        font.pixelSize: 48
                    }
                    Label {
                        // MIN TEMP
                        text: forecastDelegate.temp_min + forecastDelegate.units

                        Layout.alignment: Qt.AlignHCenter
                        font.pixelSize: 28
                    }
                }

                add: Transition {
                    NumberAnimation {
                        property: "opacity"
                        duration: 500
                        from: 0
                        to: 1
                        easing.type: Easing.InOutCubic
                    }
                }
            }
        }
    }
}

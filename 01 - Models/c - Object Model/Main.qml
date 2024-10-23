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

            Repeater {
                model: [ // a JSON Array of JSON Objects as a model
                    { "backgroundColor": "red",     "color" : "white" },
                    { "backgroundColor": "green",   "color" : "white" },
                    { "backgroundColor": "blue",    "color" : "white" },
                    { "backgroundColor": "cyan",    "color" : "black" },
                    { "backgroundColor": "yellow",  "color" : "black" },
                    { "backgroundColor": "magenta", "color" : "white" },
                    { "backgroundColor": "white",   "color" : "black" },
                    { "backgroundColor": "black",   "color" : "white" }
                ]

                delegate: Label {
                    // different id necessary if we have Section 2c here as well
                    id: labelDelegate

                    required property string backgroundColor
                    required color // make the Label's own color property a required property!
                    // this works because it is possible to assign a string to a color property (QColor has a string constructor)
                    // we can see this in the text which shows the color's internal RRGGBB value rather than the string name we constructed it from.

                    required property int index // the indices (rows) 0 through 9

                    Layout.fillWidth: true

                    text: `backgroundColor: ${backgroundColor}, color: ${color}, index: ${index}`

                    background: Rectangle {
                        color: Qt.color(labelDelegate.backgroundColor) // must be qualified
                    }
                }
            }
        }
    }
}

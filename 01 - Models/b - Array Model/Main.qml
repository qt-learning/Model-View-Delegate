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
                // a JSON array as a model
                model: ["red", "green", "blue", "cyan", "yellow", "magenta", "white", "black"]

                delegate: Label {
                    id: labelDelegate // id necessary to qualify modelData within the Rectangle

                    required property string modelData // the *string* values "red" through "black"
                    required property int index // the indices (rows) 0 through 9

                    Layout.fillWidth: true

                    text: `modelData: ${modelData}, index: ${index}`

                    background: Rectangle {
                        color: Qt.color(labelDelegate.modelData) // must be qualified
                    }
                }
            }
        }
    }
}

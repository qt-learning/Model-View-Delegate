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

    // This QML File has all the pragmas and imports we will use for the whole course set up already
    // and a nice ApplicationWindow with a white-on-black palette ready for us to start using.
    // It also has a Pane and ColumnLayout ready for us to start filling in the contents

    Pane {
        anchors.fill: parent
        padding: 8

        background: null

        ColumnLayout {
            anchors.fill: parent

            // All our course content will be inside this ColumnLayout
        }
    }
}

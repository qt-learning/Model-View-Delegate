import QtQuick
import QtQuick.Controls.Basic

Label {
    id: attribution

    anchors {
        right: parent.right
        bottom: parent.bottom
    }

    text: "<a href=\"https://open-meteo.com/\">Weather data by Open-Meteo.com</a>"
    onLinkActivated: (link)=> Qt.openUrlExternally(link)
}

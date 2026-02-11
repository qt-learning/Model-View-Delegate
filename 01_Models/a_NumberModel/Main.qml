// Copyright (C) 2026 Qt Group.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

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
                model: 10 // Simple number model equivalent to JSON Array: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

                delegate: Label {

                    // adding required properties modelData and index to avoid context property injection
                    // into the delegate scope and avoid any warnings or errors.

                    required property int modelData // the *int* values 0 through 9
                    required property int index // the indices (rows) 0 through 9
                    // required property int unknownRole

                    Layout.fillWidth: true

                    text: `modelData: ${modelData}, index: ${index}`
                }
            }
        }
    }
}

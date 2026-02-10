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

            FolderListModel {
                id: folderListModel
                folder: Qt.resolvedUrl("assets/icons/")
            }

            GridView {
                id: gridView

                Layout.fillWidth: true
                Layout.fillHeight: true

                model: folderListModel

                cellWidth: 100
                cellHeight: 100

                delegate: Rectangle {
                    id: delegate

                    required property url fileUrl
                    required property string fileBaseName

                    color: "transparent"
                    border.color: "white"

                    // delegate follows the GridView cell size
                    // Note: this binding is why this QML file needs pragma ComponentBehavior: Bound
                    width: gridView.cellWidth
                    height: gridView.cellHeight

                    Rectangle {
                        anchors.fill: columnLayout // fill the columnLayout's implicit size

                        color: "transparent"
                        border.color: "red"
                    }

                    ColumnLayout {
                        id: columnLayout

                        // optionally you can center in the cell else it will be top-left.
                        anchors.centerIn: parent

                        Image {
                            source: delegate.fileUrl // from the FolderListModel
                            Layout.fillWidth: true
                            horizontalAlignment: Qt.AlignHCenter
                            fillMode: Image.PreserveAspectFit
                        }
                        Label {
                            text: delegate.fileBaseName // from the FolderListModel
                            horizontalAlignment: Qt.AlignHCenter
                            Layout.fillWidth: true
                        }
                    }
                }
            }
        }
    }
}

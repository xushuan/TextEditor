import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import Qt.labs.platform 1.0

import "Component"

ApplicationWindow {
    visible: true
    width: 1024
    height: 600
    title: qsTr("TextEditor")
    color: "white"

    Component.onCompleted: {
        x = Screen.width / 2 - width / 2
        y = Screen.height / 2 - height / 2
    }

    MenuBar {
        Menu {
            title: qsTr("&File")

            MenuItem {
                text: qsTr("&Open")
            }
            MenuItem {
                text: qsTr("&Save As...")
            }
            MenuItem {
                text: qsTr("&Quit")
            }
        }

        Menu {
            title: qsTr("&Edit")

            MenuItem {
                text: qsTr("&Copy")
            }
            MenuItem {
                text: qsTr("Cu&t")
            }
            MenuItem {
                text: qsTr("&Paste")
            }
        }

        Menu {
            title: qsTr("F&ormat")

            MenuItem {
                text: qsTr("&Bold")
            }
            MenuItem {
                text: qsTr("&Italic")
            }
            MenuItem {
                text: qsTr("&Underline")
            }
        }
    }

    header: ToolBarCtm {
        height: 50

        leftPadding: 8

        Flow {
            id: flow
            width: parent.width

            Row {
                id: fileRow
                ToolButton {
                    id: openButton
                    text: "\ue90b" // icon-folder-open-empty
                    font.family: "icomoon"
                }
            }
        }
    }

}

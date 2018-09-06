import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import Qt.labs.platform 1.0

import io.qt.examples.texteditor 1.0

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
                onTriggered: openDialog.open()
            }
            MenuItem {
                text: qsTr("&Save As...")
            }
            MenuSeparator {}
            MenuItem {
                text: qsTr("&Quit")
            }
        }

        Menu {
            title: qsTr("&Edit")

            MenuItem {
                text: qsTr("&Copy")
                shortcut: "Ctrl+C"
            }
            MenuItem {
                text: qsTr("Cu&t")
                shortcut: "Ctrl+T"
            }
            MenuItem {
                text: qsTr("&Paste")
                shortcut: "Ctrl+V"
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
        topPadding: 8

        Flow {
            id: flow
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter

            Row {
                id: fileRow
                ToolButtonCtm {
                    id: openButton
                    text: "\ue90b" // icon-folder-open-empty
                    tipText: qsTr("Open")
                    onClicked: openDialog.open()
                }
                ToolSeparator {}
            }
        }
    }

    FileDialog {
        id: openDialog
        fileMode: FileDialog.OpenFile
        selectedNameFilter.index: 1
//        nameFilters: ["Text files (*.txt)", "HTML files (*.html *.htm)"]
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        onAccepted: document.load(file)
    }

    FileDialog {
        id: saveDialog
        fileMode: FileDialog.SaveFile
        defaultSuffix: document.fileType
        nameFilters: openDialog.nameFilters
//        selectedNameFilter.index: document.fileType === "txt" ? 0 : 1
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        onAccepted: document.saveAs(file)
    }

    Flickable {
        id: flickable
        flickableDirection: Flickable.VerticalFlick
        anchors.fill: parent

        TextArea.flickable: TextArea {
            id: textArea
            textFormat: Qt.RichText
            wrapMode: TextArea.Wrap
            focus: true
            selectByMouse: true
            persistentSelection: true
            // Different styles have different padding and background
            // decorations, but since this editor is almost taking up the
            // entire window, we don't need them.
            leftPadding: 6
            rightPadding: 6
            topPadding: 0
            bottomPadding: 0
            background: null

            MouseArea {
                acceptedButtons: Qt.RightButton
                anchors.fill: parent
                onClicked: contextMenu.open()
            }

            onLinkActivated: Qt.openUrlExternally(link)
        }

        ScrollBar.vertical: ScrollBar {}
    }

    DocumentHandler {
        id: document
        document: textArea.textDocument
        cursorPosition: textArea.cursorPosition
        selectionStart: textArea.selectionStart
        selectionEnd: textArea.selectionEnd
        textColor: colorDialog.color
//        Component.onCompleted: document.load("qrc:/texteditor.html")
        onLoaded: {
            textArea.text = text
        }
        onError: {
            errorDialog.text = message
            errorDialog.visible = true
        }
    }

    ColorDialog {
        id: colorDialog
        currentColor: "black"
    }

    MessageDialog {
        id: errorDialog
    }

    Menu {
        id: contextMenu

        MenuItem {
            text: qsTr("Copy")
            enabled: textArea.selectedText
            onTriggered: textArea.copy()
        }
        MenuItem {
            text: qsTr("Cut")
            enabled: textArea.selectedText
            onTriggered: textArea.cut()
        }
        MenuItem {
            text: qsTr("Paste")
            enabled: textArea.canPaste
            onTriggered: textArea.paste()
        }

        MenuSeparator {}

        MenuItem {
            text: qsTr("Font...")
            onTriggered: fontDialog.open()
        }

        MenuItem {
            text: qsTr("Color...")
            onTriggered: colorDialog.open()
        }
    }

    footer: ToolBarCtm {
        height: 30
    }
}

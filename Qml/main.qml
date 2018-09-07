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
                text: qsTr("&Cut")
                shortcut: "Ctrl+X"
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

        Menu {
            title: qsTr("&Set")

            Menu {
                title: qsTr("&Axis")
                MenuItem {
                    text: qsTr("&Axis-X")
                    onTriggered: cursorAxisX.active = !cursorAxisX.active
                }
                MenuItem {
                    text: qsTr("&Axis-Y")
                    onTriggered: cursorAxisY.active = !cursorAxisY.active
                }
            }

            Menu {
                title: qsTr("&Language")
                MenuItem {
                    text: qsTr("&Language-EN")
                }
                MenuItem {
                    text: qsTr("&Language-CN")
                }
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
                ToolSeparator {
                    contentItem.visible: fileRow.y === editRow.y
                }
            }
            Row {
                id: editRow
                ToolButtonCtm {
                    id: saveButton
                    text: "\ue90c" // icon-docs
                    tipText: qsTr("Save")
                }
                ToolButtonCtm {
                    id: saveAsButton
                    text: "\ue90d" // icon-scissors
                    tipText: qsTr("Save as")
                }
                ToolButtonCtm {
                    id: copyButton
                    text: "\ue903" // icon-paste
                    tipText: qsTr("Copy")

                    enabled: textArea.selectedText
                    onClicked: textArea.copy()
                }
                ToolButtonCtm {
                    id: cutButton
                    text: "\ue904" // icon-paste
                    tipText: qsTr("Cut")

                    enabled: textArea.selectedText
                    onClicked: textArea.cut()
                }
                ToolSeparator {
                    contentItem.visible: editRow.y === formatRow.y
                }
            }

            Row {
                id: formatRow
                ToolButtonCtm {
                    id: boldButton
                    text: "\ue900" // icon-bold
                    tipText: qsTr("Bold")

                    checked: document.bold
                    onClicked: document.bold = !document.bold
                }
                ToolButtonCtm {
                    id: italicButton
                    text: "\ue906" // icon-italic
                    tipText: qsTr("Italic")

                    checked: document.italic
                    onClicked: document.italic = !document.italic
                }
                ToolButtonCtm {
                    id: underlineButton
                    text: "\ue910" // icon-underline
                    tipText: qsTr("Underline")

                    checkable: true
                    checked: document.underline
                    onClicked: document.underline = !document.underline
                }
                ToolButtonCtm {
                    id: textColorButton
                    text: "\ue902" // icon-brush
                    tipText: qsTr("Brush")

                    onClicked: colorDialog.open()

                    Rectangle {
                        width: aFontMetrics.width + 3
                        height: 2
                        color: document.textColor
                        parent: textColorButton.contentItem
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.baseline: parent.baseline
                        anchors.baselineOffset: -1

                        TextMetrics {
                            id: aFontMetrics
                            font: textColorButton.font
                            text: textColorButton.text
                        }
                    }
                }
                ToolButtonCtm {
                    id: fontFamilyToolButton
                    text: qsTr("\ue905") // icon-font
                    tipText: qsTr("Font")

                    font.bold: document.bold
                    font.italic: document.italic
                    font.underline: document.underline
                    onClicked: {
                        fontDialog.currentFont.family = document.fontFamily;
                        fontDialog.currentFont.pointSize = document.fontSize;
                        fontDialog.open();
                    }
                    FontDialog {
                        id: fontDialog
                        onAccepted: {
                            document.fontFamily = font.family;
                            document.fontSize = font.pointSize;
                        }
                    }

                }
                ToolSeparator {
                    contentItem.visible: formatRow.y === alignRow.y
                }
            }
            Row {
                id: alignRow
                ToolButtonCtm {
                    id: alignLeftButton
                    text: "\ue909" // icon-align-left
                    tipText: qsTr("Left")

                    checkable: true
                    checked: document.alignment == Qt.AlignLeft
                    onClicked: document.alignment = Qt.AlignLeft
                }
                ToolButtonCtm {
                    id: alignCenterButton
                    text: "\ue908" // icon-align-center
                    tipText: qsTr("Center")

                    checkable: true
                    checked: document.alignment == Qt.AlignHCenter
                    onClicked: document.alignment = Qt.AlignHCenter
                }
                ToolButtonCtm {
                    id: alignRightButton
                    text: "\ue90a" // icon-align-right
                    tipText: qsTr("Right")

                    checkable: true
                    checked: document.alignment == Qt.AlignRight
                    onClicked: document.alignment = Qt.AlignRight
                }
                ToolButtonCtm {
                    id: alignJustifyButton
                    text: "\ue907" // icon-align-justify
                    tipText: qsTr("Justify")

                    checkable: true
                    checked: document.alignment == Qt.AlignJustify
                    onClicked: document.alignment = Qt.AlignJustify
                }
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
            textFormat: TextEdit.AutoText // 保证文本按原格式输出(TextEdit.RichText 会出问题)
            wrapMode: TextArea.Wrap
            focus: true
            selectByMouse: true
            selectByKeyboard: true
            persistentSelection: true
            // Different styles have different padding and background
            // decorations, but since this editor is almost taking up the
            // entire window, we don't need them.
            leftPadding: 6
            rightPadding: 6
            topPadding: 0
            bottomPadding: 0
            background: null

//            onCursorPositionChanged: {
//                console.log("cursorPosition", cursorPosition)
//            }

//            onCursorDelegateChanged: {
//                console.log("cursorDelegate", cursorDelegate)
//            }

//            onCursorRectangleChanged: {
//                console.log("cursorRectangle", cursorRectangle)
//            }


            MouseArea {
                acceptedButtons: Qt.RightButton
                anchors.fill: parent
                onClicked: contextMenu.open()
            }

            onLinkActivated: Qt.openUrlExternally(link)
        }

        Loader {
            id: cursorAxisX
            // Explicitly set the size of the
            // Loader to the parent item's size
            anchors.fill: textArea
            active: false
            sourceComponent: cursorAxis_X
        }
        Loader {
            id: cursorAxisY
            // Explicitly set the size of the
            // Loader to the parent item's size
            anchors.fill: textArea
            active: false
            sourceComponent: cursorAxis_Y
        }

        ScrollBar.vertical: ScrollBar {}
    }

    Component {
        id: cursorAxis_X
        Item {
            Rectangle {
                x: 0
                y: textArea.cursorRectangle.y + textArea.cursorRectangle.height
                width: parent.width
                height: 1
                color: "#565d6b"
            }
        }
    }

    Component {
        id: cursorAxis_Y

        Item {
            Rectangle {
                x: textArea.cursorRectangle.x + (textArea.cursorRectangle.width)
                y: 0
                width: 1
                height: parent.height
                color: "#565d6b"
            }
        }
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

        Text {
            id: name
            text: qsTr("lines") + textArea.lineCount
        }
    }
}

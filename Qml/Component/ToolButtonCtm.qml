import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

ToolButton {
    id: control

    property alias tipText: toolTip.text
    property alias textColor: buttonText.color

    font.family: FontManager.iconFont
    font.pixelSize: 20

    background: Rectangle {
        color: control.down ? "#4eb7bb" : "transparent"
        opacity: 0.3
        radius: width / 2
        visible: control.down
    }

    contentItem: Text {
        id: buttonText
        text: control.text
        font: control.font
        color: control.hovered ? "#4eb7bb" : "#565d6b"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    ToolTip {
        id: toolTip
        visible: control.hovered
        text: qsTr("Tool Button")
        font.pixelSize: 15
    }
}

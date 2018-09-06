import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

ToolBar {

    background: Rectangle {
        implicitHeight: parent.height
        color: "white"
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 1
            color: "#aa000000"
            samples: 20
        }
    }
}

import QtQuick 2.11
import QtQuick.Controls 2.3

import GeneratorClass 1.0

Rectangle {
    id: appPane
    width: parent.width
    height: parent.height
    color: "white"

    property var name

    GeneratorClass{
        id: qGC
    }

    Button {
        id: qButton
        text: name
        onClicked: qGC.generate(name)
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: appPane.horizontalCenter
        visible: true
    }
}

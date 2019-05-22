import QtQuick 2.11
import QtQuick.Controls 2.3

import AddProjectClass 1.0

Rectangle {
    id: appPane
    width: parent.width
    height: parent.height
    color: "white"

    property var name

    AddProjectClass{
        id: qAPC
    }

    Button {
        id: qButton
        text: name
        onClicked: qAPC.generateProject(name, "path")
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: appPane.horizontalCenter
        visible: true
    }
}

import QtQuick 2.11
import QtQuick.Controls 2.3

Rectangle {
    id: qInitPage

    Image {
        id: qImage
        source: "qrc:/images/add-file.svg"
        anchors.centerIn: qInitPage
        sourceSize.width: 100
        sourceSize.height: 100
        visible: true
    }

    Button {
        id: qButton
        text: "Open New Template"
        onClicked: window.mDialog.open()
        anchors.top: qImage.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: qInitPage.horizontalCenter
        visible: true
    }
}

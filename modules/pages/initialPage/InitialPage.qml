import QtQuick 2.11
import QtQuick.Controls 2.3

Rectangle {
    id: qInitPage

    Image {
        id: qImage
        source: "qrc:/images/sad.svg"
        anchors.centerIn: qInitPage
        sourceSize.width: 80
        sourceSize.height: 80
        visible: true
    }

    Button {
        id: qButton
        text: "Open A Template :)"
        onClicked: window.mDialog.open()
        anchors.top: qImage.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: qInitPage.horizontalCenter
        visible: true
    }
}

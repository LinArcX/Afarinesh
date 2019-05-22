import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.0

Rectangle {
    id: qInitPage

    FileDialog {
        id: qFileDialog
        title: "Choose Template Directory"
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            path = qFileDialog.folder
            qLC.hasConfig(qFileDialog.folder)
        }
    }

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
        onClicked: qFileDialog.open()
        anchors.top: qImage.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: qInitPage.horizontalCenter
        visible: true
    }
}

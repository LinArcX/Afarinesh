import QtQuick 2.11
import QtQuick.Controls 2.3

import AddProjectClass 1.0
import "qrc:/components/qml/"
import "qrc:/fonts/fontAwesome/"
import "qrc:/fonts/hack/"
import "qrc:/js/Constants.js" as CONS

Rectangle {
    id: appPane
    width: parent.width
    height: parent.height
    color: "white"
    property var targetPath

    AddProjectClass {
        id: qGC
    }

    LinarcxHLine {
        id: chooseProjectName
        header: "1. Name of the project"
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    LinarcxTextField {
        id: txtProjectName
        placeholderText: "Enter Project Name..."
        anchors.top: chooseProjectName.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    LinarcxHLine {
        id: chooseProjectPath
        header: "2. Choose path"
        anchors.top: txtProjectName.bottom
        anchors.topMargin: 20
    }

    Button {
        id: btnChooseTargetPath
        text: 'Choose target path'
        onClicked: qTargetPathDialog.open()
        anchors.top: chooseProjectPath.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: txtProjectName.width
    }

    Label {
        id: lblTargetPath
        visible: false
        anchors.verticalCenter: btnChooseTargetPath.verticalCenter
        anchors.left: btnChooseTargetPath.right
        anchors.leftMargin: 5
    }

    LinarcxButton {
        id: btnGenerate
        btnTxt: "Generate"
//        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        width: parent.width / 6 * 5
        height: 40
        anchors.left: parent.left
        enabled: lblTargetPath.text != ""
                 && txtProjectName.text != "" ? true : false
        onClicked: {
            console.log("Sd")
        }
        qColor: CONS.orange400
        iconFamily: Hack.family
        iconName: Hack.nf_fa_rocket
        iconSize: 30
    }

    LinarcxButton {
        id: btnGoToHome
        btnTxt: "Home"
        onClicked: qStackView.pop()
        anchors.bottom: parent.bottom
        width: parent.width / 6 * 1
        height: 40
        anchors.left: btnGenerate.right
        anchors.right: parent.right
        qColor: CONS.blue
        iconFamily: Hack.family
        iconName: Hack.nf_oct_home
        iconSize: 30
    }

    LinarcxDialog {
        id: qTargetPathDialog
        parent: window.overlay
        showDotAndDotDot: true
        nameFilters: ["*.*"]

        onPickSelected: {
            targetPath = currentFolder()
            lblTargetPath.text = targetPath
            lblTargetPath.visible = true
            console.log("You choose: " + targetPath)
            qTargetPathDialog.close()
        }

        // mFolder: shortcuts.pictures
        // QStandardPaths::writableLocation(QStandardPaths::PicturesLocation)
        //        onFileSelected: {
        //            targetPath = currentFolder()
        //            lblTargetPath.text = targetPath
        //            lblTargetPath.visible = true
        //            console.log("You choose: " + targetPath)
        //            qTargetPathDialog.close()
        //        }
    }
}

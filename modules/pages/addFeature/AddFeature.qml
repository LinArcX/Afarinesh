import QtQuick 2.11
import QtQuick.Controls 2.3

import "qrc:/components/qml/"
import "qrc:/fonts/fontAwesome/"
import "qrc:/fonts/hack/"
import "qrc:/js/Constants.js" as CONS

Rectangle {
    id: appPane
    color: "white"
//    width: parent.width
//    height: parent.height

    property var name

    Component.onCompleted: console.log(name)

    LinarcxButton {
        id: btnGenerate
        btnTxt: "Generate"
        width: parent.width / 8 * 6
        height: 40
        anchors.left: parent.left
        qColor: CONS.green500
        anchors.bottom: parent.bottom
        iconFamily: Hack.family
        iconName: Hack.nf_fa_rocket
        iconSize: 30

//        enabled: {
//            if (lblTargetPath.mText != "" && txtProjectName.text != ""
//                    && tableItems == filledTableItems)
//                btnGenerate.enabled = true
//            else
//                btnGenerate.enabled = false
//        }
//        onClicked: {
//            qAPC.generateProject(templateName, txtProjectName.text,
//                                 lblTargetPath.mText, myItems)
//        }
    }

    LinarcxButton {
        id: btnGoBack
        btnTxt: "Back"
        height: 40
        width: parent.width / 8 * 1
        anchors.bottom: parent.bottom
        anchors.left: btnGenerate.right
        qColor: CONS.deppOrang500
        iconFamily: Hack.family
        iconName: Hack.nf_mdi_arrow_left_box
        iconSize: 30
        onClicked: qStackView.pop()
    }

    LinarcxButton {
        id: btnGoToHome
        btnTxt: "Home"
        height: 40
        width: parent.width / 8 * 1

        anchors.bottom: parent.bottom
        anchors.left: btnGoBack.right
        qColor: CONS.indigo500
        iconFamily: Hack.family
        iconName: Hack.nf_oct_home
        iconSize: 30

        onClicked: {
            while (qStackView.depth > 1) {
                qStackView.pop()
            }
        }
    }
}

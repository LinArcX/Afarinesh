import QtQuick 2.11
import QtQuick.Controls 2.3

import "qrc:/components/qml/"
import "qrc:/fonts/fontAwesome/"
import "qrc:/fonts/hack/"
import "qrc:/js/Constants.js" as CONS

Rectangle {
    id: appPane
    color: "white"

    property var name

    Component.onCompleted: console.log(name)

    LinarcxButton {
        id: btnGenerate
        height: 40
        width: parent.width / 8 * 6
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        btnText: qsTr('Generate')
        btnIcon: Hack.nf_fa_rocket
        btnIconSize: 30
        btnIconColor: CONS.green500
        btnIconFamily: Hack.family
    }

    LinarcxButton {
        id: btnGoBack
        height: 40
        width: parent.width / 8 * 1
        anchors.bottom: parent.bottom
        anchors.left: btnGenerate.right

        btnText: qsTr('Back')
        btnIcon: Hack.nf_mdi_arrow_left_box
        btnIconSize: 30
        btnIconColor: CONS.deppOrang500
        btnIconFamily: Hack.family

        onClicked: qStackView.pop()
    }

    LinarcxButton {
        id: btnGoToHome
        height: 40
        width: parent.width / 8 * 1
        anchors.bottom: parent.bottom
        anchors.left: btnGoBack.right

        btnText: qsTr('Home')
        btnIcon: Hack.nf_oct_home
        btnIconSize: 30
        btnIconColor: CONS.indigo500
        btnIconFamily: Hack.family

        onClicked: {
            while (qStackView.depth > 1) {
                qStackView.pop()
            }
        }
    }
}

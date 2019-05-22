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
    property string addProject: "qrc:/pages/AddProject.qml"
    property var name

    LinarcxButton {
        id: btnNewProject
        btnTxt: "Create New " + name + " Project"
        onClicked: qStackView.push(addProject, {
                                       "name": name
                                   })
        anchors.bottom: parent.bottom
        width: parent.width / 6 * 5
        height: 40
        anchors.left: parent.left
        qColor: CONS.green
        iconFamily: Hack.family
        iconName: Hack.nf_dev_sizzlejs
        iconSize: 30
    }

    LinarcxButton {
        id: btnGoToHome
        btnTxt: "Home"
        onClicked: qStackView.pop()
        anchors.bottom: parent.bottom
        width: parent.width / 6 * 1
        height: 40
        anchors.left: btnNewProject.right
        anchors.right: parent.right
        qColor: CONS.blue
        iconFamily: Hack.family
        iconName: Hack.nf_oct_home
        iconSize: 30
    }
}

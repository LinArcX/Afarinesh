import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.0

import "qrc:/components/qml/"

import "qrc:/js/Constants.js" as CONS

import "qrc:/fonts/hack/"
import "qrc:/fonts/fontAwesome/"
import LauncherClass 1.0

Page {
    id: qInitPage

    property string path
    property var templatesArray
    property alias mDialog: qFileDialog
    property string chooseNewTemplatePage: "qrc:/pages/ChooseNewTemplate.qml"

    LinarcxNotif {
        id: qNotif
        qIcon: "qrc:/images/confetti.svg"
        qText: qsTr("There is no trinity.conf!")
        qColor: CONS.blue
        qPosition: 1
    }

    LinarcxNotif {
        id: qNotif1
        qIcon: "qrc:/images/confetti.svg"
        qText: qsTr("There is no template for generate")
        qColor: CONS.blue
        qPosition: 1
    }

    LauncherClass {
        id: qLC
    }

    FileDialog {
        id: qFileDialog
        title: qsTr("Choose Template Directory")
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            path = qFileDialog.folder
            qLC.hasConfig(qFileDialog.folder)
        }
    }

    Image {
        id: qImage
        source: "qrc:/images/add-file.svg"
        anchors.centerIn: parent
        sourceSize.width: 100
        sourceSize.height: 100
        visible: true
    }

    Button {
        id: qButton
        text: qsTr("Open New Template")
        onClicked: mDialog.open()
        anchors.top: qImage.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        visible: true
    }

    Component.onCompleted: {
        qLC.getAllKeys()
    }

    Connections {
        target: qLC
        onAllKeysReady: {
            if (keys.length === 0) {

            } else {
                for (var i in keys) {
                    path = keys[i]
                    qLC.hasConfig(keys[i])
                }
            }
        }

        onConfigFound: {
            if (hasConfig) {
                qLC.listTemplates(path)
            } else {
                qNotif.notificaitonTurnOn()
            }
        }

        onTemplatesReady: {
            if (templates.length === 0) {
                qNotif.notificaitonTurnOn()
            } else {
                templatesArray = templates
                qLC.templateInfo(path)
            }
        }

        onTemplateInfoReady: {
            if (templateInfo.length === 0) {
                qNotif.notificaitonTurnOn("qrc:/images/confetti.svg",
                                          qsTr("config file isn't valid!"),
                                          CONS.blue, 1)
            } else {
                qModel.append({
                                  "name": templateInfo[0],
                                  "author": templateInfo[1],
                                  "icon": path + "/" + templateInfo[2],
                                  "comment": templateInfo[3],
                                  "path": templateInfo[4]
                              })
                qLC.savePath(templateInfo[0], path)
            }
        }
    }
}

import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.0

import LauncherClass 1.0
import "qrc:/components/qml/"
import "qrc:/pages/"
import "qrc:/fonts/hack/"
import "qrc:/js/Constants.js" as CONS

Window {
    id: window
    visible: true

    property string path
    property string listProjects: "qrc:/pages/ListProjects.qml"
    property string initialPage: "qrc:/pages/InitialPage.qml"
    property var templatesArray
    property alias mDialog: qFileDialog

    LayoutMirroring.enabled: isRTL
    LayoutMirroring.childrenInherit: true

    LauncherClass {
        id: qLC
    }

    LinarcxNotif {
        id: qNotif
    }

    LinarcxToolTip {
        id: qToolTip
        mother: window
        z: 900
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

    StackView {
        id: qStackView
        width: parent.width - 50
        height: parent.height
        anchors.right: parent.right
    }

    Rectangle {
        id: qMenu
        width: 50
        height: parent.height
        anchors.left: parent.left
        color: "#424242" //"#767676"

        ListModel {
            id: qModel
        }

        ScrollView {
            id: mParent
            clip: true
            width: parent.width
            height: window.height - (qSettings.height + qAdd.height)
            anchors.top: parent.top
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            ScrollBar.horizontal.policy: ScrollBar.AsNeeded

            ListView {
                id: qListView
                clip: true
                spacing: 60
                model: qModel
                width: parent.width
                height: parent.height
                flickableDirection: Flickable.VerticalFlick
                boundsBehavior: Flickable.StopAtBounds
                ScrollBar.vertical: ScrollBar {
                }

                delegate: Rectangle {
                    id: qRectContent
                    width: parent.width
                    color: "transparent"

                    LinarcxImageToolTiper {
                        id: qCreateIso
                        qImg: icon
                        sourceSize.height: 40
                        sourceSize.width: 40
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        anchors.rightMargin: 5
                        anchors.topMargin: 5
                        mParent: window
                        onImageClicked: {
                            qStackView.push(listProjects, {
                                                "templateName": name,
                                                "templateIcon": icon,
                                                "templateAuthor": author,
                                                "templateComment": comment
                                            }, StackView.Immediate)
                            qListView.currentIndex = index
                        }
                        onImageEntered: function () {
                            qToolTip.showMe(qCreateIso.x, qCreateIso.y, 2, name)
                            console.log(y)
                        }
                    }
                }
            }
        }

        Button {
            text: "R"
            width: 40
            anchors.bottom: qAdd.top
            anchors.bottomMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
            onClicked: RuntimeQML.reload()
        }

        LinarcxImageToolTiper {
            id: qAdd
            qImg: "qrc:/images/add-file.svg"
            sourceSize.height: 40
            sourceSize.width: 40
            anchors.bottom: qSettings.top
            anchors.bottomMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
            onImageClicked: qFileDialog.open()
            onImageEntered: qToolTip.showMe(x, y, 2, qsTr("Add new template"))
        }

        LinarcxImageToolTiper {
            id: qSettings
            qImg: "qrc:/images/settings.svg"
            sourceSize.height: 40
            sourceSize.width: 40
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            onImageClicked: qStackView.push("qrc:/pages/Settings.qml")
            onImageEntered: qToolTip.showMe(x, y, 2, qsTr("Settings"))
        }
    }
    Connections {
        target: qLC
        onAllKeysReady: {
            if (keys.length === 0) {
                qStackView.push(initialPage)
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
                qNotif.notificaitonTurnOn("qrc:/images/confetti.svg",
                                          qsTr("There is no trinity.conf!"),
                                          CONS.blue, 1)
            }
        }

        onTemplatesReady: {
            if (templates.length === 0) {
                qNotif.notificaitonTurnOn(
                            "qrc:/images/confetti.svg",
                            qsTr("There is no template for generate."),
                            CONS.blue, 1)
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
                qStackView.push(initialPage)
            }
        }
    }

    Component.onCompleted: {
        window.minimumWidth = Screen.width / 3 * 2
        window.minimumHeight = Screen.height / 3 * 2
        window.maximumWidth = Screen.width
        window.maximumHeight = Screen.height
        window.x = Screen.width / 2 - window.minimumWidth / 2
        window.y = Screen.height / 2 - window.minimumHeight / 2
        qLC.getAllKeys()
    }
}

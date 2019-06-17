import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.0

import LauncherClass 1.0
import "qrc:/components/qml/"
import "qrc:/fonts/hack/"
import "qrc:/js/Constants.js" as CONS

Window {
    id: window
    title: qsTr("Trinity")
    visible: true
    property string path
    property string listProjects: "qrc:/pages/ListProjects.qml"
    property string initialPage: "qrc:/pages/InitialPage.qml"
    property var templatesArray
    property alias mDialog: qFileDialog

    LauncherClass {
        id: qLC
    }

    LinarcxToast {
        id: messages
    }

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

    StackView {
        id: qStackView
        width: parent.width - 50
        height: parent.height
        anchors.left: qMenu.right
    }

    //------------------- List of templates ----------------------//
    Rectangle {
        id: qMenu
        width: 50
        height: parent.height
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
                        qTitle: name
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
                                                "templateComment": comment,
                                            })
                            qListView.currentIndex = index
                        }
                    }
                }
            }
        }

        LinarcxImageToolTiper {
            id: qAdd
            qImg: "qrc:/images/add-file.svg"
            qTitle: "Add new template"
            sourceSize.height: 40
            sourceSize.width: 40
            anchors.bottom: qSettings.top
            anchors.bottomMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
            onImageClicked: qFileDialog.open()
        }

        LinarcxImageToolTiper {
            id: qSettings
            qImg: "qrc:/images/settings.svg"
            qTitle: "Settings"
            sourceSize.height: 40
            sourceSize.width: 40
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            onImageClicked: qStackView.push("qrc:/pages/Settings.qml")
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
                messages.displayMessage("There is no trinity.conf!")
            }
        }

        onTemplatesReady: {
            if (templates.length === 0) {
                messages.displayMessage("There is no template for generate.")
            } else {
                templatesArray = templates
                qLC.templateInfo(path)
            }
        }

        onTemplateInfoReady: {
            if (templateInfo.length === 0) {
                messages.displayMessage("config file isn't valid!")
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
                //                qRemove.opacity = 1
                //                qRemove.enabled = true
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


//    Button{//        anchors.left: qMenu.right//        text: "lift"//        anchors.verticalCenter: qMenu.verticalCenter
//        onClicked: {
//            qMenu.width = 50
//        }
//    }

//            MouseArea {
//                id: qEmptyArea
//                width: parent.width
//                height: qProjects.height
//                anchors.bottom: parent.bottom
//                onClicked: {
//                    qRemove.opacity = 0.3
//                    qRemove.enabled = false
//                    qStackView.pop()
//                }
//            }

//                    onHeightChanged: {
//                        height = qIcon.height + qAuthorLabel.height + 5
//                        //qEmptyArea.height = qProjects.height - qRectContent.height - height
//                        qProjectsArea.height += height
//                    }

//                    Component.onCompleted: {
//                        height = qIcon.height + qAuthorLabel.height + 5
//                        qListView.height += height
//                    }

//                    MouseArea {
//                        id: qProjectsArea
//                        anchors.fill: parent
//                        onClicked: {
//                            qStackView.push(listProjects, {
//                                                "templateName": name,
//                                                "templateIcon": icon
//                                            })
//                            qListView.currentIndex = index
//                            qRemove.opacity = 1
//                            qRemove.enabled = true
//                        }
//                    }

//                    Text {
//                        id: qNameLabel
//                        text: qsTr("Name: ")
//                        color: "#BA68C8"
//                        anchors.left: parent.left
//                        anchors.top: parent.top
//                        anchors.topMargin: 5
//                        font.bold: true
//                    }

//                    Text {
//                        id: qName
//                        text: name
//                        color: "white"
//                        anchors.left: qNameLabel.right
//                        anchors.leftMargin: 5
//                        anchors.top: qNameLabel.top
//                    }

//                    Text {
//                        id: qAuthorLabel
//                        text: qsTr("Author: ")
//                        color: "#BA68C8"
//                        anchors.left: parent.left
//                        anchors.top: qNameLabel.bottom
//                        anchors.topMargin: 5
//                        font.bold: true
//                    }

//                    Text {
//                        id: qAuthor
//                        text: author
//                        color: "white"
//                        anchors.left: qAuthorLabel.right
//                        anchors.leftMargin: 5
//                        anchors.top: qAuthorLabel.top
//                    }

//                    Image {
//                        id: qIcon
//                        source: icon
//                        anchors.right: parent.right
//                        anchors.rightMargin: 10
//                        anchors.bottom: qAuthor.bottom
//                        sourceSize.width: qName.height + qAuthor.height
//                        sourceSize.height: qName.height + qAuthor.height
//                    }

//                    Rectangle {
//                        width: qProjects.width
//                        height: 1
//                        color: "#212121"
//                        anchors.left: parent.left
//                        anchors.top: qIcon.bottom
//                        anchors.topMargin: 1
//                    }

//------------------- Add/Remove Templates ----------------------//
//        Rectangle {
//            id: qButtonsArea
//            width: qProjects.width
//            height: 40
//            anchors.top: qProjects.bottom
//            color: "#212121"
//            z: 1

//            Image {
//                id: qAdd
//                source: "qrc:/images/add-folder.svg"
//                sourceSize.height: parent.height - 10
//                sourceSize.width: parent.height - 10
//                anchors.left: parent.left
//                anchors.leftMargin: 10
//                anchors.verticalCenter: parent.verticalCenter

//                //        Text {
//                //            id: qAdd
//                //            font.family: Hack.family
//                //            text: Hack.nf_custom_folder_open
//                //            anchors.left: parent.left
//                //            anchors.leftMargin: 10
//                //            anchors.verticalCenter: parent.verticalCenter
//                //            font.pixelSize: parent.height
//                //            color: CONS.green500
//                LinarcxToolTip {
//                    id: qAddTooTip
//                    mother: qAdd
//                    direction: 2
//                    title: "Add Template"
//                }

//                states: [
//                    State {
//                        name: "scale"
//                        PropertyChanges {
//                            target: qAdd
//                            scale: 0.9
//                        }
//                    },
//                    State {
//                        name: "normal"
//                        PropertyChanges {
//                            target: qAdd
//                            scale: 1
//                        }
//                    }
//                ]

//                transitions: Transition {
//                    ScaleAnimator {
//                        duration: 100
//                    }
//                }

//                MouseArea {
//                    anchors.fill: parent
//                    hoverEnabled: true
//                    onClicked: {
//                        qFileDialog.open()
//                    }
//                    onEntered: {
//                        qAdd.state = "scale"
//                        qAddTooTip.visible = true
//                    }
//                    onExited: {
//                        qAdd.state = "normal"
//                        qAddTooTip.visible = false
//                    }
//                }
//            }
//            Image {
//                id: qRemove
//                source: "qrc:/images/remove-folder.svg"
//                sourceSize.height: parent.height - 10
//                sourceSize.width: parent.height - 10
//                anchors.left: qAdd.right
//                anchors.leftMargin: 10
//                anchors.verticalCenter: parent.verticalCenter
//                enabled: false
//                opacity: 0.3

//                //        Text {
//                //            id: qRemove
//                //            font.family: Hack.family
//                //            text: Hack.nf_mdi_delete_empty
//                //            anchors.left: qAdd.right
//                //            anchors.leftMargin: 10
//                //            anchors.verticalCenter: parent.verticalCenter
//                //            font.pixelSize: parent.height
//                //            color: CONS.orange400
//                LinarcxToolTip {
//                    id: qRemoveTooTip
//                    mother: qRemove
//                    direction: 2
//                    title: "Remove Template"
//                }

//                states: [
//                    State {
//                        name: "scale"
//                        PropertyChanges {
//                            target: qRemove
//                            scale: 0.9
//                        }
//                    },
//                    State {
//                        name: "normal"
//                        PropertyChanges {
//                            target: qRemove
//                            scale: 1
//                        }
//                    }
//                ]

//                transitions: Transition {
//                    ScaleAnimator {
//                        duration: 100
//                    }
//                }

//                MouseArea {
//                    anchors.fill: parent
//                    hoverEnabled: true
//                    onClicked: {
//                        mPopUp.open()
//                    }
//                    onEntered: {
//                        qRemove.state = "scale"
//                        qRemoveTooTip.visible = true
//                    }
//                    onExited: {
//                        qRemove.state = "normal"
//                        qRemoveTooTip.visible = false
//                    }
//                }
//            }
//        }


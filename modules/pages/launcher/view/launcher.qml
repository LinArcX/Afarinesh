import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.3
import Launcher 1.0
import "qrc:/util/qml/"

Window {
    id: window
    title: qsTr("Afarinesh")
    visible: true
    property string path
    property string fPath
    property var templatesArray

    //    color: "#D7CCC8"//"#DCDCDC"
    Launcher {
        id: qLauncher
    }

    ////// Popup
    LinArcxDialog {
        id: mPopUp
        mImage: "qrc:/images/sad.svg"
        mTitle: "Are you Sure?"
        mBody: "If You delete this template, it will be deleted from settings too. are you sure?"
    }

    Rectangle {
        id: qProjects
        width: parent.width / 4
        height: parent.height - 40
        color: "#424242" //"#767676"
        z: 1

        MouseArea {
            id: qMouseAreaParent
            width: parent.width
            anchors.bottom: parent.bottom
            onClicked: {
                qPageLoader.source = ""
                qImage.visible = true
                qButton.visible = true
                qRemove.enabled = false
                qRemove.opacity = 0.3
            }
        }

        ListModel {
            id: qModel
        }

        ListView {
            id: qListView
            width: parent.width
            model: qModel
            clip: true
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            ScrollBar.vertical: ScrollBar {
            }

            delegate: Rectangle {
                id: qRectContent
                width: parent.width
                color: "transparent"

                onHeightChanged: {
                    qMouseAreaParent.height = qProjects.height - qRectContent.height
                }

                Component.onCompleted: {
                    height = qNameLabel.height + qAuthorLabel.height + qCommentLabel.height
                            + qComment.height + qPath.height + qPathLabel.height + 30
                    qListView.height += height
                }

                MouseArea {
                    id: qMouseInner
                    anchors.fill: parent
                    onClicked: {
                        qPageLoader.setSource("qrc:/pages/Generator.qml", {
                                                  "models": templatesArray
                                              })
                        qListView.currentIndex = index
                        qRemove.opacity = 1
                        qRemove.enabled = true
                    }
                }

                Text {
                    id: qNameLabel
                    text: qsTr("Name: ")
                    color: "#BA68C8"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    font.bold: true
                }

                Text {
                    id: qName
                    text: name
                    color: "white"
                    anchors.left: qNameLabel.right
                    anchors.leftMargin: 5
                    anchors.top: qNameLabel.top
                }

                Text {
                    id: qAuthorLabel
                    text: qsTr("Author: ")
                    color: "#BA68C8"
                    anchors.left: parent.left
                    anchors.top: qNameLabel.bottom
                    anchors.topMargin: 5
                    font.bold: true
                }

                Text {
                    id: qAuthor
                    text: author
                    color: "white"
                    anchors.left: qAuthorLabel.right
                    anchors.leftMargin: 5
                    anchors.top: qAuthorLabel.top
                }

                Image {
                    source: icon
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.bottom: qAuthor.bottom
                    sourceSize.width: 40
                    sourceSize.height: 40
                }

                Text {
                    id: qCommentLabel
                    text: qsTr("Comment: ")
                    color: "#BA68C8"
                    anchors.left: parent.left
                    anchors.top: qAuthorLabel.bottom
                    anchors.topMargin: 5
                    font.bold: true
                }

                Text {
                    id: qComment
                    color: "#E0E0E0"
                    text: "\"" + comment + "\""
                    width: qProjects.width
                    anchors.left: parent.left
                    font.pixelSize: 12
                    anchors.leftMargin: 5
                    anchors.top: qCommentLabel.bottom
                    wrapMode: TextArea.Wrap
                    font.italic: true
                }

                Text {
                    id: qPathLabel
                    text: qsTr("Path: ")
                    color: "#BA68C8"
                    anchors.left: parent.left
                    anchors.top: qComment.bottom
                    anchors.topMargin: 5
                    font.bold: true
                }

                Text {
                    id: qPath
                    text: "\"" + path + "\""
                    color: "#E0E0E0"
                    width: qProjects.width
                    font.pixelSize: 13
                    wrapMode: TextArea.Wrap
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: qPathLabel.bottom
                    font.italic: true
                }

                Rectangle {
                    width: qProjects.width
                    height: 1
                    color: "#212121"
                    anchors.left: parent.left
                    anchors.top: qPath.bottom
                }
            }
        }
    }

    Rectangle {
        width: qProjects.width
        height: 40
        anchors.top: qProjects.bottom
        color: "#212121"
        z: 1
        Image {
            id: qAdd
            source: "qrc:/images/add-folder.svg"
            sourceSize.height: parent.height - 10
            sourceSize.width: parent.height - 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    qFileDialog.open()
                }
            }
        }

        Image {
            id: qRemove
            source: "qrc:/images/remove-folder.svg"
            sourceSize.height: parent.height - 10
            sourceSize.width: parent.height - 10
            anchors.left: qAdd.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            enabled: false
            opacity: 0.3

            LinArcxToolTip {
                id: qRemoveTooTip
                mother: qRemove
                direction: 3
                title: "Remove Template"
            }

            states: [
                State {
                    name: "scale"
                    PropertyChanges {
                        target: qRemove
                        scale: 0.9
                    }
                },
                State {
                    name: "normal"
                    PropertyChanges {
                        target: qRemove
                        scale: 1
                    }
                }
            ]

            transitions: Transition {
                ScaleAnimator {
                    duration: 100
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    mPopUp.open()
                    //                    qModel.remove(qListView.currentIndex)
                    //                    qLauncher.removeItem(qListView.currentItem)
                    //                    qPageLoader.source = ""
                    //                    if (qModel.count == 0) {
                    //                        qImage.visible = true
                    //                        qButton.visible = true
                    //                        qRemove.visible = false
                    //                    }
                }
                onEntered: {
                    qRemove.state = "scale"
                    qRemoveTooTip.visible = true
                }
                onExited: {
                    qRemove.state = "normal"
                    qRemoveTooTip.visible = false
                }
            }
        }
    }

    LinArcxToast {
        id: messages
    }

    Image {
        id: qImage
        source: "qrc:/images/sad.svg"
        anchors.centerIn: qPageLoader
        sourceSize.width: 80
        sourceSize.height: 80
        visible: false
    }

    Button {
        id: qButton
        text: "Open A Template :)"
        onClicked: qFileDialog.open()
        anchors.top: qImage.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: qPageLoader.horizontalCenter
        visible: false
    }

    FileDialog {
        id: qFileDialog
        title: "Choose Template Directory"
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            path = qFileDialog.folder
            qLauncher.hasConfig(qFileDialog.folder)
        }
    }

    Loader {
        id: qPageLoader
        width: parent.width / 4 * 3
        height: parent.height
        anchors.left: qProjects.right

        onStatusChanged: {
            if (status) {
                console.log("Ready")
                animation.running = true
            } else {
                console.log("Not Ready!")
                animation.running = false
            }
        }

        NumberAnimation {
            id: animation
            target: qPageLoader.item
            property: "x"
            from: -(window.minimumWidth)
            to: 0
            duration: 1000
            easing.type: Easing.OutCirc
        }
    }

    Connections {
        target: qLauncher
        onAllKeysReady: {
            if (keys.length === 0) {
                qImage.visible = true
                qButton.visible = true
            } else {
                for (var i in keys) {
                    path = keys[i]
                    qLauncher.hasConfig(keys[i])
                }
            }
        }

        onConfigFound: {
            if (hasConfig) {
                qLauncher.listTemplates(path)
            } else {
                messages.displayMessage("There is no afarinesh.conf!")
            }
        }

        onTemplatesReady: {
            if (templates.length === 0) {
                messages.displayMessage("There is no template for generate.")
            } else {
                templatesArray = templates
                qLauncher.templateInfo(path)
            }
        }

        onTemplateInfoReady: {
            if (templateInfo.length === 0) {
                messages.displayMessage("config file isn't valid!")
            } else {
                qModel.append({
                                  "name": templateInfo[0],
                                  "author": templateInfo[1],
                                  "icon": path + templateInfo[2],
                                  "comment": templateInfo[3],
                                  "path": templateInfo[4]
                              })
                qLauncher.savePath(templateInfo[0], path)
                qPageLoader.setSource("qrc:/pages/Generator.qml", {
                                          "models": templatesArray
                                      })
                qRemove.opacity = 1
                qRemove.enabled = true
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
        qLauncher.getAllKeys()
    }
}

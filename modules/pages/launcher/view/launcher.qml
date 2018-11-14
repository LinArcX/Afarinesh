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

    //    color: "#D7CCC8"//"#DCDCDC"
    Launcher {
        id: qLauncher
    }

    Rectangle {
        id: qProjects
        width: parent.width / 4
        height: parent.height - 40
        color: "#424242" //"#767676"

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
            visible: true

            // height: 200
            //anchors.fill: parent
            //anchors.top: qListView.bottom
            //z: 1
            Rectangle {
                id: qsaeed
                width: parent.width
                anchors.bottom: parent.bottom
                color: "green"
                //                z: 1
                //height: 200
                //                            anchors.left: parent.left
                //                            anchors.top: parent.top
                //anchors.fill: parent
            }
            //             height: 600
            //            cursorShape: Qt.CrossCursor
            //            hoverEnabled: true

            //}
            //            onHoveredChanged: {
            //                //qRectContent.enabled = false
            //                //qMouseAreaParent.enabled = true
            //                //qMouseAreaParent.z = 5
            //                console.log("hover")
            //                console.log(qMouseAreaParent.enabled)
            ////                console.log(qMouseInner.enabled)
            //            }
        }

        ListModel {
            id: qModel
        }

        ListView {
            id: qListView
            width: parent.width
            //height: 400
            model: qModel
            clip: true
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            ScrollBar.vertical: ScrollBar {
            }

            //            height: qProjects.height
            //implicitHeight: qProjects.height
            //            onChildrenChanged: {
            //                console.log(qListView.children[1].height)
            //                qListView.height += qListView.children[1].heigh
            //                qsaeed.height += qProjects.height - qListView.height
            //                qMouseAreaParent.height = qProjects.height - qListView.height
            //            }
            //Component.onCompleted: console.log(qListView.contentHeight)
            //            onChildrenChanged: console.log(qListView.height)
            delegate: Rectangle {
                id: qRectContent
//                anchors.fill: parent
                width: parent.width
                //height: 400
                color: "transparent"
                //                z: 1
                //onChildrenChanged: console.log("as")
                onHeightChanged: {
                    qsaeed.height += qProjects.height - qRectContent.height
                    qMouseAreaParent.height = qProjects.height - qRectContent.height
                    console.log(qRectContent.height)
                    //console.log(qListView.children[1].height)
                    //qListView.height += qListView.children[1].heigh
                }
                //                                height: qNameLabel.height + qAuthorLabel.height + qCommentLabel.height
                //                                        + qComment.height + qPath.height + qPathLabel.height + 20
                Component.onCompleted: {
                    height = qNameLabel.height + qAuthorLabel.height + qCommentLabel.height
                            + qComment.height + qPath.height + qPathLabel.height + 20
                    qListView.height = height
                }

                MouseArea {
                    id: qMouseInner
                    anchors.fill: parent
                    z: 1
                    //                    hoverEnabled: true
                    //                    onHoveredChanged: console.log("t")
//                    Rectangle {
//                        anchors.fill: parent
//                        color: "red"
//                        z: 3
//                    }
                    onClicked: {
                        qPageLoader.setSource("qrc:/pages/Generator.qml", {
                                                  "qModel.name": "saeed"
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
                    qPageLoader.source = ""
                    qImage.visible = true
                    qButton.visible = true
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
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    qModel.remove(qListView.currentIndex)
                    qLauncher.removeItem(qListView.currentItem)
                    qPageLoader.source = ""
                    if (qModel.count == 0) {
                        qImage.visible = true
                        qButton.visible = true
                        qRemove.visible = false
                    }
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
        onSourceChanged: animation.running = true

        NumberAnimation {
            id: animation
            target: qPageLoader.item
            property: "x"
            from: 0
            to: window.width // - qPageLoader.item.width
            duration: 1000
            easing.type: Easing.InExpo
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
                // console.log(qProjects.height - qListView.height)
                //qMouseAreaParent.height = qProjects.height - qListView.height
                //                qMouseAreaParent.anchors.top = qListView.bottom
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

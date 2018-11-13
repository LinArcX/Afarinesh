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
    color: "#DCDCDC" //"#F5F5F5" , "#F5F5F5"
    property string path

    Launcher {
        id: qLauncher
    }

    //    Rectangle {
    //        id: qProjects
    //        width: parent.width / 4 * 1
    //        height: parent.height
    //        anchors.left: parent.left
    //        color: "#767676" //"#43A047"
    //        z: 2
    //    ScrollView {
    //        id: qProjects
    //        width: parent.width / 4 * 1
    //        height: parent.height
    //        anchors.left: parent.left
    //        ScrollBar.vertical.policy: ScrollBar.AsNeeded
    //        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    //        //color: "#767676" //"#43A047"
    //        z: 2

    //        ScrollView {
    //            id: mScrollView
    //            clip: true
    //            width: parent.width
    //            height: parent.height
    //            anchors.top: parent.top
    //            anchors.left: parent.left
    //            ScrollBar.vertical.policy: ScrollBar.AsNeeded
    //            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

    //    ScrollView {
    //        id: mScrollView
    //        clip: true
    //        width: CStr.accordionWidth
    //        height: parent.height - 100
    //        anchors.top: qDashBoardd.bottom
    //        anchors.left: parent.left
    //        ScrollBar.vertical.policy: ScrollBar.AsNeeded
    //        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    //    ScrollView {
    //        id: qProjects
    //        width: parent.width
    //        height: parent.height / 3
    //        anchors.top: parent.top
    //        anchors.left: parent.left
    //        clip: true
    //        ScrollBar.vertical.policy: ScrollBar.AsNeeded
    //        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    Rectangle {
        id: qProjects
        width: parent.width / 4
        height: parent.height
        color: "#767676"
        z: 2

        ListModel {
            id: qModel
        }

        ListView {
            id: qListView
            width: parent.width
            height: qProjects.height
            model: qModel
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            clip: true

            ScrollBar.vertical: ScrollBar {
            }

            delegate: Rectangle {
                width: parent.width
                color: "transparent"
                height: qNameLabel.height + qAuthorLabel.height + qCommentLabel.height + 10
                //                anchors.top: parent.top
                //                anchors.left: parent.left
                //                clip: true
                //                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                //                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                //                width: parent.width
                //                height: qNameLabel.height + qAuthorLabel.height + qCommentLabel.height + 10
                //                ScrollBar.vertical.policy: ScrollBar.AsNeeded

                //                    anchors.fill: parent
                //                    width: qListView.width
                //                    height: parent.height
                //                    color: "transparent"
                Text {
                    id: qNameLabel
                    text: qsTr("Name: ")
                    color: "white"
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 5
                }
                Text {
                    id: qName
                    text: name
                    color: "white"
                    anchors.left: qNameLabel.right
                    anchors.leftMargin: 5
                    font.bold: true
                    anchors.top: qNameLabel.top
                }

                Text {
                    id: qAuthorLabel
                    text: qsTr("Author: ")
                    color: "white"
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: qNameLabel.bottom
                    anchors.topMargin: 5
                }
                Text {
                    id: qAuthor
                    text: author
                    color: "white"
                    anchors.left: qAuthorLabel.right
                    anchors.leftMargin: 5
                    font.bold: true
                    anchors.top: qAuthorLabel.top
                }

                Text {
                    id: qCommentLabel
                    color: "white"
                    text: "\"" + comment + "\""
                    width: qProjects.width
                    wrapMode: TextArea.Wrap
                    anchors.top: qAuthorLabel.bottom
                    anchors.topMargin: 5
                    anchors.bottomMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    font.italic: true
                }

                Rectangle {
                    width: qProjects.width
                    height: 1
                    color: "#DCDCDC"
                    anchors.left: parent.left
                    anchors.top: qCommentLabel.bottom
                }

                Image {
                    source: icon
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: qCommentLabel.top
                    width: 40
                    height: 40
                    //anchors.verticalCenter: parent.verticalCenter
                    //                        anchors.left: (qName.x > qAuthor.x) ? qName.right : qAuthor.right
                    //                        anchors.leftMargin: 10
                    //                    anchors.top: qName.top
                    //                        anchors.fill: parent

                    //                        sourceSize.width: 100
                    //                        sourceSize.height: 100
                }
            }
        }
        // }
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
                qLauncher.hasConfig()
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
                                  "comment": templateInfo[3]
                              })

                qModel.append({
                                  "name": templateInfo[0],
                                  "author": templateInfo[1],
                                  "icon": path + templateInfo[2],
                                  "comment": templateInfo[3]
                              })
                qModel.append({
                                  "name": templateInfo[0],
                                  "author": templateInfo[1],
                                  "icon": path + templateInfo[2],
                                  "comment": templateInfo[3]
                              })
                qModel.append({
                                  "name": templateInfo[0],
                                  "author": templateInfo[1],
                                  "icon": path + templateInfo[2],
                                  "comment": templateInfo[3]
                              })
                qModel.append({
                                  "name": templateInfo[0],
                                  "author": templateInfo[1],
                                  "icon": path + templateInfo[2],
                                  "comment": templateInfo[3]
                              })
                qModel.append({
                                  "name": templateInfo[0],
                                  "author": templateInfo[1],
                                  "icon": path + templateInfo[2],
                                  "comment": templateInfo[3]
                              })
                qModel.append({
                                  "name": templateInfo[0],
                                  "author": templateInfo[1],
                                  "icon": path + templateInfo[2],
                                  "comment": templateInfo[3]
                              })
                qModel.append({
                                  "name": templateInfo[0],
                                  "author": templateInfo[1],
                                  "icon": path + templateInfo[2],
                                  "comment": templateInfo[3]
                              })
                qModel.append({
                                  "name": templateInfo[0],
                                  "author": templateInfo[1],
                                  "icon": path + templateInfo[2],
                                  "comment": templateInfo[3]
                              })
                qPageLoader.source = "qrc:/pages/Generator.qml"
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

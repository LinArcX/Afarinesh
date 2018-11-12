import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3

import QtUtil 1.0

Window {
    id: window
    visible: true
    title: qsTr("Hello World")
    color: "#F5F5F5"
    property alias pageLoader: qPageLoader
    property alias sideBar: qProjects

    QtUtil {
        id: qQtUtil
    }

    Generator {
        id: qGenerator
    }

    Rectangle {
        id: qProjects
        width: parent.width / 4 * 1
        height: parent.height
        anchors.left: parent.left
        color: "#767676" //"#43A047"
        z: 2
        ScrollView {
            id: mScrollView
            clip: true
            width: parent.width
            height: parent.height
            anchors.top: parent.top
            anchors.left: parent.left
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

            ListModel {
                id: qModel
            }

            ListView {
                id: qListView
                width: parent.width
                height: 200
                model: qModel
                delegate: Text {
                    text: name + ": " + author
                }
            }
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
            to: window.width - qPageLoader.item.width
            duration: 1000
            easing.type: Easing.InExpo
        }
    }

    Connections {
        target: qQtUtil
        onKeysIsReady: {
            if (keys.length === 0) {
                qPageLoader.source = "qrc:/Scene.qml"
            } else {
                qGenerator.listTemplates(path)
                qGenerator.getTemplateInfo(path)
                //qProjects.createObject(window)
                //                qPageLoader.width = window.width / 4 * 3
                //                qPageLoader.anchors.right = window.right
            }
        }
    }

    Connections {
        target: qGenerator
        onTemplatesReady: {
            console.log(templates)
        }

        onTemplateInfoReady: {
            console.log(templateInfo)
            qModel.append({
                              "name": templateInfo[0],
                              "author": templateInfo[1],
                              "icon": templateInfo[2],
                              "comment": templateInfo[3]
                          })
        }
    }

    Component.onCompleted: {
        window.minimumWidth = Screen.width / 3 * 2
        window.minimumHeight = Screen.height / 3 * 2
        window.maximumWidth = Screen.width
        window.maximumHeight = Screen.height
        window.x = Screen.width / 2 - window.minimumWidth / 2
        window.y = Screen.height / 2 - window.minimumHeight / 2
        qQtUtil.getAllKeys("afarinesh", "afarinesh", "Templates")
    }
}

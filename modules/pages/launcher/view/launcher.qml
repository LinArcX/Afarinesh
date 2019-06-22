import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.0

import "qrc:/components/qml/"
import "qrc:/pages/"
import "qrc:/fonts/hack/"
import "qrc:/js/Constants.js" as CONS
import LauncherClass 1.0

Window {
    id: window
    visible: true
    LayoutMirroring.enabled: isRTL
    LayoutMirroring.childrenInherit: true

    property string listProjects: "qrc:/pages/ListProjects.qml"
    property string path

    LinarcxToolTip {
        id: qToolTip
        mother: window
        z: 900
    }

    StackView {
        id: qStackView
        width: parent.width - 50
        height: parent.height
        anchors.right: parent.right
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
                                            })
                            qListView.currentIndex = index
                        }
                        onImageEntered: function () {
                            qToolTip.showMe(qCreateIso.x, qCreateIso.y, 2, name)
                        }
                    }
                }
            }
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

    Component {
        id: qShortCut

        Shortcut {
            id: scReloadQML
            sequences: ["F5"]
            context: Qt.WindowShortcut
            onActivated: {
                RuntimeQML.reload()
                console.log("Reloading...")
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
        qStackView.push("qrc:/pages/ChooseNewTemplate.qml")

        if (Qt.platform.os === 'android') {
            console.log("Android Platfrom!")
        } else if (Qt.platform.os === 'linux') {
            console.log("Linux Platfrom!")
        }
        if (DEBUG_MODE) {
            console.log("Debug Mode!")
        } else {
            console.log("Release Mode!")
        }

        console.log(engine)
        console.log(app)
        console.log(isRTL)
    }
}

import QtQuick 2.11
import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.3

import Generator 1.0
import "qrc:/util/qml/"

Rectangle {
    id: qScene
    visible: true
    width: parent.width
    height: parent.height
    color: "#DCDCDC" //"#F5F5F5"

    property string path

    Generator {
        id: qGenerator
    }

    LinArcxToast {
        id: messages
    }

    Connections {
        target: qGenerator
        onFileGenerated: {
            console.log(file)
        }
        onConfigFileExists: {
            if (!isExists) {
                messages.displayMessage("There is no afarinesh.conf!")
            } else {
                //                qProjects.createObject(qScene)
                //                qPageLoader.width = window.width / 4 * 3
                //                qPageLoader.anchors.right = window.right
                qGenerator.listTemplates(path)
                qGenerator.getTemplateInfo(path)
                qPageLoader.source = "qrc:/Generator.qml"
            }
        }

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

    Image {
        id: qImage
        source: "qrc:/images/sad.svg"
        anchors.centerIn: parent
        sourceSize.width: 80
        sourceSize.height: 80
    }

    Button {
        text: "Open A Template :)"
        onClicked: fileDialog.open()
        anchors.top: qImage.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }

    FileDialog {
        id: fileDialog
        title: "Choose Template Directory"
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            path = fileDialog.folder
            qGenerator.isDirExists(fileDialog.folder)
        }
    }

    Component.onCompleted: {


        //qGenerator.generate("Saeed", "/home/linarcx/Generated/", "text.txt")
    }
}

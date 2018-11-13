import QtQuick 2.11
import QtQuick.Controls 2.3

import Generator 1.0

Rectangle {
    id: qScene
    visible: true
    width: parent.width
    height: parent.height

    Generator {
        id: qGenerator
    }

    Connections {
        target: qGenerator
        onFileGenerated: {
            console.log(file)
        }
        onConfigFileExists: {
            if (!isExists) {

            } else {
                //                qProjects.createObject(qScene)
                //                qPageLoader.width = window.width / 4 * 3
                //                qPageLoader.anchors.right = window.right
                qGenerator.listTemplates(path)
                qGenerator.getTemplateInfo(path)

            }
        }
    }

    Component.onCompleted: {


        //qGenerator.generate("Saeed", "/home/linarcx/Generated/", "text.txt")
    }
}

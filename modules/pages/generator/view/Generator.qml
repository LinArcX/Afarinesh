import QtQuick 2.11
import QtQuick.Controls 2.3

import Generator 1.0

Rectangle {
    visible: true
    width: parent.width
    height: parent.height

    Generator{
        id: qGenerator
    }

    Connections{
        target: qGenerator
        onFileGenerated:{
            console.log(file)
        }
    }

    Component.onCompleted: {
        qGenerator.generate("Saeed", "/home/linarcx/Generated/", "text.txt")
    }
}

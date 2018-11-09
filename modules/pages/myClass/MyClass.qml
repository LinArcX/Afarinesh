import QtQuick 2.11
import QtQuick.Controls 2.3

import MyClass 1.0

Rectangle {
    visible: true
    width: parent.width
    height: parent.height

    MyClass{
        id: qTest
    }

    Connections{
        target: qTest
        onDataReady:{
            console.log(data)
        }
    }

    Component.onCompleted: {
        qTest.isUpperCase("Saeed")
    }
}

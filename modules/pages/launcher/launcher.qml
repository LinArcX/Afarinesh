import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Loader {
        id: pageLoader
        width: parent.width
        height: parent.height
    }

    Component.onCompleted: {
        pageLoader.source = "qrc:/MyClass.qml"
    }
}

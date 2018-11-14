import QtQuick 2.11
import QtQuick.Controls 2.3

Rectangle {
    anchors.fill: parent
//    color: "#DCDCDC"
    color: "white"
    property string name
    property variant qModel: ({

                              })
    Button {
        anchors.centerIn: parent
        text: "click me!"
    }
    Component.onCompleted: console.log(qModel.name)
}

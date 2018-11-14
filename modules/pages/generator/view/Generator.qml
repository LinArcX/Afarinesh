import QtQuick 2.11
import QtQuick.Controls 2.3

Rectangle {
    width: parent.width
    height: parent.height
    color: "white"
    property string name
    property variant models: []


    //    anchors.fill: parent
    //    property variant qModel: ({

    //                              })
    //    width: 200
    //    height: 200
    //    color: "#DCDCDC"
    // Component.onCompleted: console.log(qModel.name)
    Label {
        id: qLblTemplates
        text: "Templates: "
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: qCbTemplates.verticalCenter
    }

    ComboBox {
        id: qCbTemplates
        model: models
        anchors.left: qLblTemplates.right
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 10
    }
    Button {
        anchors.centerIn: parent
        text: "click me!"
    }
}

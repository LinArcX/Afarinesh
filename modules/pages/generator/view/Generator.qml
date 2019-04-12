import QtQuick 2.11
import QtQuick.Controls 2.3

import "qrc:/util/qml/"

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
        anchors.leftMargin: 20
        anchors.verticalCenter: qCbTemplates.verticalCenter
    }

    ComboBox {
        id: qCbTemplates
        model: models
        anchors.left: qLblTemplates.right
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 20
    }

    Label {
        id: qLblName
        text: "Name: "
        anchors.left: qLblTemplates.left
        anchors.verticalCenter: qTeName.verticalCenter
    }

    LinArcxTextField {
        id: qTeName
        anchors.left: qCbTemplates.left
        anchors.top: qCbTemplates.bottom
        anchors.topMargin: 15
        width: qCbTemplates.width
        height: qCbTemplates.height
    }

    Label {
        id: qLblPath
        text: "Save To: "
        anchors.left: qLblTemplates.left
        anchors.verticalCenter: qBtnPath.verticalCenter
    }

    Button {
        id: qBtnPath
        anchors.left: qTeName.left
        anchors.top: qTeName.bottom
        anchors.topMargin: 15
        width: qCbTemplates.width
        height: qCbTemplates.height
        text: "Choose Path"
    }

    Button {
        anchors.right: qBtnPath.right
        anchors.top: qBtnPath.bottom
        anchors.topMargin: 25
        width: qCbTemplates.width + qLblTemplates.width + 10
        height: qCbTemplates.height
        text: "Generate!"
        font.bold: true
    }
}

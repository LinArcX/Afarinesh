import QtQuick 2.11
import QtQuick.Controls 2.3
import ListProjectsClass 1.0

import "qrc:/components/qml/"
import "qrc:/fonts/hack/"
import "qrc:/fonts/fontAwesome/"
import "qrc:/js/Constants.js" as CONS

Rectangle {
    id: qViewListProjects
    property var templateIcon
    property var templateName
    property var templateAuthor
    property var templateComment

    property string addFeature: "qrc:/pages/AddFeature.qml"
    property string addProject: "qrc:/pages/AddProject.qml"

    ListProjectsClass {
        id: qListProjects
    }

    //---------------- Popup --------------//
    LinarcxPopUp {
        id: mPopUp
        mImage: "qrc:/images/warning.svg"
        mTitle: "Are you Sure?"
        mBody: Rectangle {
            anchors.fill: parent
            Button {
                id: qYes
                text: "Yes"
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                onClicked: {
                    qLC.removeItem(qListView.currentItem.data[0].qTitle)
                    qModel.remove(qListView.currentIndex)
                    qStackView.pop()
                    mPopUp.close()
                }
            }

            Button {
                text: "No"
                anchors.top: qYes.top
                anchors.right: qYes.left
                anchors.rightMargin: 10
                onClicked: mPopUp.close()
            }
        }
    }

    Connections {
        target: qListProjects
        onProjectsReady: {
            addProjects(projects)
        }
    }

    Rectangle {
        id: qInfo
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        width: parent.width
        height: 100

        Image {
            id: qTemplateIcon
            source: templateIcon
            sourceSize.width: 100
            sourceSize.height: 100
            anchors.left: parent.left
            anchors.top: parent.top
        }

        Column {
            spacing: 10
            anchors.verticalCenter: qTemplateIcon.verticalCenter
            anchors.left: qTemplateIcon.right
            anchors.leftMargin: 10
            anchors.top: qTemplateIcon.top
            width: qInfo.width - qTemplateIcon.width

            Text {
                id: qProjectName
                text: "Template Name: " + templateName
                font.pixelSize: 15
            }

            Text {
                id: qProjectAuthor
                text: "Author: " + templateAuthor
                font.pixelSize: 15
            }

            Text {
                id: qProjectComment
                text: "Comment: " + templateComment
                font.pixelSize: 15
            }
        }
    }

    LinarcxHLine {
        id: listOfAllProjects
        header: "List of all projects"
        anchors.top: qInfo.bottom
        anchors.topMargin: 10
    }

    Grid {
        id: qGrid
        columns: 8
        spacing: 10
        width: parent.width - 50
        height: parent.height
        anchors.top: listOfAllProjects.bottom
        anchors.left: parent.left
        anchors.margins: 10
    }

    LinarcxButton {
        id: btnNewProject
        btnTxt: "Create New " + templateName + " Project"
        onClicked: qStackView.push(addProject, {
                                       "templateName": templateName,
                                       "templateIcon": templateIcon
                                   })
        anchors.bottom: parent.bottom
        width: parent.width / 8 * 5
        height: 40
        anchors.left: parent.left
        qColor: CONS.green500
        iconFamily: Hack.family
        iconName: Hack.nf_dev_sizzlejs
        iconSize: 30
    }

    LinarcxButton {
        id: btnDeleteTemplate
        btnTxt: "Delete Template"
        onClicked: mPopUp.open()
        anchors.bottom: parent.bottom
        width: parent.width / 8 * 2
        height: 40
        anchors.left: btnNewProject.right
        qColor: CONS.red500
        iconFamily: Hack.family
        iconName: Hack.nf_mdi_delete_forever
        iconSize: 25
    }

    LinarcxButton {
        id: btnGoToHome
        btnTxt: "Home"
        onClicked: {
            while (qStackView.depth > 1) {
                qStackView.pop()
            }
        }
        anchors.bottom: parent.bottom
        width: parent.width / 8 * 1
        height: 40
        anchors.left: btnDeleteTemplate.right
        anchors.right: parent.right
        qColor: CONS.indigo500
        iconFamily: Hack.family
        iconName: Hack.nf_oct_home
        iconSize: 30
    }

    function addProjects(projects) {
        for (var i in projects) {
            var component = Qt.createComponent(
                        "qrc:/components/qml/LinarcxCardView.qml")
            if (component.status === Component.Ready) {
                var item = component.createObject(qGrid, {
                                                      "width": qGrid.width / 8,
                                                      "height": 90,
                                                      "shadowHOff": 1,
                                                      "shadowVOff": 1,
                                                      "hasText": true,
                                                      "qText": projects[i].split(
                                                          "/").reverse()[1],
                                                      "qImage": templateIcon
                                                  })
                item.onCardViewClicked.connect(function () {
                    qStackView.push(addFeature, {
                                        "name": "d"
                                    })
                })
            }
        }
    }

    Component.onCompleted: {
        qListProjects.getAllProjects(templateName)
    }
}

//Qt.createQmlObject(//        "import QtQuick.Controls 2.5; "//        + "import \"qrc:/components/qml/\";"//            + "LinarcxCardView {"//                + "width: parent.width / 4;"//                + "height: 70;"
//                + "shadowHOff: 1;"
//                + "shadowVOff: 1;"
//                + "hasText: true;"
//                + "qText:" + projects[i].split("/").reverse()[1] + ";"
//                //+ "qImage:" + templateIcon + ";"
//                + "onCardViewClicked: " + function () { console.log("hi"); } + ";"
//        + "}", qGrid)

//    LinarcxCardView{
//        width: 100
//        height: 100
//        anchors.centerIn: parent
//        shadowHOff: 1
//        shadowVOff: 1
//        fixedText: true
//        qImage: templateIcon
//        qText: templateName
//    }

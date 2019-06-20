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
        mTitle: qsTr("Are you Sure?")
        mBody: Rectangle {
            anchors.fill: parent
            Button {
                id: qYes
                text: qsTr("Yes")
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
                text: qsTr("No")
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

        Rectangle {
            anchors.verticalCenter: qTemplateIcon.verticalCenter
            anchors.left: qTemplateIcon.right
            anchors.leftMargin: 10
            anchors.top: qTemplateIcon.top
            width: qInfo.width - qTemplateIcon.width
            Text {
                id: qProjectName
                text: qsTr("Template Name")
                font.pixelSize: 15
                anchors.left: parent.left
                anchors.top: parent.top
            }

            Text {
                id: qProjectNameArrow
                text: " : "
                font.pixelSize: 15
                anchors.left: qProjectName.right
            }

            Text {
                text: templateName
                font.pixelSize: 15
                anchors.left: qProjectNameArrow.right
            }

            Text {
                id: qProjectAuthor
                text: qsTr("Author")
                font.pixelSize: 15
                anchors.top: qProjectName.bottom
                anchors.topMargin: 5
                anchors.left: parent.left
            }

            Text {
                id: qProjectAuthorArrow
                text: " : "
                font.pixelSize: 15
                anchors.left: qProjectAuthor.right
                anchors.bottom: qProjectAuthor.bottom
            }

            Text {
                text: templateAuthor
                font.pixelSize: 15
                anchors.left: qProjectAuthorArrow.right
                anchors.bottom: qProjectAuthor.bottom
            }

            Text {
                id: qProjectComment
                text: qsTr("Comment")
                font.pixelSize: 15
                anchors.top: qProjectAuthor.bottom
                anchors.topMargin: 5
                anchors.left: parent.left
            }

            Text {
                id: qProjectCommentArrow
                text: " : "
                font.pixelSize: 15
                anchors.left: qProjectComment.right
                anchors.bottom: qProjectComment.bottom
            }

            Text {
                text: templateComment
                font.pixelSize: 15
                anchors.left: qProjectCommentArrow.right
                anchors.bottom: qProjectCommentArrow.bottom
            }
        }
    }

    LinArcxHLine {
        id: listOfAllProjects
        header: qsTr("List of all projects")
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
        height: 40
        width: parent.width / 8 * 5
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        btnText: qsTr("Create New Project")
        btnIcon: Hack.nf_dev_sizzlejs
        btnIconSize: 30
        btnIconColor: CONS.green500
        btnIconFamily: Hack.family

        onClicked: qStackView.push(addProject, {
                                       "templateName": templateName,
                                       "templateIcon": templateIcon,
                                       "templateAuthor": templateAuthor,
                                       "templateComment": templateComment
                                   })
    }

    LinarcxButton {
        id: btnDeleteTemplate
        height: 40
        width: parent.width / 8 * 2
        anchors.bottom: parent.bottom
        anchors.left: btnNewProject.right

        btnText: qsTr("Delete Template")
        btnIcon: Hack.nf_mdi_delete_forever
        btnIconSize: 25
        btnIconColor: CONS.red500
        btnIconFamily: Hack.family

        onClicked: mPopUp.open()
    }

    LinarcxButton {
        id: btnGoToHome
        height: 40
        width: parent.width / 8 * 1
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: btnDeleteTemplate.right

        btnText: qsTr("Home")
        btnIcon: Hack.nf_oct_home
        btnIconSize: 30
        btnIconColor: CONS.indigo500
        btnIconFamily: Hack.family

        onClicked: {
            while (qStackView.depth > 1) {
                qStackView.pop()
            }
        }
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
//Qt.createQmlObject(//        "import QtQuick.Controls 2.5; "//        + "import \"qrc:/components/qml/\";"//            + "LinarcxCardView {"//                + "width: parent.width / 4;"//                + "height: 70;"//                + "shadowHOff: 1;"//                + "shadowVOff: 1;"//                + "hasText: true;"//                + "qText:" + projects[i].split("/").reverse()[1] + ";"//                //+ "qImage:" + templateIcon + ";"
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

//    property bool mirror: Qt.application.layoutDirection == Qt.RightToLeft

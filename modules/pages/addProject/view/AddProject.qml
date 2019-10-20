import QtQuick 2.11
import QtQuick.Controls 2.3
import QtMultimedia 5.8

import AddProjectClass 1.0
import "qrc:/components/qml/"
import "qrc:/fonts/fontAwesome/"
import "qrc:/fonts/hack/"
import "qrc:/js/Constants.js" as CONS

Page {
    id: appPane

    property var targetPath
    property int tableItems
    property int counter: 1
    property var templateName
    property var templateIcon
    property var templateAuthor
    property var templateComment

    property bool isTableValid: false
    property int filledTableItems: 0

    property var myItems: ({

                           })
    property var tableIDs: ({

                            })
    AddProjectClass {
        id: qAPC
    }

   // SoundEffect {
   //     id: sndProjectGenerated
   //     source: "qrc:/sounds/Done.wav"
   // }

    //----------------- File Chooser ------------------//
    LinArcxDialog {
        id: qTargetPathDialog
        parent: window.overlay
        showHidden: false
        nameFilters: ["*.nothingToa"]

        onPickSelected: {
            targetPath = currentFolder()
            lblTargetPath.mText = targetPath
            lblTargetPath.visible = true
            qTargetPathDialog.close()
        }
    }

    Component.onCompleted: {
        qAPC.getVariables(templateName)
    }

    LinarcxNotif {
        id: qNotif
        qIcon: "qrc:/images/confetti.svg"
        qText: qsTr("Project Generated!")
        qColor: CONS.blue
        qPosition: 1
    }

    Connections {
        target: qAPC
        onVarsReady: {
            tableItems = vars.length
            var j = 0
            for (var i in vars) {
                tableIDs[j] = false
                j++
                addRow(qTableVariables, "r" + counter++, vars[i],
                       appPane.width, j - 1)
            }
        }
        onProjectGenerated: {
            btnGenerate.enabled = false
            //sndProjectGenerated.play()
            qNotif.notificaitonTurnOn()
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
        id: chooseProjectName
        header: qsTr("1. Name of the project")
        anchors.top: qInfo.bottom
        anchors.topMargin: 10
    }

    LinarcxTextField {
        id: txtProjectName
        placeholderText: qsTr("Enter Project Name...")
        anchors.top: chooseProjectName.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        onTextChanged: {
            if (txtProjectName.text.length > 0 && lblTargetPath.visible
                    && tableItems == filledTableItems) {
                btnGenerate.enabled = true
            } else {
                btnGenerate.enabled = false
            }
        }
    }

    LinArcxHLine {
        id: chooseProjectPath
        header: qsTr("2. Choose path")
        anchors.top: txtProjectName.bottom
        anchors.topMargin: 20
    }

    LinarcxButton {
        id: btnChooseTargetPath
        width: txtProjectName.width
        anchors.top: chooseProjectPath.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10

        btnText: qsTr("Choose target path")
        btnIcon: Hack.nf_mdi_select
        btnIconSize: 30
        btnIconColor: CONS.orange400
        btnIconFamily: Hack.family

        onClicked: qTargetPathDialog.open()
    }

    LinarcxLabel {
        id: lblTargetPath
        anchors.top: btnChooseTargetPath.bottom
        anchors.topMargin: 15
        anchors.left: btnChooseTargetPath.left
        visible: false
        onVisibleChanged: {
            if (lblTargetPath.visible && txtProjectName.text != ""
                    && tableItems == filledTableItems) {
                btnGenerate.enabled = true
            } else {
                btnGenerate.enabled = false
            }
        }
    }

    ScrollView {
        id: mParent
        clip: true
        width: parent.width
        height: appPane.height - (btnChooseTargetPath.height + lblTargetPath.height
                                  + chooseProjectPath.height + txtProjectName.height
                                  + chooseProjectName.height + btnGenerate.height + 80)
        anchors.top: lblTargetPath.bottom
        anchors.topMargin: 10
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded
        leftPadding: 10

        Column {
            id: qTableVariables
            anchors.horizontalCenter: parent.horizontalCenter
            onWidthChanged: width = appPane.width / 3
            Row {
                spacing: 5
                Column {
                    id: id
                    Label {
                        text: qsTr("Variables")
                        width: appPane.width / 3
                        anchors.horizontalCenter: parent.horizontalCenter
                        background: Rectangle {
                            color: "silver"
                        }
                    }
                }
            }
        }
    }

    LinarcxButton {
        id: btnGenerate
        height: 40
        width: parent.width / 8 * 6
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        btnText: qsTr("Generate")
        btnIcon: Hack.nf_fa_rocket
        btnIconSize: 30
        btnIconColor: CONS.green500
        btnIconFamily: Hack.family

        enabled: {
            if (lblTargetPath.mText != "" && txtProjectName.text != ""
                    && tableItems == filledTableItems)
                btnGenerate.enabled = true
            else
                btnGenerate.enabled = false
        }
        onClicked: {
            qAPC.generateProject(templateName, txtProjectName.text,
                                 lblTargetPath.mText, myItems)
        }
    }

    LinarcxButton {
        id: btnGoBack
        height: 40
        width: parent.width / 8 * 1
        anchors.bottom: parent.bottom
        anchors.left: btnGenerate.right

        btnText: qsTr("Back")
        btnIcon: Hack.nf_mdi_arrow_left_box
        btnIconSize: 30
        btnIconColor: CONS.deppOrang500
        btnIconFamily: Hack.family

        onClicked: qStackView.pop()
    }

    LinarcxButton {
        id: btnGoToHome
        height: 40
        width: parent.width / 8 * 1
        anchors.bottom: parent.bottom
        anchors.left: btnGoBack.right

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

    Component {
        id: tableItemComponent
        Row {
            id: qRow
            spacing: 5
        }
    }

    function addRow(parent, id, mText, width, rowNumber) {

        var rowOne = Qt.createQmlObject(
                    "import QtQuick 2.11;" + "Row {" + "id: \"" + id
                    + "\";" + "spacing: 5;" + "width: " + appPane.width / 3 + ";"
                    + "onWidthChanged: width = " + appPane.width / 3 + "}",
                    qTableVariables)

        var itemOne = Qt.createQmlObject(
                    "import QtQuick 2.11;" + "import QtQuick.Controls 2.5;" + "Column {" + "TextField {"
                    + "placeholderText: \"" + mText + "\";" + "width: "
                    + appPane.width / 3 + ";" + "onWidthChanged: width = "
                    + appPane.width / 3 + ";" + "onTextChanged: {"
                    + "if (text.length > 0) {" + "if (tableIDs[" + rowNumber + "] === false) { "
                    + "tableIDs[" + rowNumber + "] = true;" + "filledTableItems++;"
                    + "};" + "myItems." + mText + " = text;"
                    + "if (txtProjectName.text.length > 0 && lblTargetPath.visible && tableItems == filledTableItems) { " + "btnGenerate.enabled = true " + "}" + "} else {"
                    + "tableIDs[" + rowNumber + "]" + "= false;"
                    + "filledTableItems--;" + "btnGenerate.enabled = false;" + "}" + "}"
                    + "}" + "}", rowOne)
    }
}

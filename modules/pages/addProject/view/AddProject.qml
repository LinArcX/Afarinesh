import QtQuick 2.11
import QtQuick.Controls 2.3

import AddProjectClass 1.0
import "qrc:/components/qml/"
import "qrc:/fonts/fontAwesome/"
import "qrc:/fonts/hack/"
import "qrc:/js/Constants.js" as CONS

Rectangle {
    id: appPane
    color: "white"
    property var targetPath
    property int tableItems
    property int counter: 1
    property var templateName
    property bool isTableValid: false
    property int filledTableItems: 0

    property var myItems: ({})
    property var tableIDs: ({})

    AddProjectClass {
        id: qAPC
    }

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

    Connections {
        target: qAPC
        onVarsReady: {
            tableItems = vars.length
            var j = 0
            for (var i in vars) {
                tableIDs[j] = false;
                j++
                addRow(qTableVariables, "r" + counter++, vars[i], appPane.width, j-1)
            }
        }
    }

    LinarcxHLine {
        id: chooseProjectName
        header: "1. Name of the project"
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    LinarcxTextField {
        id: txtProjectName
        placeholderText: "Enter Project Name..."
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

    LinarcxHLine {
        id: chooseProjectPath
        header: "2. Choose path"
        anchors.top: txtProjectName.bottom
        anchors.topMargin: 20
    }

    LinarcxButton {
        id: btnChooseTargetPath
        btnTxt: 'Choose target path'
        onClicked: qTargetPathDialog.open()
        anchors.top: chooseProjectPath.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: txtProjectName.width
        qColor: CONS.green500
        iconFamily: Hack.family
        iconName: Hack.nf_mdi_select
        iconSize: 30
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
        btnTxt: "Generate"
        width: parent.width / 8 * 6
        height: 40
        anchors.left: parent.left
        qColor: CONS.green500
        anchors.bottom: parent.bottom
        iconFamily: Hack.family
        iconName: Hack.nf_fa_rocket
        iconSize: 30

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
        btnTxt: "Back"
        onClicked: qStackView.pop()
        anchors.bottom: parent.bottom
        width: parent.width / 8 * 1
        height: 40
        anchors.left: btnGenerate.right
        qColor: CONS.deppOrang500
        iconFamily: Hack.family
        iconName: Hack.nf_mdi_arrow_left_box
        iconSize: 30
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
        anchors.left: btnGoBack.right
        qColor: CONS.indigo500
        iconFamily: Hack.family
        iconName: Hack.nf_oct_home
        iconSize: 30
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
                    "import QtQuick 2.11;"+
                        "Row {"+
                            "id: \"" + id + "\";"+
                            "spacing: 5;"+
                            "width: " + appPane.width / 3 + ";"+
                            "onWidthChanged: width = " + appPane.width / 3 +
                        "}",
                    qTableVariables)

        var itemOne = Qt.createQmlObject(
                    "import QtQuick 2.11;" +
                    "import QtQuick.Controls 2.5;"+
                    "Column {"+
                        "TextField {"+
                            "placeholderText: \"" + mText + "\";" +
                            "width: " + appPane.width / 3 + ";" +
                            "onWidthChanged: width = " + appPane.width / 3 + ";" +
                            "onTextChanged: {"+
                                "if (text.length > 0) {"+
                                    "if (tableIDs[" + rowNumber + "] === false) { " +
                                        "tableIDs[" + rowNumber + "] = true;"+
                                        "filledTableItems++;" +
                                    "};"+
                                    "myItems." + mText + " = text;" +

                                    "if (txtProjectName.text.length > 0 && lblTargetPath.visible && tableItems == filledTableItems) { " +
                                        "btnGenerate.enabled = true "+
                                    "}" +
                                "} else {"+
                                    "tableIDs[" + rowNumber + "]" + "= false;"+
                                    "filledTableItems--;"+
                                    "btnGenerate.enabled = false;"+
                                "}"+
                            "}"+
                        "}"+
                    "}",
                    rowOne)
    }
}

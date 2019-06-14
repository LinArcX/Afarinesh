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
    property var templateName
    property int counter: 1
    property bool isTableValid: false
    property int tableItems
    property int filledTableItems: 0
    property var myItems: ({

                           })

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
            console.log("You choose: " + targetPath)
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
            for (var i in vars) {
                addRow("r" + counter++, vars[i], appPane.width)
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
            if (txtProjectName.text != "" && lblTargetPath.visible
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

    TextEdit {
        onTextChanged: {
            text
        }
    }

    function addRow(id, text, width) {
        var rowOne = Qt.createQmlObject(
                    "import QtQuick 2.11; Row { id: \"" + id + "\"; spacing: 5; width: "
                    + appPane.width / 3 + "; onWidthChanged: width = " + appPane.width / 3 + " }",
                    qTableVariables)

        var itemOne = Qt.createQmlObject(
                    "import QtQuick 2.11; import QtQuick.Controls 2.5; Column { TextField { placeholderText: \""
                    + text + "\"; width: " + appPane.width / 3
                    + ";  onWidthChanged: width = " + appPane.width / 3
                    + "; onTextChanged: { if (text != \"\") { myItems." + text
                    + " = text; filledTableItems++; if (txtProjectName.text != \"\" && lblTargetPath.visible && tableItems == filledTableItems) { btnGenerate.enabled = true }  } else { filledTableItems--; btnGenerate.enabled = false  } } } }",
                    rowOne)
    }
}
//            console.log(myItems)
//            console.log(templateName)
//            console.log(txtProjectName.text)
//            console.log(lblTargetPath.mText)

//    Dialog {//        id: dialog//        title: "Edit"//        standardButtons: Dialog.Ok | Dialog.Cancel//        modal: true//        focus: true
//        width: parent.width / 2
//        height: parent.height / 5 * 4

//        x: (parent.width - width) / 2
//        y: parent.height / 15

//        contentItem: Rectangle {
//            id: dlgContent
//            anchors.fill: parent

//            TextField {
//                id: qOne
//                placeholderText: qsTr("Type: ")
//                anchors.top: parent.top
//                anchors.topMargin: 10
//                width: parent.width / 6 * 5
//                anchors.horizontalCenter: parent.horizontalCenter
//            }

//            TextField {
//                id: qTwo
//                placeholderText: qsTr("Year: ")
//                anchors.top: qOne.bottom
//                width: parent.width / 6 * 5
//                anchors.horizontalCenter: parent.horizontalCenter
//            }

//            TextField {
//                id: qThree
//                placeholderText: qsTr("Month: ")
//                anchors.top: qTwo.bottom
//                width: parent.width / 6 * 5
//                anchors.horizontalCenter: parent.horizontalCenter
//            }

//            LinarcxButton {
//                id: qCommit
//                anchors.top: qThree.bottom
//                width: parent.width / 6 * 5
//                anchors.horizontalCenter: parent.horizontalCenter
//                btnTxt: "به روزرسانی"
//                qColor: CONS.green
//                iconFamily: Awesome.family
//                iconName: Awesome.fa_save

//                onClicked: {
//                    qTableVariables.mModel.set(qIndex, {
//                                                   "one": qOne.text,
//                                                   "two": qTwo.text,
//                                                   "three": qThree.text
//                                               })
//                    dialog.close()
//                }
//            }

//            LinarcxButton {
//                anchors.top: qCommit.bottom
//                anchors.topMargin: 10
//                anchors.horizontalCenter: parent.horizontalCenter
//                width: parent.width / 6 * 5
//                onClicked: dialog.close()
//                btnTxt: "انصراف"

//                qColor: CONS.pink
//                iconFamily: Awesome.family
//                iconName: Awesome.fa_hand_paper_o
//            }
//        }

//        footer: Rectangle {
//            height: 0
//        }

//        header: Rectangle {
//            height: 0
//        }
//    }

//            var keys = ["name", "ip", "port"]
//            var values = [txtBuildingName.text, txtIPAddress.text, txtPort.text]
//            dbUtil.insert("buildings", keys, values)

//            if (keys.length === 0) {
//                qStackView.push(initialPage)
//            } else {
//                for (var i in keys) {
//                    path = keys[i]
//                    qLC.hasConfig(keys[i])
//                }
//            }

//                qTableVariables.mModel.append({
//                                                  "one": appVars[i],
//                                                  "two": ""
//                                              })

//    LinarcxTableView {
//        id: qTableVariables
////        width: parent.width
//        anchors.top: lblTargetPath.bottom
//        anchors.left: parent.left
////        anchors.leftMargin: 50
//        anchors.topMargin: 10
//        anchors.horizontalCenter: appPane.horizontalCenter
//        hasDeleteColumns: false
//        hasEditColumns: false
//        dataColumns: 2
//        headerOne: "Var"
//        headerTwo: "Value"
//        mWidth: parent.width / 3

////        Component.onCompleted: {
////            console.log(qTableVariables.width)
////            anchors.leftMargin = appPane.width / 2 - qTableVariables.width / 2
////        }

////        Connections {
////            target: qTableVariables
////            onEditCalled: {
////                qIndex = index
////                qOne.text = obj.one
////                qTwo.text = obj.two
////                qThree.text = obj.three
////                dialog.open()
////            }
////        }
//    }

// mFolder: shortcuts.pictures
// QStandardPaths::writableLocation(QStandardPaths::PicturesLocation)
//        onFileSelected: {
//            targetPath = currentFolder()
//            lblTargetPath.text = targetPath
//            lblTargetPath.visible = true
//            console.log("You choose: " + targetPath)
//            qTargetPathDialog.close()
//        }


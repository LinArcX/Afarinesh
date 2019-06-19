import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

import SettingsClass 1.0

import "qrc:/components/qml/"

import "qrc:/js/Constants.js" as CONS
import "qrc:/js/CoreStrings.js" as CStr
import "qrc:/js/ElementCreator.js" as JS
import "qrc:/js/SettingsStrings.js" as Str

import "qrc:/fonts/hack/"
import "qrc:/fonts/fontAwesome/"

Page {
    id: mSettingsContent

    property variant mySettings: ({

                                  })
    SettingsClass {
        id: mSettings
    }

    ScrollView {
        id: svSettings
        width: parent.width
        height: parent.height - 40
        anchors.top: parent.top
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded

        LinArcxHLine {
            id: paletteHeader
            anchors.top: parent.top
            anchors.topMargin: 20
            width: parent.width
            lineWidth: parent.width - 30
            header: "Style"
            imgPath: CStr.imgPalette
        }

        ComboBox {
            id: cbStyle
            width: parent.width / 6
            anchors.top: paletteHeader.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 10
            Component.onCompleted: {
                JS.createCombo(mSettings.appStyles(),
                               mSettings.appStyleIndex(), svSettings, cbStyle)
            }
        }

        LinArcxHLine {
            id: fontFamilyHeader
            anchors.top: cbStyle.bottom
            anchors.topMargin: 20
            width: parent.width
            lineWidth: parent.width - 30
            header: "Font Family"
            imgPath: CStr.imgText
        }

        ComboBox {
            id: cbFontFamily
            width: parent.width / 6
            anchors.top: fontFamilyHeader.bottom
            anchors.topMargin: 5
            anchors.left: fontFamilyHeader.left
            anchors.leftMargin: 10
            Component.onCompleted: {
                JS.createCombo(mSettings.fontFamilies(),
                               mSettings.fontFamilyIndex(), svSettings,
                               cbFontFamily)
            }
        }

        LinArcxHLine {
            id: fontSizeHeader
            anchors.top: cbFontFamily.bottom
            anchors.topMargin: 20
            width: parent.width
            lineWidth: parent.width - 30
            header: "Font Size"
            imgPath: CStr.imgFontSize
        }

        ComboBox {
            id: cbFontSize
            width: parent.width / 6
            anchors.top: fontSizeHeader.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 10
            Component.onCompleted: {
                JS.createCombo(mSettings.fontSizes(),
                               mSettings.fontSizeIndex(), svSettings,
                               cbFontSize)
            }
        }
    }

    LinarcxButton {
        id: btnSave
        height: 40
        width: parent.width / 2
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        btnText: CStr.save
        btnIcon: Hack.nf_fa_save
        btnIconSize: 20
        btnIconColor: CONS.green500
        btnIconFamily: Hack.family

        onClicked: {
            mySettings.fontFamily = cbFontFamily.currentText
            mySettings.fontSize = cbFontSize.currentText
            mySettings.style = cbStyle.currentText
            mSettings.setSettings(mySettings)

            var mDialog = mDialogChangeSettings.createObject(mSettingsContent)
            mDialog.open()
        }
    }

    LinarcxButton {
        id: btnDefaults
        height: 40
        width: parent.width / 2
        anchors.left: btnSave.right
        anchors.bottom: parent.bottom

        btnText: CStr.defaults
        btnIcon: Hack.nf_midi_history
        btnIconFamily: Hack.family
        btnIconSize: 30
        btnIconColor: CONS.deppOrang500

        onClicked: {
            var mDialog = mDialogResetSettings.createObject(mSettingsContent)
            mDialog.open()
        }
    }

    Component {
        id: mDialogChangeSettings
        Dialog {
            visible: true
            title: "Choose a date"
            standardButtons: StandardButton.Yes | StandardButton.No | StandardButton.Cancel

            onYes: mSettings.restartApp()
            onNo: console.log("no")
            onRejected: console.log("reject")

            Text {
                text: qsTr(Str.settingsDone)
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
            }
        }
    }

    Component {
        id: mDialogResetSettings
        Dialog {
            visible: true
            title: "Reset Settings!"
            standardButtons: StandardButton.Yes | StandardButton.No | StandardButton.Cancel

            onYes: {
                mSettings.resetSettings()
                mSettings.restartApp()
            }
            onNo: console.log("no")
            onRejected: console.log("reject")

            Text {
                text: qsTr(Str.settingsReset)
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
            }
        }
    }
}

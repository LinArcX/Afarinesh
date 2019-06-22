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

    function checkTheme(currentText) {
        if (currentText === "Material" || currentText === "Universal") {
            chbDarkTheme.visible = true
            //            chbDarkTheme.checked = false
        } else {
            chbDarkTheme.visible = false
            //            chbDarkTheme.checked = false
        }
    }

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
            header: qsTr("Style")
            imgPath: CStr.imgPalette
        }

        ComboBox {
            id: cbStyle
            width: parent.width / 6
            anchors.top: paletteHeader.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 10
            onCurrentTextChanged: checkTheme(cbStyle.currentText)
            Component.onCompleted: {
                JS.createCombo(mSettings.appStyles(),
                               mSettings.appStyleIndex(), svSettings, cbStyle)
                checkTheme(cbStyle.currentText)
            }
        }

        CheckBox {
            id: chbDarkTheme
            text: qsTr("Dark")
            visible: false
            anchors.left: cbStyle.right
            anchors.leftMargin: 10
            anchors.verticalCenter: cbStyle.verticalCenter

            Component.onCompleted: {
                if (mSettings.isDark()) {
                    chbDarkTheme.checked = true
                } else {
                    chbDarkTheme.checked = false
                }
            }
        }

        LinArcxHLine {
            id: fontFamilyHeader
            anchors.top: cbStyle.bottom
            anchors.topMargin: 20
            width: parent.width
            lineWidth: parent.width - 30
            header: qsTr("Font Family")
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
            header: qsTr("Font Size")
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

        LinArcxHLine {
            id: languagesHeader
            anchors.top: cbFontSize.bottom
            anchors.topMargin: 20
            width: parent.width
            lineWidth: parent.width - 30
            header: qsTr("App's Language")
            imgPath: CStr.imgPalette
        }

        ComboBox {
            id: cbLanguages
            width: parent.width / 6
            anchors.top: languagesHeader.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 10
            Component.onCompleted: {
                JS.createCombo(mSettings.languages(),
                               mSettings.languageIndex(), svSettings,
                               cbLanguages)
            }
        }
    }

    LinarcxButton {
        id: btnSave
        height: 40
        width: parent.width / 2
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        btnText: qsTr("Save")
        btnIcon: Hack.nf_fa_save
        btnIconSize: 20
        btnIconColor: CONS.green500
        btnIconFamily: Hack.family

        onClicked: {
            mySettings.fontFamily = cbFontFamily.currentText
            mySettings.fontSize = cbFontSize.currentText
            mySettings.style = cbStyle.currentText
            mySettings.currentLanguage = cbLanguages.currentText
            if (chbDarkTheme.checked && cbStyle.currentText == "Material") {
                mySettings.darkMeterial = 1
            }

            if (chbDarkTheme.checked && cbStyle.currentText == "Universal") {
                mySettings.darkUniversal = 1
            }

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

        btnText: qsTr("Defaults")
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
            title: qsTr("Choose a date")
            standardButtons: StandardButton.Yes | StandardButton.No | StandardButton.Cancel

            onYes: mSettings.restartApp()
            onNo: console.log("no")
            onRejected: console.log("reject")

            Text {
                text: qsTr("Your Preferences Done!\n to see changes, restart the app. RESTART NOW?")
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
            title: qsTr("Reset Settings!")
            standardButtons: StandardButton.Yes | StandardButton.No | StandardButton.Cancel

            onYes: {
                mSettings.resetSettings()
                mSettings.restartApp()
            }
            onNo: console.log("no")
            onRejected: console.log("reject")

            Text {
                text: qsTr("Your settings will be gone!\n Are you agree?")
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
            }
        }
    }
}

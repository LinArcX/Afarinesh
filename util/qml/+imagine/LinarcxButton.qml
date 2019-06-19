import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Imagine 2.12
import QtQuick.Controls.Imagine.impl 2.12

T.Button {
    id: control

    // Mandatories
    property int btnTextPos: 4
    property int btnIconPos: 2
    property string btnText
    property string btnIcon
    property string btnIconColor
    property string btnIconFamily

    // Optional
    property int btnTextSize
    property int btnIconSize
    property string btnTextColor

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    spacing: 6 // ###

    topPadding: background ? background.topPadding : 0
    leftPadding: background ? background.leftPadding : 0
    rightPadding: background ? background.rightPadding : 0
    bottomPadding: background ? background.bottomPadding : 0

    topInset: background ? -background.topInset || 0 : 0
    leftInset: background ? -background.leftInset || 0 : 0
    rightInset: background ? -background.rightInset || 0 : 0
    bottomInset: background ? -background.bottomInset || 0 : 0

    icon.width: 24
    icon.height: 24
    icon.color: control.enabled && control.flat
                && control.highlighted ? control.palette.highlight : control.enabled
                                         && (control.down || control.checked
                                             || control.highlighted)
                                         && !control.flat ? control.palette.brightText : control.flat ? control.palette.windowText : control.palette.buttonText

    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        font: control.font
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        color: control.enabled && control.flat
               && control.highlighted ? control.palette.highlight : control.enabled
                                        && (control.down || control.checked
                                            || control.highlighted)
                                        && !control.flat ? control.palette.brightText : control.flat ? control.palette.windowText : control.palette.buttonText
        Text {
            id: mText
            clip: true
            text: btnText
            color: btnTextColor ? btnTextColor : "black"
            font.pixelSize: btnTextSize ? btnTextSize : 15

            Component.onCompleted: {
                if (btnTextPos == 0) {
                    // Left
                    anchors.left = parent.left
                    anchors.leftMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else if (btnTextPos == 1) {
                    // Right
                    anchors.right = parent.right
                    anchors.rightMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else if (btnTextPos == 2) {
                    // Left of Icon
                    anchors.right = mIcon.left
                    anchors.rightMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else if (btnTextPos == 3) {
                    // Right of Icon
                    anchors.left = mIcon.right
                    anchors.leftMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else {
                    // Center
                    anchors.centerIn = parent
                    anchors.verticalCenter = parent.verticalCenter
                }
            }
        }

        Text {
            id: mIcon
            text: btnIcon
            font.family: btnIconFamily
            font.pixelSize: btnIconSize ? btnIconSize : 18
            color: btnIconColor ? btnIconColor : "white"

            Component.onCompleted: {
                if (btnIconPos == 0) {
                    // Left
                    anchors.left = parent.left
                    anchors.leftMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else if (btnIconPos == 1) {
                    // Right
                    anchors.right = parent.right
                    anchors.rightMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else if (btnIconPos == 2) {
                    // Left of Icon
                    anchors.right = mText.left
                    anchors.rightMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else if (btnIconPos == 3) {
                    // Right of Icon
                    anchors.left = mText.right
                    anchors.leftMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else {
                    // Center
                    anchors.centerIn = parent
                    anchors.verticalCenter = parent.verticalCenter
                }
            }
        }
    }

    background: NinePatchImage {
        source: Imagine.url + "button-background"
        NinePatchImageSelector on source {
            states: [{
                    "disabled": !control.enabled
                }, {
                    "pressed": control.down
                }, {
                    "checked": control.checked
                }, {
                    "checkable": control.checkable
                }, {
                    "focused": control.visualFocus
                }, {
                    "highlighted": control.highlighted
                }, {
                    "mirrored": control.mirrored
                }, {
                    "flat": control.flat
                }, {
                    "hovered": control.hovered
                }]
        }
    }
}

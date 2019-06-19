import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

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

    topInset: 6
    bottomInset: 6
    padding: 12
    horizontalPadding: padding - 4
    spacing: 6

    icon.width: 24
    icon.height: 24
    icon.color: !enabled ? Material.hintTextColor : flat
                           && highlighted ? Material.accentColor : highlighted ? Material.primaryHighlightedTextColor : Material.foreground

    Material.elevation: flat ? control.down
                               || control.hovered ? 2 : 0 : control.down ? 8 : 2
    Material.background: flat ? "transparent" : undefined

    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        font: control.font
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        color: !control.enabled ? control.Material.hintTextColor : control.flat
                                  && control.highlighted ? control.Material.accentColor : control.highlighted ? control.Material.primaryHighlightedTextColor : control.Material.foreground

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

    background: Rectangle {
        implicitWidth: 64
        implicitHeight: control.Material.buttonHeight

        radius: 2
        color: !control.enabled ? control.Material.buttonDisabledColor : control.highlighted ? control.Material.highlightedButtonColor : control.Material.buttonColor

        PaddedRectangle {
            y: parent.height - 4
            width: parent.width
            height: 4
            radius: 2
            topPadding: -2
            clip: true
            visible: control.checkable && (!control.highlighted || control.flat)
            color: control.checked
                   && control.enabled ? control.Material.accentColor : control.Material.secondaryTextColor
        }

        // The layer is disabled when the button color is transparent so you can do
        // Material.background: "transparent" and get a proper flat button without needing
        // to set Material.elevation as well
        layer.enabled: control.enabled && control.Material.buttonColor.a > 0
        layer.effect: ElevationEffect {
            elevation: control.Material.elevation
        }

        Ripple {
            clipRadius: 2
            width: parent.width
            height: parent.height
            pressed: control.pressed
            anchor: control
            active: control.down || control.visualFocus || control.hovered
            color: control.flat
                   && control.highlighted ? control.Material.highlightedRippleColor : control.Material.rippleColor
        }
    }
}

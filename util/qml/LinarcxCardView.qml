import QtQuick 2.11
import QtGraphicalEffects 1.0

Rectangle {
    id: qItem
    property int mRadius
    property string qText
    property string qImage
    property int widthOffset
    property int heightOffset
    property int borderWidth
    property int shadowHOff
    property int shadowVOff
    property int shadowRadius
    property bool hasText: false
    property bool fixedText: true
    property variant borderColor

    signal cardViewClicked

    antialiasing: true
    radius: mRadius ? mRadius : 4
    width: widthOffset ? parent.width - widthOffset : parent.width - 20
    height: heightOffset ? parent.height / heightOffset : parent.height / 3

    border {
        width: borderWidth ? borderWidth : 1
        color: borderColor ? borderColor : "#9E9E9E"
    }

    layer.enabled: true
    layer.effect: DropShadow {
        smooth: true
        radius: shadowRadius ? shadowRadius : 10.0
        color: "#80000000"
        transparentBorder: true
        horizontalOffset: shadowHOff ? shadowHOff : 4
        verticalOffset: shadowVOff ? shadowVOff : 4
        samples: 20
        cached: true
    }

    states: [
        State {
            name: "scale"
            PropertyChanges {
                target: qItem
                scale: 0.95
            }
        },
        State {
            name: "normal"
            PropertyChanges {
                target: qItem
                scale: 1
            }
        }
    ]

    transitions: Transition {
        ScaleAnimator {
            duration: 1
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: qItem.state = "scale"
        onExited: qItem.state = "normal"
        onClicked: cardViewClicked()
    }

    Image {
        id: mImage
        source: qImage
        anchors.centerIn: parent
        sourceSize.width: 30
        sourceSize.height: 30
        visible: qImage ? qImage : false
    }

    Rectangle {
        id: qRectText
        opacity: 0.2
        color: "grey"
        width: parent.width
        height: 20
        anchors.bottom: parent.bottom
        visible: fixedText ? fixedText : false
        Text {
            text: qText ? qText : ""
            opacity: 1
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

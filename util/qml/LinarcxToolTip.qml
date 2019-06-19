import QtQuick 2.9

Rectangle {
    id: qTooTip
    visible: false
    color: mColor ? mColor : "#9E9E9E"

    // Mandatory
    property var mother
    property string title

    // Optional
    property int mWidth
    property int mHeight
    property bool isBold
    property bool isItalic
    property string mColor
    property int mPixelSize

    width: mWidth ? mWidth : qTitleToolTip.width
    height: mHeight ? mHeight : qTitleToolTip.height

    SequentialAnimation on scale {
        id: seqAnimation
        running: false
        NumberAnimation {
            from: 0.8
            to: 1
            easing.type: Easing.OutExpo
            duration: 100
        }
        PauseAnimation {
            duration: 700
        }
        NumberAnimation {
            from: 1
            to: 0.0
            easing.type: Easing.OutQuad
            duration: 100
        }
    }

    Text {
        id: qTitleToolTip
        text: title ? title : "Title"
        font.pixelSize: mPixelSize ? mPixelSize : 12
        font.italic: isItalic ? isItalic : true
        font.bold: isBold ? isBold : false
    }

    function showMe(x, y, direction, title) {
        if (direction === 0) {
            // top-left
            qTooTip.x = x - 20
            qTooTip.y = y - 20
        } else if (direction === 1) {
            // top
            qTooTip.x = x
            qTooTip.y = y - 10
        } else if (direction === 2) {
            // top-right
            qTooTip.x = x + 20
            qTooTip.y = y - 20
        } else if (direction === 3) {
            // right
            qTooTip.x = x + 20
            qTooTip.y = y
        } else if (direction === 4) {
            // right-bottom
            qTooTip.x = x + 20
            qTooTip.y = y + 20
        } else if (direction === 5) {
            // bottom
            qTooTip.x = x + 20
            qTooTip.y = y
        } else if (direction === 6) {
            // bottom-left
            qTooTip.x = x - 20
            qTooTip.y = y + 20
        } else if (direction === 7) {
            // left
            qTooTip.x = x - 20
            qTooTip.y = y
        }
        qTooTip.visible = true
        qTitleToolTip.text = title
        seqAnimation.start()
    }
}
//    property int direction

//    Component.onCompleted: {
//        qTooTip.width = qTitleToolTip.width
//        qTooTip.height = qTitleToolTip.height
//    }

//    states: [
//        State {
//            name: "scale"
//            PropertyChanges {
//                target: qImage
//                scale: 0.9
//            }
//        },
//        State {
//            name: "normal"
//            PropertyChanges {
//                target: qImage
//                scale: 1
//            }
//        }
//    ]

//    transitions: Transition {
//        ScaleAnimator {
//            duration: 100
//        }
//    }

//    MouseArea {
//        anchors.fill: parent
//        hoverEnabled: true
//        onEntered: {
//            qTooTip.state = "scale"
//            qTooTip.visible = true
//        }
//        onExited: {
//            qTooTip.state = "normal"
//            qTooTip.visible = false
//        }
//    }

//    onXChanged: console.log("internal x changed!")
//    onYChanged: console.log("internal y changed!")

//    property int mX
//    property int mY
//    x: mX ? mX : 0
//    y: mY ? mY : 0


import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Window 2.3

Image {
    id: qImage

    source: qImg
    sourceSize.height: qWidth ? qWidth : 10
    sourceSize.width: qWidth ? qWidth : 10

    property var qImg
    property var qWidth
    property int qDirection
    property var mParent

    signal imageClicked
    signal imageEntered

    states: [
        State {
            name: "scale"
            PropertyChanges {
                target: qImage
                scale: 0.9
            }
        },
        State {
            name: "normal"
            PropertyChanges {
                target: qImage
                scale: 1
            }
        }
    ]

    transitions: Transition {
        ScaleAnimator {
            duration: 100
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            imageClicked()
        }
        onEntered: {
            qImage.state = "scale"
            imageEntered()
        }
        onExited: {
            qImage.state = "normal"
        }
    }
}

//    LinarcxToolTip {
//        id: qToolTip
//        mother: mParent ? mParent : qImage
//        //direction: qDirection ? qDirection : 3
//        title: qTitle
//    }

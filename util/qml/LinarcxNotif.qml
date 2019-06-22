import QtQuick 2.11
import QtQuick.Controls 2.3

Rectangle {
    id: mNotif
    z: 5
    radius: 15
    visible: false
    color: qColor ? qColor : "green"

    property int minX
    property int maxX
    property string qIcon
    property string qText
    property string qColor
    property int qPosition: 0

    signal notificaitonTurnOn()

    onNotificaitonTurnOn: {
        mNotif.visible = true
        seqAnimation.start()
//        qIcon = icon
//        qText = text
//        qColor = color
//        qPosition = position
    }

    Component.onCompleted: {
        mNotif.width = mTitle.width + mIcon.width + 40
        mNotif.height = 50
        if (qPosition == 0) {
            minX = -mNotif.width
            maxX = -20

            mNotif.anchors.top = parent.top
            mNotif.anchors.topMargin = 10

            mTitle.anchors.left = mNotif.left
            mTitle.anchors.leftMargin = 25

            mIcon.anchors.right = mNotif.right
            mIcon.anchors.rightMargin = 5
        } else if (qPosition == 1) {
            minX = parent.width
            maxX = parent.width - mNotif.width + 20

            mNotif.anchors.top = parent.top
            mNotif.anchors.topMargin = 10

            mTitle.anchors.right = mNotif.right
            mTitle.anchors.rightMargin = 25

            mIcon.anchors.left = mNotif.left
            mIcon.anchors.leftMargin = 5
        } else if (qPosition == 2) {
            minX = -mNotif.width
            maxX = -20

            mNotif.anchors.bottom = parent.bottom
            mNotif.anchors.bottomMargin = 60

            mTitle.anchors.left = mNotif.left
            mTitle.anchors.leftMargin = 25

            mIcon.anchors.right = mNotif.right
            mIcon.anchors.rightMargin = 5
        } else if (qPosition == 3) {
            minX = parent.width
            maxX = parent.width - mNotif.width + 20

            mNotif.anchors.bottom = parent.bottom
            mNotif.anchors.bottomMargin = 60

            mTitle.anchors.right = mNotif.right
            mTitle.anchors.rightMargin = 25

            mIcon.anchors.left = mNotif.left
            mIcon.anchors.leftMargin = 5
        }
    }

    Text {
        id: mTitle
        color: "white"
        text: qsTr(qText)
        font.pixelSize: 13
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: mIcon
        source: qIcon
        sourceSize.width: 30
        sourceSize.height: 30
        anchors.verticalCenter: parent.verticalCenter
    }

    SequentialAnimation on x {
        running: false
        id: seqAnimation
        // Move from minHeight to maxHeight in 300ms, using the OutExpo easing function
        NumberAnimation {
            from: mNotif.minX
            to: mNotif.maxX
            easing.type: Easing.OutExpo
            duration: 300
        }

        // Then pause for 500ms
        PauseAnimation {
            duration: 2000
        }

        // Then move back to minHeight in 1 second, using the OutBounce easing function
        NumberAnimation {
            from: mNotif.maxX
            to: mNotif.minX
            easing.type: Easing.OutQuad
            duration: 1000
        }
    }
}

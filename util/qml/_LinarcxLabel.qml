import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.impl 2.4
import QtQuick.Templates 2.3 as T

Rectangle {
    id: qLabelRect
    color: "#E0E0E0"
    property string mText
    property var mHeight
    property var mWidth

    radius: 5

    Image {
        id: imgClose
        source: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE2LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPCFET0NUWVBFIHN2ZyBQVUJMSUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4NCjxzdmcgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCINCgkgd2lkdGg9IjQ0LjIzOHB4IiBoZWlnaHQ9IjQ0LjIzOHB4IiB2aWV3Qm94PSIwIDAgNDQuMjM4IDQ0LjIzOCIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNDQuMjM4IDQ0LjIzODsiDQoJIHhtbDpzcGFjZT0icHJlc2VydmUiPg0KPGc+DQoJPGc+DQoJCTxnPg0KCQkJPHBhdGggZD0iTTE1LjUzMywyOS40NTVjLTAuMTkyLDAtMC4zODQtMC4wNzMtMC41My0wLjIyYy0wLjI5My0wLjI5My0wLjI5My0wLjc2OSwwLTEuMDYybDEzLjE3MS0xMy4xNzENCgkJCQljMC4yOTMtMC4yOTMsMC43NjgtMC4yOTMsMS4wNjEsMHMwLjI5MywwLjc2OCwwLDEuMDYxTDE2LjA2MywyOS4yMzVDMTUuOTE3LDI5LjM4MiwxNS43MjUsMjkuNDU1LDE1LjUzMywyOS40NTV6Ii8+DQoJCTwvZz4NCgkJPGc+DQoJCQk8cGF0aCBkPSJNMjguNzA0LDI5LjQ1NWMtMC4xOTIsMC0wLjM4NC0wLjA3My0wLjUzLTAuMjJMMTUuMDAyLDE2LjA2NGMtMC4yOTMtMC4yOTMtMC4yOTMtMC43NjgsMC0xLjA2MXMwLjc2OC0wLjI5MywxLjA2MSwwDQoJCQkJbDEzLjE3MSwxMy4xNzFjMC4yOTMsMC4yOTMsMC4yOTMsMC43NjksMCwxLjA2MkMyOS4wODgsMjkuMzgyLDI4Ljg5NiwyOS40NTUsMjguNzA0LDI5LjQ1NXoiLz4NCgkJPC9nPg0KCQk8cGF0aCBkPSJNMjIuMTE5LDQ0LjIzN0M5LjkyMiw0NC4yMzcsMCwzNC4zMTUsMCwyMi4xMkMwLDkuOTI0LDkuOTIyLDAuMDAxLDIyLjExOSwwLjAwMVM0NC4yMzgsOS45MjMsNDQuMjM4LDIyLjEyDQoJCQlTMzQuMzE0LDQ0LjIzNywyMi4xMTksNDQuMjM3eiBNMjIuMTE5LDEuNTAxQzEwLjc1LDEuNTAxLDEuNSwxMC43NTEsMS41LDIyLjEyczkuMjUsMjAuNjE5LDIwLjYxOSwyMC42MTkNCgkJCXMyMC42MTktOS4yNSwyMC42MTktMjAuNjE5UzMzLjQ4OCwxLjUwMSwyMi4xMTksMS41MDF6Ii8+DQoJPC9nPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPC9zdmc+DQo="
        sourceSize.width: 18
        sourceSize.height: 18
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: -10
        anchors.topMargin: -10
        MouseArea {
            anchors.fill: parent
            onClicked: {
                qLabelRect.visible = false
            }
        }
    }
    T.Label {
        id: control
        color: control.palette.windowText
        linkColor: control.palette.link
        anchors.left: imgClose.right
        text: mText ? mText : ""
        anchors.verticalCenter: parent.verticalCenter

        onTextChanged: {
            qLabelRect.width = control.width + 20
            qLabelRect.height = mHeight ? mHeight : control.height * 2
        }

        Component.onCompleted: {
            qLabelRect.width = control.width + 20
            qLabelRect.height = mHeight ? mHeight : control.height * 2
        }
    }
}

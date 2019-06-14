import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1

import "qrc:/fonts/fontAwesome/"

Rectangle {
    id: root
    property alias mModel: qModel
    property string headerOne
    property string headerTwo
    property string headerThree
    property string headerFour
    property string headerFive
    property string headerSix
    property string headerColor
    property string bodyColor
    property var headerHeight
    property var cellHeight
    property bool isHeaderVisible
    property int mWidth
    property int mHeight

    property int dataColumns
    property bool hasEditColumns
    property bool hasDeleteColumns

    property string gray: "#9E9E9E"
    property string darkBlue: "#1976d2"
    property string white: "#FFFFFF"

    signal editCalled(var index, var obj)

    width: mWidth ? mWidth : 100 //qListView.width//parent.parent.width
    height: mHeight ? mHeight : 100 //parent.parent.height

    ListModel {
        id: qModel
    }

    ListView {
        id: qListView
        clip: true
        anchors.top: parent.top
        anchors.bottom: root.bottom
        //        width: mHeader.width
        anchors.horizontalCenter: parent.horizontalCenter
        model: qModel

        header: Rectangle {
            id: mHeader
            width: hOne.width + hTwo.width + hThree.width + hFour.width + hSix.width //root.width
            height: headerHeight ? headerHeight : 50
            Component.onCompleted: {
                qListView.width = mHeader.width
                root.width = mHeader.width
                console.log(mHeader.width)
            }
            visible: {
                if (qModel.count > 0)
                    true
                else
                    false
            }

            Rectangle {
                id: hOne
                width: root.width / 6
                height: parent.height
                anchors.left: parent.left
                color: headerColor ? headerColor : darkBlue
                visible: dataColumns >= 1 ? true : false

                Label {
                    text: headerOne ? headerOne : "one"
                    font.bold: true
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: hTwo
                width: root.width / 6
                height: parent.height
                anchors.left: hOne.right
                color: headerColor ? headerColor : darkBlue
                visible: dataColumns >= 2 ? true : false

                Label {
                    text: headerTwo ? headerTwo : "two"
                    font.bold: true
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: hThree
                width: root.width / 6
                height: parent.height
                anchors.left: hTwo.right
                color: headerColor ? headerColor : darkBlue
                visible: dataColumns >= 3 ? true : false

                Label {
                    text: headerThree ? headerThree : "three"
                    font.bold: true
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: hFour
                width: root.width / 6
                height: parent.height
                anchors.left: hThree.right
                color: headerColor ? headerColor : darkBlue
                visible: dataColumns >= 4 ? true : false

                Label {
                    text: headerFour ? headerFour : "four"
                    font.bold: true
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: hFive
                width: root.width / 6
                height: parent.height
                anchors.left: {
                    if (dataColumns == 4)
                        hFour.right
                    else if (dataColumns == 3)
                        hThree.right
                    else if (dataColumns == 2)
                        hTwo.right
                    else if (dataColumns == 1)
                        hOne.right
                }
                color: headerColor ? headerColor : darkBlue
                visible: hasEditColumns ? hasEditColumns : false

                Label {
                    text: headerFive ? headerFive : "ویرایش"
                    font.bold: true
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: hSix
                width: root.width / 6
                height: parent.height
                anchors.left: hFive.right
                color: headerColor ? headerColor : darkBlue
                visible: hasDeleteColumns ? hasDeleteColumns : false

                Label {
                    text: headerSix ? headerSix : "حذف"
                    font.bold: true
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        delegate: ScrollView {
            id: mParent
            width: parent.width
            height: cellHeight ? cellHeight : 40
            ScrollBar.vertical.policy: ScrollBar.AsNeeded

            Rectangle {
                id: firstItem
                anchors.left: parent.left
                width: parent.width / 6
                height: parent.height
                color: bodyColor ? bodyColor : white
                visible: dataColumns >= 1 ? true : false

                Label {
                    text: headerOne ? one : ""
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                BorderImage {
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                    Rectangle {
                        anchors.fill: parent
                        color: gray
                    }
                }
            }

            Rectangle {
                id: secondItem
                anchors.left: firstItem.right
                width: parent.width / 6
                height: parent.height
                color: bodyColor ? bodyColor : white
                visible: dataColumns >= 2 ? true : false

                Label {
                    text: headerTwo ? two : ""
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                BorderImage {
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                    Rectangle {
                        anchors.fill: parent
                        color: gray
                    }
                }
            }

            Rectangle {
                id: thirdItem
                anchors.left: secondItem.right
                width: parent.width / 6
                height: parent.height
                color: bodyColor ? bodyColor : white
                visible: dataColumns >= 3 ? true : false

                Label {
                    text: headerThree ? three : ""
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                BorderImage {
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                    Rectangle {
                        anchors.fill: parent
                        color: gray
                    }
                }
            }

            Rectangle {
                id: fourthItem
                anchors.left: thirdItem.right
                width: parent.width / 6
                height: parent.height
                color: bodyColor ? bodyColor : white
                visible: dataColumns >= 4 ? true : false

                Label {
                    enabled: dataColumns >= 4 ? true : false
                    text: dataColumns >= 4 ? four : ""
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                BorderImage {
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                    Rectangle {
                        anchors.fill: parent
                        color: gray
                    }
                }
            }

            Rectangle {
                id: btnEdit
                anchors.left: {
                    if (dataColumns == 4)
                        fourthItem.right
                    else if (dataColumns == 3)
                        thirdItem.right
                    else if (dataColumns == 2)
                        secondItem.right
                    else if (dataColumns == 1)
                        firstItem.right
                }
                width: parent.width / 6
                height: parent.height
                color: bodyColor ? bodyColor : white
                visible: hasEditColumns ? hasEditColumns : false

                Label {
                    text: Awesome.fa_pencil
                    font.family: Awesome.family
                    font.pixelSize: 20
                    color: "blue"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                BorderImage {
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                    Rectangle {
                        anchors.fill: parent
                        color: gray
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        qModel.setProperty(index, "edited", !edited)
                        root.updateSelection()
                    }
                }
            }

            Rectangle {
                id: btnDelete
                anchors.left: btnEdit.right
                width: parent.width / 6
                height: parent.height
                color: bodyColor ? bodyColor : white
                visible: hasDeleteColumns ? hasDeleteColumns : false

                Label {
                    font.family: Awesome.family
                    text: Awesome.fa_times_circle
                    font.pixelSize: 20
                    color: "red"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                BorderImage {
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                    Rectangle {
                        anchors.fill: parent
                        color: gray
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        qModel.setProperty(index, "selected", !selected)
                        root.removeSelection()
                    }
                }
            }
        }
    }

    // iterating backwards
    function removeSelection() {
        for (var i = qModel.count - 1; i >= 0; --i) {
            if (qModel.get(i).selected) {
                qModel.remove(i)
                //restarting is no longer needed, and thus we are more efficient :-)
            }
        }
    }

    function updateSelection() {
        for (var i = qModel.count - 1; i >= 0; --i) {
            if (qModel.get(i).edited) {
                var obj = qModel.get(i)
                editCalled(i, obj)
                qModel.get(i).edited = false
            }
        }
    }
}

pragma Singleton

import QtQml 2.12
import QtQuick.Controls.Material 2.12

QtObject {
    property color focusColour: "white"

    property var toolButtonWidth: undefined
    property var toolButtonHeight: undefined

    property color canvasBackgroundColour: "#ddd"
    property color splitColour: "#4fc1e9"
    property color rulerForegroundColour: "white"
    property color rulerBackgroundColour: Qt.darker(_imagineColour, 1.12)

    property color panelColour: Qt.darker(_imagineColour, 1.12)

    property color _imagineColour: "#4fc1e9"
}

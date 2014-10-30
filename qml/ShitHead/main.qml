import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import "ShitHead.js" as Engine
import "GameProperties.js" as GameProperties

Item {
    id: app

    height: Screen.height / 1.5
    width: Screen.width / 2


    SystemPalette { id: activePalette }

    Game {
        id: game
        state: "SettingUp"
    }

    Loader {
        id: pageLoader
        z: 1
        source: "MenuArea.qml"

        anchors {
            fill: parent
        }
    }

    Image {
        id: background
        anchors.fill: parent
        z: 0
        source: "textures/woodBackground.png"
        fillMode: Image.PreserveAspectCrop
    }
}

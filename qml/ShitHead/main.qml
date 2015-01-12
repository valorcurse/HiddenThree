import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import AppProperties 1.0

import "JS/ShitHead.js" as Engine
import "JS/GameProperties.js" as GameProperties
import "Components"

Item {
    id: app

    height: Screen.height / 1.5
    width: Screen.width / 2


    SystemPalette { id: activePalette }

    Player {
        id: myself
        uuid: AppProperties.getUuid.toString()
        ip: "127.0.0.1"
    }

    Loader {
        id: pageLoader
        z: 1
        source: "UI/MenuArea.qml"

        anchors {
            fill: parent
        }
    }

    Image {
        id: background
        anchors.fill: parent
        z: 0
        source: "Textures/woodBackground.png"
        fillMode: Image.PreserveAspectCrop
    }
}

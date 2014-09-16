import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import "ShitHead.js" as Engine
import "GameProperties.js" as GameProperties

Item {
    id: app

    height: Screen.height / 2
    width: Screen.width / 2

    SystemPalette { id: activePalette }

    Loader {
        id: pageLoader
        z: 1
        source: "MenuArea.qml"

        anchors {
            fill: parent
        }

        onLoaded: {
//            GameProperties.cardHeight = Screen.height / 6;
//            GameProperties.cardWidth =  GameProperties.cardHeight / 1.54;;
            areaBinder.target = pageLoader.item;
        }
    }

    Binding {
        id: areaBinder

        property: "state"
        value: "dealCards"
    }

    Image {
        id: background
        anchors.fill: parent
        z: 0
        source: "textures/woodBackground.png"
        fillMode: Image.PreserveAspectCrop
    }
}

import QtQuick 2.0
import QtQuick.Controls 1.2
import "ShitHead.js" as Engine
//import "Card.qml" as Card

Rectangle {
    id: game

    property int screenWidth: 540
    property int screenHeight: 720
    property int stackLevel: 0
    property var topCard
    property var stackOfCards: []
    property var playedCards: []
    property var players: []
    property var playerTurn

    signal cardPlayed

    onCardPlayed: {
        Engine.handlePlay(topCard);
    }

    width: screenWidth; height: screenHeight

    SystemPalette { id: activePalette }

    Loader {
        id: pageLoader
        z: 1

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: toolBar.top
        }

        onLoaded: {
            gameAreaBinder.target = pageLoader.item
        }
    }

    Binding {
           id: gameAreaBinder

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

    Rectangle {
        id: toolBar
        z: 2
        width: parent.width; height: 30
        color: activePalette.window
        anchors.bottom: game.bottom

        Button {
            anchors { left: parent.left; verticalCenter: parent.verticalCenter }
            text: "New Game"
            onClicked: {
                pageLoader.source = "GameArea.qml"
            }
        }
    }
}

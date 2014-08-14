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
        anchors.fill: parent
        source: "GameArea.qml"
//        sourceComponent: gameArea
    }

    Image {
        id: background
        anchors.fill: parent
        source: "textures/woodBackground.png"
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        id: toolBar
        width: parent.width; height: 30
        color: activePalette.window
        anchors.bottom: game.bottom

        Button {
            anchors { left: parent.left; verticalCenter: parent.verticalCenter }
            text: "New Game"
            onClicked: {
                Engine.startNewGame()
            }
        }
    }
}

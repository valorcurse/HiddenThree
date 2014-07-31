import QtQuick 2.0
import "ShitHead.js" as Engine

Rectangle {
    id: game

    property int screenWidth: 490
    property int screenHeight: 720
    property int stackLevel: 0
    property var topCard
    property var stackOfCards: []
    property var playedCards: []
    property var players: []
    property var playerTurn

    width: screenWidth; height: screenHeight

    SystemPalette { id: activePalette }

    Item {
        id: gameArea
        width: parent.width
        anchors { top: parent.top; bottom: toolBar.top }

        Image {
            id: background
            anchors.fill: parent
            source: "textures/woodBackground.png"
            fillMode: Image.PreserveAspectCrop
        }

        Row {
            id: player2Area
            height: parent.height / 4
            spacing: 10

            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            id: playArea
            height: parent.height / 2
            width: parent.width - stackOfCardsArea.width
            anchors { top: player2Area.bottom; bottom: player1Area.top;}
            color: "transparent"
        }

        Row {
            id: player1Area
            height: parent.height / 4
            spacing: 10

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

        }

        Rectangle {
            id: stackOfCardsArea
            width: parent.width / 3
            anchors { top: player2Area.bottom; bottom: player1Area.top; right: parent.right}
            color: "transparent"
        }
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
                Engine.startNewGame(player1Area, player2Area)
            }
        }
    }
}

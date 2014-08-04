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
            spacing: Engine.calculateSpacing(player2Area);

            anchors {
                bottom: playArea.top
                horizontalCenter: parent.horizontalCenter
                bottomMargin: 154 * 1.1
            }
        }

        Rectangle {
            id: playArea
            height: parent.height / 3
            width: parent.width - stackOfCardsArea.width
            anchors {
                verticalCenter: parent.verticalCenter
            }
            color: "red"
            opacity: 0.5
        }

        Row {
            id: player1Area
            height: parent.height / 2
            spacing: Engine.calculateSpacing(player1Area)

            layoutDirection: Qt.RightToLeft // Else the card symbols are hidden

            anchors {
                top: playArea.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 154 * 1.1 // TODO: Get this height from somewhere
            }

        }

        Rectangle {
            id: stackOfCardsArea
            width: parent.width / 3
            height: parent.height / 3

            anchors {
                left: playArea.right
                verticalCenter: playArea.verticalCenter
            }

            color: "blue"
            opacity: 0.5

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
                Engine.startNewGame()
            }
        }
    }
}

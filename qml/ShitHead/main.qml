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
        anchors {
            top: parent.top;
            bottom: toolBar.top
        }

        Image {
            id: background
            anchors.fill: parent
            source: "textures/woodBackground.png"
            fillMode: Image.PreserveAspectCrop
        }

        Row {
            id: player2Area

            spacing: Engine.calculateSpacing(player2Area);

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                bottom: hiddenCardsPlayer2.top
            }
        }

        Rectangle {
            id: hiddenCardsPlayer2
            height: parent.height / 4
            width: parent.width

            color: "transparent"

            anchors {
                bottom: playArea.top
            }
        }

        Rectangle {
            id: playArea
            height: parent.height / 3
            width: parent.width - stackOfCardsArea.width

            color: "transparent"

            anchors {
                verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            id: stackOfCardsArea
            width: parent.width / 3
            height: parent.height / 3

            color: "transparent"

            anchors {
                left: playArea.right
                verticalCenter: playArea.verticalCenter
            }
        }

        Rectangle {
            id: hiddenCardsPlayer1
            height: parent.height / 4

            color: "transparent"

            anchors {
                top: playArea.bottom
                left: parent.left
                right: parent.right
            }
        }

        Row {
            id: player1Area
            height: parent.height / 4

            spacing: Engine.calculateSpacing(player1Area)
            layoutDirection: Qt.RightToLeft // Else the card symbols are hidden

            anchors {
                bottom: parent.bottom
                top:  hiddenCardsPlayer1.bottom
                horizontalCenter: parent.horizontalCenter
            }
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

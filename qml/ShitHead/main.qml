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
//        console.log(game.playedCards[game.playedCards.length - 1].cardObject.number);
        Engine.handlePlay(topCard);
    }

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
            height: parent.height / 4

            spacing: Engine.calculateSpacing(player2Area);

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                bottom: hiddenCardsPlayer2Top.top
            }
        }

        Row {
            id: hiddenCardsPlayer2Top
            height: parent.height / 4
            spacing: 20
            z: 1 // Displays these cards on top

            opacity: 0.5

            anchors {
                bottom: playArea.top
                horizontalCenter: parent.horizontalCenter
            }
        }

        Row {
            id: hiddenCardsPlayer2Bottom
            height: parent.height / 4
            spacing: 20

            anchors {
                bottom: playArea.top
                horizontalCenter: parent.horizontalCenter
            }
        }

        Item {
            id: playArea
            height: parent.height / 3
            width: parent.width - stackOfCardsArea.width

            anchors {
                verticalCenter: parent.verticalCenter
            }
        }

        Item {
            id: stackOfCardsArea
            width: parent.width / 3
            height: parent.height / 3

            anchors {
                left: playArea.right
                verticalCenter: playArea.verticalCenter
            }
        }

        Row {
            id: hiddenCardsPlayer1Top
            height: parent.height / 4
            spacing: 20
            z: 1 // Displays these cards on top

            opacity: 0.5

            anchors {
                top: playArea.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        Row {
            id: hiddenCardsPlayer1Bottom
            height: parent.height / 4
            spacing: 20

            anchors {
                top: playArea.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        Row {
            id: player1Area
            height: parent.height / 4
//            width: parent.width

            spacing: Engine.calculateSpacing(player1Area)
//            layoutDirection: Qt.RightToLeft // Else the card symbols are hidden

            anchors {
                bottom: parent.bottom
                top:  hiddenCardsPlayer1Top.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        Item {
            id: graveyard
            width: 100
            height: 154

            anchors {
                right: parent.left
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

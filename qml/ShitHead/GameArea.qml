import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import "ShitHead.js" as Engine
import "GameProperties.js" as GameProperties

Item {
    id: game

    // Aliases to expose areas to others files
    property alias player2CardsArea: player2CardsArea
    property alias player2ThreeTop: player2ThreeTop
    property alias player2ThreeBottom: player2ThreeBottom
    property alias stackOfCardsArea: stackOfCardsArea
    property alias playArea: playArea
    property alias player1ThreeTop: player1ThreeTop
    property alias player1ThreeBottom: player1ThreeBottom
    property alias player1CardsArea: player1CardsArea
    property alias graveyard: graveyard

    property int stackLevel: playedCards.length
    property var topCard
    property var stackOfCards: []
    property var playedCards: []

    property var players: []
    property var currentPlayer

    property bool cardsAreDealt: false
    property bool topCardsAreChosen: false

    // Fake enum
    property var turn: {"preTurn", "playTurn"}
    property var currentTurn: turn.preTurn

    signal cardPlayed

    onCardPlayed: {
        Engine.handlePlay(topCard);
    }

    StackView {
        height: parent.height / 3

        anchors {
            bottom:  player2ThreeStack.top
            left: parent.left
            right: parent.right
        }

        Row {
            id: player2CardsArea
            objectName: "player2CardsArea"


            spacing: Engine.calculateSpacing(player1CardsArea)
            layoutDirection: Qt.RightToLeft // Else the card symbols are hidden

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }

        DropArea {
            id: player2CardsDropArea

            onDropped: {
                if (drop.source.previousState === "PlayerThreeTop") {
                    Engine.removeTopCard(drop.source);
                    drop.accept();
                }
            }

            anchors {
                fill: parent
            }
        }
    }

    StackView {
        id: player2ThreeStack
        height: GameProperties.cardHeight

        anchors {
            bottom: playArea.top
        }

        Row {
            id: player2ThreeBottom
            objectName: "player2ThreeBottom"

            spacing: 20

            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        Row {
            id: player2ThreeTop
            objectName: "player2ThreeTop"

            spacing: 20

            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        DropArea {
            id: player2ThreeDropArea

            onDropped: {
                if (drop.source.previousState === "PlayerHand" && player2ThreeTop.children.length < 3) {
                    Engine.chooseTopCard(drop.source);
                    drop.accept();
                }
            }

            onEntered: {
                console.log("entered");
            }

            anchors {
                fill: parent
            }
        }

    }


    Rectangle {
        id: playArea
        objectName: "playArea"

        height: parent.height / 3
        width: parent.width - stackOfCardsArea.width

        color: "transparent"

        anchors {
            verticalCenter: parent.verticalCenter
        }

        //        states: [

        //            // If there are no cards on play area
        //            State {
        //                when: playedCards.length === 0

        //                PropertyChanges {
        //                    target: game
        //                    topCard: undefined
        ////                    stackLevel: 0
        //                }
        //            }

        //        ]
    }

    Item {
        id: stackOfCardsArea
        objectName: "stackOfCardsArea"

        width: parent.width / 3
        height: parent.height / 3

        anchors {
            left: playArea.right
            verticalCenter: playArea.verticalCenter
        }
    }

    StackView {
        id: player1ThreeStack
        height: GameProperties.cardHeight

        anchors {
            top: playArea.bottom
        }

        Row {
            id: player1ThreeBottom
            objectName: "player1ThreeBottom"

            spacing: 20

            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        Row {
            id: player1ThreeTop
            objectName: "player1ThreeTop"

            spacing: 20

            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        DropArea {
            id: player1ThreeDropArea

            onDropped: {
                if (drop.source.previousState === "PlayerHand" && player1ThreeTop.children.length < 3) {
                    Engine.chooseTopCard(drop.source);
                    drop.accept();
                }
            }

            onEntered: {
                console.log("entered");
            }

            anchors {
                fill: parent
            }
        }

        Rectangle {
            id: player1ThreeHighlight
            anchors.fill: parent
            color: "blue"
            opacity: 0.5
            visible: player1ThreeDropArea.containsDrag
        }
    }

    StackView {
        height: parent.height / 3

        anchors {
            top:  player1ThreeStack.bottom
            left: parent.left
            right: parent.right
        }

        Row {
            id: player1CardsArea
            objectName: "player1CardsArea"


            spacing: Engine.calculateSpacing(player1CardsArea)
            //            layoutDirection: Qt.RightToLeft // Else the card symbols are hidden

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }

        DropArea {
            id: player1CardsDropArea

            onDropped: {
                if (drop.source.previousState === "PlayerThreeTop") {
                    Engine.removeTopCard(drop.source);
                    drop.accept();
                }
            }

            anchors {
                fill: parent
            }
        }

        Rectangle {
            id: player1HandHighlight
            anchors.fill: parent
            color: "blue"
            opacity: 0.5
            visible: player1CardsDropArea.containsDrag
        }
    }

    Item {
        id: graveyard
        objectName: "graveyard"

        width: 100
        height: GameProperties.cardHeight

        anchors {
            right: parent.left
        }
    }

    states: [
        State {
            name: "dealCards"

            onCompleted: {
                Engine.startNewGame()
            }
        },

        State {
            name: "chooseCards"
            when: cardsAreDealt && !topCardsAreChosen
        },

        State {
            name: "Play"
            when: topCardsAreChosen && currentTurn === turn.preTurn

//            PropertyChanges {
//                target: game
//                currentTurn: Turn.preTurn
//            }

            onCompleted: {
//                Engine.handlePreTurn();
                Engine.switchPlayerTurn(0);
                console.log("entered: play");
            }
        },

//        State {
//            name: "playTurn"
//            when: topCardsAreChosen && currentTurn === turn.playTurn

////            PropertyChanges {
////                target: game
////                currentTurn: Turn.playTurn
////            }

//            onCompleted: {
//                console.log("entered: playTurn");
//            }
//        },

        State {
            name: "gameOver"
            when: {
                if (topCardsAreChosen)
                    for (var id in players) {
                        if (players[id].bottomCards.length === 0) {
                            return true;
                        }
                    }

                return false;
            }

            onCompleted: {
                console.log("entered: gameOver");
            }
        }
    ]
}

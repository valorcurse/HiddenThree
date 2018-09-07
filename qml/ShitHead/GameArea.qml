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

    property bool playersAdded: false
    property bool cardsAreDealt: false
    property bool topCardsAreChosen: false

    // Fake enum
    property var turn: {"preTurn": 0, "playTurn": 1}
    property var currentTurn: turn.preTurn

    signal cardPlayed

    onCardPlayed: {
        Engine.handlePlay(topCard);
    }

//    onPlayersChanged: {
//        console.log("Player added");
//        if (players.length > 1)
//            playersAdded = true;
//    }

    Repeater {
        id: playersRepeater
        model: 2

        Player {
            id: player
            playerID: index

            Component.onCompleted: {
                //                game.players.push(player);
                //                player.state = "Hand";
            }
        }

        Component.onCompleted: {
//            console.log("Repeater count: " + playersRepeater.count);

            for (var i = 0; i < playersRepeater.count; i++) {
                console.log("Adding player");
                game.players.push(playersRepeater.itemAt(i));
            }

            game.state = "DealCards";

            console.log("Players created: " + game.players.length);
//            console.log("Number of players: " + game.players.length);
        }
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


            spacing: Engine.calculateSpacing(player2CardsArea)
            layoutDirection: Qt.RightToLeft // Else the card symbols are hidden

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }

        DropArea {
            id: player2CardsDropArea

            onDropped: {
                var droppedCard = drop.source;
                if (droppedCard.previousState === "ThreeTop") {
                    droppedCard.setAsHandCard();
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
        width: parent.width

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
                var droppedCard = drop.source;
                if (droppedCard.previousState === "Hand" && player2ThreeTop.children.length < 3) {
                    droppedCard.setAsTopCard();
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


    Item {
        id: playArea
        objectName: "playArea"

        height: parent.height / 3
        width: parent.width - stackOfCardsArea.width

        anchors {
            verticalCenter: parent.verticalCenter
        }
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
        width: parent.width

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
                var droppedCard = drop.source;
                if (droppedCard.previousState === "Hand" && player1ThreeTop.children.length < 3) {
                    droppedCard.setAsTopCard();
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

            add: Transition {
                NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
            }

            move: Transition {
                NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
            }

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
                var droppedCard = drop.source;
                if (droppedCard.previousState === "ThreeTop") {
                    droppedCard.setAsHandCard();
                    drop.accept();
                }
            }

            anchors {
                fill: parent
            }
        }
    }

    Item {
        id: graveyard
        objectName: "graveyard"

        width: GameProperties.cardWidth
        height: GameProperties.cardHeight

        anchors {
            right: parent.left
        }
    }

    states: [
        State {
            name: "DealCards"
//            when: playersAdded && !cardsAreDealt

            onCompleted: {
                console.log("entered: DealCards");
                Engine.startNewGame();
            }
        },

        State {
            name: "ChooseCards"
            when: cardsAreDealt && !topCardsAreChosen

            onCompleted: {
                console.log("entered: ChooseCards");
                console.log("State: " + players[0].state);
            }
        },

        State {
            name: "Play"
            when: topCardsAreChosen /*&& currentTurn === turn.preTurn*/

            onCompleted: {
                Engine.switchPlayerTurn(0);
                console.log("entered: play");
            }
        },

        State {
            name: "GameOver"
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
                console.log("entered: GameOver");
            }
        }
    ]
}

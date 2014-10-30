import QtQuick 2.0
import MultiplayerNetwork 1.0

import "ShitHead.js" as Engine

Item {
    id: game

    property string name
    property string ip
    property string uuid

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

    ReceiveRequest {
        id: receiveRequest

        onRequestReceived: {

        }
    }

    SendRequest {
        id: sendRequest
    }

    NetworkCommand {
        id: playCard
        commandData: PlayCard {

        }
    }

    NetworkCommand {
        commandData: CardPlayed {

        }
    }

    signal cardPlayed(var card)
    onCardPlayed: {
        playCard.commandData.number = card.cardObject.number;
        playCard.commandData.type = card.cardObject.type;
        playCard.commandData.action = PlayCard.PLAY;

        sendRequest.send(playCard, ip);

        Engine.handlePlay(game.topCard);
    }

    Repeater {
        id: playerCreator
        model: 2

        Player {
            id: player
            playerID: index
        }

        Component.onCompleted: {
            for (var i = 0; i < playerCreator.count; i++) {
                console.log("Adding player");
                game.players.push(playerCreator.itemAt(i));
            }
        }
    }

    states: [
        State {
            name: "SettingUp"
        },

//        State {
//            name: "DealCards"

//            onCompleted: {
//                console.log("entered: DealCards");
//                Engine.startNewGame();
//            }
//        },

        State {
            name: "ChooseCards"
            when: game.cardsAreDealt && !game.topCardsAreChosen

            onCompleted: {
                console.log("entered: ChooseCards");
                console.log("State: " + game.players[0].state);
            }
        },

        State {
            name: "Play"
            when: game.topCardsAreChosen

            onCompleted: {
                Engine.switchPlayerTurn(0);
                console.log("entered: play");
            }
        },

        State {
            name: "GameOver"
            when: {
                if (game.topCardsAreChosen)
                    for (var id in game.players) {
                        if (game.players[id].bottomCards.length === 0) {
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

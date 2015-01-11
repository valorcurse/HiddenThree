import QtQuick 2.0
import "."

Item {
    id: player

    property int playerID
    property string ip
    property string uuid

    property bool gameOwner: false

    property alias hand: hand
    property alias threeTop: threeTop
    property alias threeBottom: threeBottom
    property var cardContainers: [hand, threeTop, threeBottom]

    function addToHand(card) {
        if (card.player !== player)
            card.player = player;

        card.state = "Hand";
        hand.cards.append({"object": card});
    }

    function addToThreeBottom(card) {
        if (card.player !== player)
            card.player = player;

        card.state = "ThreeBottom";
        threeBottom.cards.append({"object": card});
    }

    function addToThreeTop(card) {
        if (card.player !== player)
            card.player = player;

        card.state = "ThreeTop";
        threeTop.cards.append({"object": card});
    }

    function toJson() {
        var json = {
            id: playerID,
            ip: ip,
        }

        return json;
    }

    PlayerCards {
        id: hand
    }

    PlayerCards {
        id: threeTop
    }

    PlayerCards {
        id: threeBottom
    }

    onStateChanged: {
        console.log("Player " + playerID + " state changed: " + state);
    }

    states: [
        State {
            name: "Hand"
            when: hand.cards.count > 0
        },

        State {
            name: "ThreeTop"
            when: player.threeTop.cards.count > 0 && player.hand.cards.count === 0
        },

        State {
            name: "ThreeBottom"
            when: threeBottom.cards.count > 0 && threeTop.cards.count === 0
        },

        State {
            name: "Won"
            when: threeTop.cards.count === 0
                  && hand.cards.count === 0
                  && threeBottom.cards.count === 0
        }

    ]
}

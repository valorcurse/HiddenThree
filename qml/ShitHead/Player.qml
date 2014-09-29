import QtQuick 2.0

Item {
    id: player

    property int playerID
    property alias hand: hand
    property alias threeTop: threeTop
    property alias threeBottom: threeBottom

    property var cardContainers: [hand, threeTop, threeBottom]

//    property var hand: { "cards": [], "area": {} }
//    property var threeTop: { "cards": [], "area": {} }
//    property var threeBottom: { "cards": [], "area": {} }

    CardArea {
        id: hand
    }

    CardArea {
        id: threeTop
    }

    CardArea {
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
            when: player.threeTop.cards.count > 0 && player.hand.cards.count=== 0
        },

        State {
            name: "ThreeBottom"
            when: threeBottom.cards.count > 0 && threeTop.cards.count === 0
        },

        State {
            name: "Won"
            when: player.threeTop.cards.count === 0 && player.hand.cards.count === 0 && threeBottom.cards.count === 0
        }

    ]
}

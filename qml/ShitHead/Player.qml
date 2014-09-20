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

    Component.onCompleted: {
//        console.log(playerID);
    }


//    onHandCardsChanged: {
//        console.log("Hand has changed");
//    }

    onStateChanged: {
        console.log("Player " + playerID + " state changed: " + state);
    }

//    state: "Hand"

    states: [
        State {
            name: "Hand"
            when: hand.cards.count > 0

//            ScriptAction: {
//                console.log("Entered player Hand state");
//            }
        },

        State {
            name: "ThreeTop"
            when: player.threeTop.cards.count > 0 && player.hand.cards.count=== 0
        },

        State {
            name: "ThreeBottom"
            when: threeBottom.cards.count > 0 && threeTop.cards.count === 0
        }
    ]
}

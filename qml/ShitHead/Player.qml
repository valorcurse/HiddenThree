import QtQuick 2.0

Item {
    id: player

    property int playerID
//    property var hand: { "cards": [], "area": {} }
//    property var threeTop: { "cards": [], "area": {} }
//    property var threeBottom: { "cards": [], "area": {} }

//    property alias handCards: player.hand.cards

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
            when: hand.cards.length > 0

//            ScriptAction: {
//                console.log("Entered player Hand state");
//            }
        }/*,

        State {
            name: "ThreeTop"
            when: player.threeTop.cards.length > 0 && player.hand.cards.length === 0
        },

        State {
            name: "ThreeBottom"
            when: threeBottom.cards.length > 0 && threeTop.cards.length === 0
        }*/
    ]
}

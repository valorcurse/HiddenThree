import QtQuick 2.0

Item {
    property int playerID
    property var hand: { "cards": [], "area": {} }
    property var threeTop: { "cards": [], "area": {} }
    property var threeBottom: { "cards": [], "area": {} }

    Component.onCompleted: {
        console.log(playerID);
    }

    onStateChanged: {
        console.log("Player " + playerId + "state changed: " + state);
    }

    states: [
        State {
            name: "Hand"
            when: hand.cards.length > 0

            ScriptAction: {
                console.log("Entered player Hand state");
            }
        },

        State {
            name: "ThreeTop"
            when: threeTop.cards.length > 0 && hand.cards.length === 0
        },

        State {
            name: "ThreeBottom"
            when: threeBottom.cards.length > 0 && threeTop.cards.length === 0
        }
    ]
}

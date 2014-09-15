import QtQuick 2.0

Item {
    property int playerID
    property var hand: { "cards": [], "area": {} }
    property var threeTop: { "cards": [], "area": {} }
    property var threeBottom: { "cards": [], "area": {} }

    Component.onCompleted: {
        console.log(playerID);
    }
}

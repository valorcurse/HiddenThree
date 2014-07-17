import QtQuick 2.0

import "ShitHead.js" as Game

Item {
    id: card

    property var cardObject
//    property var player
    height: 154
    width: 100

    Image {
        id: img
        anchors.fill: parent
        anchors.rightMargin: 5
        anchors.bottomMargin: 5

        source: cardObject.source

    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            Game.playCard(card, playArea, stackLevel)
        }
    }
}

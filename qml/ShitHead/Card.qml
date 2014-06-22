import QtQuick 2.0

import "ShitHead.js" as Game

Item {
    id: card
    property var cardObject

    Image {
        id: img
        anchors.fill: parent
        anchors.rightMargin: 5;
        anchors.bottomMargin: 5;

        source: cardObject.source

        MouseArea {
           id: region;
           anchors.fill: parent;
           onClicked: Game.playCard(screen)
        }
    }
}

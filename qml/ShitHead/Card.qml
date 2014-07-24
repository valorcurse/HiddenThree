import QtQuick 2.0

import "ShitHead.js" as Game

Rectangle {
    id: cardItem

    property var cardObject
    property var player

    height: 154
    width: 100
    color: "transparent"
    border.color: (this.state === "Player1" || this.state === "Player2") ? Game.ifPlayable(cardItem) : "transparent";

    Image {
        id: img
        anchors.fill: parent
        source: cardObject.source

    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            Game.playCard(cardItem, playArea, stackLevel)
        }
    }



    states: [
        State {
            name: "Stack"
            PropertyChanges {
                target: cardItem
                parent: stackOfCardsArea
                y: cardItem.height / 2;
                x: cardItem.width / 2;
                rotation: 0
            }
        },
        State {
            name: "Player1"
            PropertyChanges {
                target: cardItem
                parent: player1Area
                rotation: 0
            }
        },
        State {
            name: "Player2"
            PropertyChanges {
                target: cardItem
                parent: player2Area
                rotation: 0

            }
        },
        State {
            name: "Played"

            ParentChange {
                target: cardItem;
                parent: playArea;
            }

            PropertyChanges {
                target: cardItem
                z: screen.stackLevel
                y: parent.height / 3
                x: parent.width / 3
                rotation: Math.floor(Math.random() * 360) + 1
            }
        }
    ]
}

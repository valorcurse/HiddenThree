import QtQuick 2.0
import QtGraphicalEffects 1.0
import "ShitHead.js" as Engine

Rectangle {
    id: cardItem

    property alias cardItem: cardItem
    property var cardObject
    property int test: 1
    property var player
    property bool playable: Engine.isPlayable(cardItem)

    height: 154
    width: 100
    color: "transparent"
    border.color: (playable) ? "green" : "transparent";
    border.width: 5

    Image {
        id: img
        anchors.fill: parent
        source: cardObject.source

    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            if (cardItem.state == "Player1")
                cardItem.y -= 20
        }

        onExited: {
            if (cardItem.state == "Player1")
                cardItem.y += 20
        }

        onClicked: {
            Engine.playCard(cardItem, playArea, stackLevel)
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
                z: game.stackLevel
                y: parent.height / 3
                x: parent.width / 3
                rotation: Math.floor(Math.random() * 360) + 1
            }
        }
    ]
}
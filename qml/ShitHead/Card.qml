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
            else if (cardItem.state == "Player2")
                cardItem.y += 20
        }

        onExited: {
            if (cardItem.state == "Player1")
                cardItem.y += 20
            else if (cardItem.state == "Player2")
                cardItem.y -= 20
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
                rotation: 0

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        },

        State {
            name: "Player1"
            PropertyChanges {
                target: cardItem
                parent: player1Area
                rotation: 0

                anchors {
                    verticalCenter: undefined
                    horizontalCenter: undefined

                    top: player1Area.top
                    topMargin: cardItem.height / 6
                    bottom: undefined
                }
            }
        },

        State {
            name: "Player2"

            PropertyChanges {
                target: cardItem
                parent: player2Area
                rotation: 0

                anchors {
                    verticalCenter: undefined
                    horizontalCenter: undefined

                    bottom: player2Area.bottom
                    top: undefined
                }
            }
        },

        State {
            name: "Played"

            PropertyChanges {
                target: cardItem

                parent: playArea;
                z: game.stackLevel
                rotation: Math.floor(Math.random() * 360) + 1

                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter

                    top: undefined
                }
            }
        }
    ]
}

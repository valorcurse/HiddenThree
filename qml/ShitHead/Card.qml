import QtQuick 2.0
import QtGraphicalEffects 1.0
import "ShitHead.js" as Engine

Rectangle {
    id: cardItem

    property var cardObject
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
            if (cardItem.state == "Player1Hand")
                cardItem.anchors.topMargin -= 20;
            else if (cardItem.state == "Player2Hand")
                cardItem.anchors.bottomMargin -= 20;
        }

        onExited: {
            if (cardItem.state == "Player1Hand")
                cardItem.anchors.topMargin += 20
            else if (cardItem.state == "Player2Hand")
                cardItem.anchors.bottomMargin += 20
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
            }

            AnchorChanges {
                target: cardItem
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
            }
        },

        State {
            name: "Player1Hand"


            PropertyChanges {
                target: cardItem
                parent: player1Area
                anchors.topMargin: cardItem.height / 6
            }

            AnchorChanges {
                target: cardItem
                anchors {
                    top: player1Area.top
                }
            }

        },


        State {
            name: "Player1HiddenTop"

            PropertyChanges {
                target: cardItem
                parent: hiddenCardsPlayer1Top
            }
        },

        State {
            name: "Player1HiddenBottom"

            PropertyChanges {
                target: cardItem
                parent: hiddenCardsPlayer1Bottom
            }
        },

        State {
            name: "Player2Hand"

            PropertyChanges {
                target: cardItem
                parent: player2Area
                anchors.bottomMargin: cardItem.height / 6
            }
            AnchorChanges {
                target: cardItem
                anchors {
                    bottom: player2Area.bottom
                }
            }
        },

        State {
            name: "Player2HiddenTop"

            PropertyChanges {
                target: cardItem
                parent: hiddenCardsPlayer2Top
            }
        },

        State {
            name: "Player2HiddenBottom"

            PropertyChanges {
                target: cardItem
                parent: hiddenCardsPlayer2Bottom
            }
        },

        State {
            name: "Played"
            PropertyChanges {
                target: cardItem

                parent: playArea
                z: game.stackLevel
                rotation: Math.floor(Math.random() * 360) + 1
            }

            AnchorChanges {
                target: cardItem
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
            }
        },

        State {
            name: "Burned"

            PropertyChanges {
                target: cardItem
                parent: graveyard
            }
        }

    ]
}

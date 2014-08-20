import QtQuick 2.3
import QtGraphicalEffects 1.0
import "ShitHead.js" as Engine

Rectangle {
    id: cardItem

    property var cardObject
    property var player
    property bool playable: Engine.isPlayable(cardItem)
    property bool chosen: false

    height: 154
    width: 100
    color: "transparent"
    border.color: {
        if (playable) {
            if (gameArea.state === "chooseCards" && chosen) {
                return "orange";
            }

            return "green";
        } else {
            return "transparent";
        }
    }
    border.width: 5

    Drag.active: mouseArea.drag.active
    Drag.hotSpot.x: width / 2
    Drag.hotSpot.y: height / 2

    Image {
        id: img
        anchors.fill: parent
        source: cardObject.source
        mipmap: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        drag.target: parent
                onReleased: cardItem.Drag.drop();

        onEntered: {
            if (playable) {
                if (cardItem.state == "Player1Hand")
                    cardItem.anchors.topMargin -= 20;
                else if (cardItem.state == "Player2Hand")
                    cardItem.anchors.bottomMargin -= 20;
            }
        }

        onExited: {
            if (playable) {
                if (cardItem.state == "Player1Hand")
                    cardItem.anchors.topMargin += 20
                else if (cardItem.state == "Player2Hand")
                    cardItem.anchors.bottomMargin += 20
            }
        }

        onClicked: {
            if (gameArea.state === "chooseCards" && cardItem.state === "PlayerThreeTop") {
                chosen = !chosen;
            } else if (gameArea.state === "playCards")
                Engine.playCard(cardItem);
        }
    }

    states: [
        State {
            name: "Stack"

            PropertyChanges {
                target: cardItem
                parent: stackOfCardsArea
                x: stackOfCards.indexOf(cardItem) * 0.2
            }

            AnchorChanges {
                target: cardItem
                anchors {
                    verticalCenter: parent.verticalCenter
                }
            }

            PropertyChanges {
                target: img
                source: "textures/cards/backside.png"
            }
        },

        State {
            name: "PlayerHand"

            PropertyChanges {
                target: cardItem
                parent: player.areas.playerHandArea

            }

            AnchorChanges {
                target: cardItem
                anchors {
                    verticalCenter: parent.verticalCenter
                }
            }

        },

        State {
            name: "PlayerThreeTop"

            PropertyChanges {
                target: cardItem
                parent: player.areas.threeTopArea
            }

            AnchorChanges {
                target: cardItem
                anchors {
                    verticalCenter: parent.verticalCenter
                    //                    horizontalCenter: parent.horizontalCenter
                }
            }
        },

        State {
            name: "PlayerThreeBottom"

            PropertyChanges {
                target: cardItem
                parent: player.areas.threeBottomArea
            }

            PropertyChanges {
                target: img
                source: "textures/cards/backside.png"
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
        },

        State {
            when: cardItem.Drag.active
            ParentChange {
                target: cardItem
                parent: gameArea
            }

            AnchorChanges {
                target: cardItem
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
            }
        }
    ]
}

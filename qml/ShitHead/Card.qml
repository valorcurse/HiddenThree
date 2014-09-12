import QtQuick 2.3
import QtGraphicalEffects 1.0
import "ShitHead.js" as Engine

Rectangle {
    id: cardItem

    property var cardObject
    property var player
    property bool playable: Engine.isPlayable(cardItem)
    property bool chosen: false
    property string previousState: state

    height: 154
    width: 100
    color: "transparent"
    border.color: {
        if (playable) {
            if (game.state === "chooseCards" && chosen) {
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

    onStateChanged: {
        if (cardItem.state !== "Dragged" && cardItem.state !== "") {
            previousState = cardItem.state;
        }
    }

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

        onReleased: {
            if (typeof(cardItem.Drag.target) === "null" || cardItem.Drag.drop() === Qt.IgnoreAction) {
                cardItem.state = previousState;
            }
        }

        //        onEntered: {
        //            if (playable) {
        //                if (cardItem.player.id === 1)
        //                    cardItem.anchors.topMargin -= 20;
        //                else if (cardItem.player.id === 2)
        //                    cardItem.anchors.topMargin += 20;

        //            }
        //        }

        //        onExited: {
        //            if (playable) {
        //                if (cardItem.player.id === 1)
        //                    cardItem.anchors.topMargin += 20
        //                else if (cardItem.player.id === 2)
        //                    cardItem.anchors.topMargin -= 20
        //            }
        //        }

        onClicked: {
            console.log("clicked - player: " + player.id)

            if (game.state === "chooseCards" && cardItem.state === "PlayerThreeTop") {
                chosen = !chosen;
                game.topCardsAreChosen = Engine.areTopCardsChosen();
            }

            else if (game.state === "Play" && currentTurn === turn.playTurn) {
                Engine.playCard(cardItem);
            }
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
                    top: parent.top
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
//                player: null
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
            name: "Dragged"
            when: cardItem.Drag.active

            ParentChange {
                target: cardItem
                parent: game
            }

            AnchorChanges {
                target: cardItem
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
            }
        }
    ]
}

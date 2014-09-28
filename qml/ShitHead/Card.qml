import QtQuick 2.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.1
import "ShitHead.js" as Engine
import "GameProperties.js" as GameProperties

Flipable {
    id: cardItem

    property var cardObject
    property var player
    property bool playable: Engine.isPlayable(cardItem)
    property bool chosen: false
    property string previousState: state

    height: GameProperties.cardHeight;
    width: GameProperties.cardWidth;

    //    border.color: {
    //        if (playable || (player !== undefined && player.state === "ThreeBottom")) {
    //            //                console.log("playable: " + cardObject.number);
    //            if (game.state === "ChooseCards" && chosen) {
    //                return "orange";
    //            }

    //            return "green";
    //        } else {
    //            return "transparent";
    //        }
    //    }
    //    border.width: 5

    Drag.active: mouseArea.drag.active
    Drag.hotSpot.x: width / 2
    Drag.hotSpot.y: height / 2

    onStateChanged: {
        if (cardItem.state !== "Dragged" && cardItem.state !== "") {
            previousState = cardItem.state;
        }
    }


    transform: Rotation {
        id: flipCard
        axis { x:0; y:1; z:0 }

        origin {
            y: cardItem.height / 2
            x: cardItem.width/ 2
        }

        angle: 0
    }

    front: Image {
        id: img
        anchors.fill: parent
        source: cardObject.source
        mipmap: true
    }

    back: Image {
        anchors.fill: parent
        source: "textures/cards/backside.png"
        mipmap: true
    }

    RectangularGlow {
        anchors.fill: parent
        color: {
            if (playable || (player !== undefined && player.state === "ThreeBottom")) {
                if (game.state === "ChooseCards" && chosen) {
                    return "orange";
                }

                return "green";
            } else {
                return "transparent";
            }
        }

        glowRadius: 5
        spread: 0.2

        visible: playable
        opacity: 0.8
        z: -1
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

            if (game.state === "ChooseCards" && cardItem.state === "ThreeTop") {
                chosen = !chosen;

                game.topCardsAreChosen = Engine.areTopCardsChosen();
            }

            else if (game.state === "Play" && currentTurn === turn.playTurn) {
                Engine.playCard(cardItem);
            }

            console.log("Clicked | Player: " + (player === undefined ? "no player" : player.playerID)
                        //                        console.log("Clicked | Playable: " + Engine.isPlayable(cardItem)
                        + " | State: " + cardItem.state
                        + " | Card: " + cardItem.cardObject.number
                        + " | Chosen: " + cardItem.chosen
                        + " | Parent: " + cardItem.parent);
        }
    }

    states: [
        State {
            name: "Stack"

            ParentChange {
                target: cardItem
                parent: stackOfCardsArea
            }

            PropertyChanges {
                target: cardItem
                x: stackOfCards.indexOf(cardItem) * 0.2
            }

            PropertyChanges {
                target: flipCard
                angle: 180
            }

            AnchorChanges {
                target: cardItem

                anchors {
                    verticalCenter: parent.verticalCenter
                }
            }
        },

        State {
            name: "Hand"

            ParentChange {
                target: cardItem
                parent: player.hand.area
            }

            AnchorChanges {
                target: cardItem
                anchors {
                    top: parent.top
                }
            }

        },

        State {
            name: "ThreeTop"

            ParentChange {
                target: cardItem
                parent: player.threeTop.area
            }

            AnchorChanges {
                target: cardItem
                anchors {
                    verticalCenter: parent.verticalCenter
                }
            }
        },

        State {
            name: "ThreeBottom"

            ParentChange {
                target: cardItem
                parent: player.threeBottom.area
            }

            PropertyChanges {
                target: flipCard
                angle: 180
            }
        },

        State {
            name: "Played"


            PropertyChanges {
                target: cardItem

                explicit: true
                z: game.stackLevel
                rotation: Math.floor(Math.random() * 360) + 1
            }

            ParentChange {
                target: cardItem
                parent: playArea
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

    transitions: [
        Transition {
            to: "Played"

            ParentAnimation {
                AnchorAnimation {
                    duration: 500
                }

                RotationAnimation {
                    duration: 500
                }
            }
        },

        Transition {
            from: "ThreeBottom"
            to: "Played"

            ParentAnimation {
                AnchorAnimation {
                    duration: 500
                }

                ScriptAction {
                    script: {
                        flipCard.angle = 180;
                    }
                }

                NumberAnimation {
                    target: flipCard
                    property: "angle"
                }
            }
        },

        Transition {
            to: "Hand"

            ParentAnimation {
                AnchorAnimation {
                    duration: 500
                }

                RotationAnimation {
                    duration: 500
                }
            }
        }
    ]
}

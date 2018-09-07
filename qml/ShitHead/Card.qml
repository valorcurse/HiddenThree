import QtQuick 2.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.1
import "ShitHead.js" as Engine
import "GameProperties.js" as GameProperties
import Arbiter 1.0

Flipable {
    id: card

    Arbiter {
        id: arbiter
    }

    property var cardObject
    property var player

    property bool playable: {
        if (state !== "Hand") return false;

        var stack = stackOfCards.map(function (card) {
            return card.cardObject.number;
        });

        return arbiter.playIsAllowed(stack, cardObject.number);
    }
    property bool chosen: false
    property string previousState: state

    function setAsTopCard() {
        if (player.threeTop.cards.count < 3) {
            var cardIndex = player.hand.indexOf(card);
            player.hand.cards.remove(cardIndex);
            player.addToThreeTop(card);
        }
    }

    function setAsHandCard() {
        var cardIndex = player.threeTop.indexOf(card);
        player.threeTop.cards.remove(cardIndex);
        player.addToHand(card);
    }

    height: GameProperties.cardHeight;
    width: GameProperties.cardWidth;

    Drag.active: mouseArea.drag.active
    Drag.hotSpot.x: width / 2
    Drag.hotSpot.y: height / 2

    onStateChanged: {

        //        console.log("Card " + cardObject.number + " from Player: " + player.playerID + " | New state: " + state);

        if (card.state !== "Dragged" && card.state !== "") {
            previousState = card.state;
        }
    }

    //    Behavior on x {
    ////            enabled: spawned;
    ////            Num{ spring: 2; damping: 0.2 }
    //        }
    //        Behavior on y {
    //            SpringAnimation{ spring: 2; damping: 0.2 }
    //        }


    transform: Rotation {
        id: flipCard
        axis { x:0; y:1; z:0 }

        origin {
            y: card.height / 2
            x: card.width/ 2
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
            if (typeof(card.Drag.target) === "null" || card.Drag.drop() === Qt.IgnoreAction) {
                card.state = previousState;
            }
        }

        //        onEntered: {
        //            if (playable) {
        //                if (card.player.id === 1)
        //                    card.anchors.topMargin -= 20;
        //                else if (card.player.id === 2)
        //                    card.anchors.topMargin += 20;

        //            }
        //        }

        //        onExited: {
        //            if (playable) {
        //                if (card.player.id === 1)
        //                    card.anchors.topMargin += 20
        //                else if (card.player.id === 2)
        //                    card.anchors.topMargin -= 20
        //            }
        //        }

        onClicked: {

            if (game.state === "ChooseCards" && card.state === "ThreeTop") {
                chosen = !chosen;

                game.topCardsAreChosen = Engine.areTopCardsChosen();
            }

            else if (game.state === "Play" && currentTurn === turn.playTurn) {
                if (card.playable) {
                    Engine.playCard(card);
                }
            }

            console.log("Clicked | Player: " + (player === undefined ? "no player" : player.playerID)
                        //                        console.log("Clicked | Playable: " + Engine.isPlayable(card)
                        + " | State: " + card.state
                        + " | Card: " + card.cardObject.number
                        + " | Chosen: " + card.chosen
                        + " | Parent: " + card.parent);
        }
    }

    states: [
        State {
            name: "Stack"

            ParentChange {
                target: card
                parent: stackOfCardsArea
            }

            //            PropertyChanges {
            //                target: card
            //                x: stackOfCards.indexOf(card) * 0.2
            //            }

            PropertyChanges {
                target: flipCard
                angle: 180
            }

            AnchorChanges {
                target: card
                anchors {
                    verticalCenter: parent.verticalCenter
                }
            }
        },

        State {
            name: "Hand"

            ParentChange {
                target: card
                parent: player.hand.area
            }

            AnchorChanges {
                target: card
                anchors {
                    top: parent.top
                }
            }
        },

        State {
            name: "ThreeTop"

            ParentChange {
                target: card
                parent: player.threeTop.area
            }

            AnchorChanges {
                target: card
                anchors {
                    verticalCenter: parent.verticalCenter
                }
            }
        },

        State {
            name: "ThreeBottom"

            ParentChange {
                target: card
                parent: player.threeBottom.area
            }

            PropertyChanges {
                target: flipCard
                angle: 180
            }
        },

        State {
            name: "Played"

            ParentChange {
                target: card
                parent: playArea
            }

            PropertyChanges {
                target: card

                explicit: true
                z: game.stackLevel
                rotation: Math.floor(Math.random() * 360) + 1
            }

            AnchorChanges {
                target: card

                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
            }
        },

        State {
            name: "Burned"

            PropertyChanges {
                target: card
                parent: graveyard
            }
        },

        State {
            name: "Dragged"
            when: card.Drag.active

            ParentChange {
                target: card
                parent: game
            }

            AnchorChanges {
                target: card
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
            from: "Stack"
            to: "Hand"

            ParentAnimation {
                via: game
//            ParallelAnimation {
                AnchorAnimation {
                    duration: 500
                }

//                NumberAnimation {
//                    properties: "x, y"
////                    from: stackOfCardsArea.x
//                    duration: 500
//                }

                RotationAnimation {
                    duration: 500
                }
            }
        }/*,

        Transition {
            from: "Stack"
            //            to: "Hand"

            ParentAnimation {
                AnchorAnimation {
                    duration: 500
                }

                NumberAnimation {
                    properties: "x, y"
                    duration: 500
                }

                //                                NumberAnimation {
                //                                    properties: "x"
                //                                    duration: 500
                //                                }

                //                RotationAnimation {
                //                    duration: 500
                //                }
            }
        }*/
    ]
}

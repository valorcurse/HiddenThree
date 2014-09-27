import QtQuick 2.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.1
import "ShitHead.js" as Engine
import "GameProperties.js" as GameProperties

Rectangle {
    id: cardItem

    property var cardObject
    property var player
    property bool playable: Engine.isPlayable(cardItem)
    property bool chosen: false
    property string previousState: state

    height: GameProperties.cardHeight;
    width: GameProperties.cardWidth;

    color: "transparent"
    border.color: {
        if (playable || (player !== undefined && player.state === "ThreeBottom")) {
            //                console.log("playable: " + cardObject.number);
            if (game.state === "ChooseCards" && chosen) {
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

    Behavior on rotation {}

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
            //            console.log("Condition: " + (player.threeTop.cards.length > 0 && player.hand.cards.length === 0));

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
                target: img
                source: "textures/cards/backside.png"
            }
        },

        State {
            name: "Played"


            PropertyChanges {
                target: cardItem

                z: game.stackLevel
                explicit: true
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

    //    Behavior on rotation {
    //             PropertyAnimation { duration: 1000 }
    //         }

    transitions: Transition {
        //        from: "ThreeTop"
        to: "Played"


        ParallelAnimation {

            ParentAnimation {
                AnchorAnimation {
                    duration: 500
                }
            }

            //            ScriptAction {
            //                script: { cardItem.rotation = Math.floor(Math.random() * 360) + 1; }
            //            }

                        PropertyAnimation {
                            duration: 500
                            property: "rotation"
                        }
        }
    }
}

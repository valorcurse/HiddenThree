import QtQuick 2.3
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
        mipmap: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

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
            if (gameArea.state === "chooseCards") {
                switch(cardItem.state) {
                case "Player1HiddenTop":
                case "Player2HiddenTop": {
                    Engine.removeTopCard(cardItem);
                    break;
                }

                case "Player1Hand":
                case "Player2Hand": {
                    Engine.chooseTopCard(cardItem);
                    break;
                }

                }
            }
            else if (gameArea.state === "playCards")
                Engine.playCard(cardItem);
        }
    }

    onParentChanged: {
        //        console.log(parent)
        //        for (var child in gameArea.children)
        //            console.log(gameArea.children[child]);
    }

    //    function findByObjectName(objectName) {
    //        for (var child in pageLoader.item.children)
    //            if (pageLoader.item.children[child].objectName === objectName)
    //                return pageLoader.item.children[child];

    //        return undefined;
    //    }

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
        }
    ]
}

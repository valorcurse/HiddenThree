import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import "ShitHead.js" as Engine
import "GameProperties.js" as GameProperties

Item {
    id: gameArea

    // Aliases to expose areas to others files
    property alias player2CardsArea: player2CardsArea
    property alias player2ThreeTop: player2ThreeTop
    property alias player2ThreeBottom: player2ThreeBottom
    property alias stackOfCardsArea: stackOfCardsArea
    property alias playArea: playArea
    property alias player1ThreeTop: player1ThreeTop
    property alias player1ThreeBottom: player1ThreeBottom
    property alias player1CardsArea: player1CardsArea
    property alias graveyard: graveyard

    property int stackLevel: game.playedCards.length

//    Game {
//        id: game
//    }

    StackView {
        height: parent.height / 3

        anchors {
            bottom:  player2ThreeStack.top
            left: parent.left
            right: parent.right
        }

        Row {
            id: player2CardsArea
            objectName: "player2CardsArea"


            spacing: Engine.calculateSpacing(player2CardsArea)
            layoutDirection: Qt.RightToLeft // Else the card symbols are hidden

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }

        DropArea {
            id: player2CardsDropArea

            onDropped: {
                var droppedCard = drop.source;
                if (droppedCard.previousState === "ThreeTop") {
                    droppedCard.setAsHandCard();
                    drop.accept();
                }
            }

            anchors {
                fill: parent
            }
        }
    }

    StackView {
        id: player2ThreeStack
        height: GameProperties.cardHeight

        anchors {
            bottom: playArea.top
        }

        Row {
            id: player2ThreeBottom
            objectName: "player2ThreeBottom"

            spacing: 20

            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        Row {
            id: player2ThreeTop
            objectName: "player2ThreeTop"

            spacing: 20

            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        DropArea {
            id: player2ThreeDropArea

            onDropped: {
                var droppedCard = drop.source;
                if (droppedCard.previousState === "Hand" && player2ThreeTop.children.length < 3) {
                    droppedCard.setAsTopCard();
                    drop.accept();
                }
            }

            anchors {
                fill: parent
            }
        }

    }

    Item {
        id: playArea
        objectName: "playArea"

        height: parent.height / 3
        width: parent.width - stackOfCardsArea.width

        anchors {
            verticalCenter: parent.verticalCenter
        }
    }

    Item {
        id: stackOfCardsArea
        objectName: "stackOfCardsArea"

        width: parent.width / 3
        height: parent.height / 3

        anchors {
            left: playArea.right
            verticalCenter: playArea.verticalCenter
        }

        Text {
            text: game.stackOfCards.length
            color: "white"
            font.family: "Helvetica"
            font.pointSize: 24
            style: Text.Outline
            styleColor: "black"

            anchors {

                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }

            z: 70
        }
    }

    StackView {
        id: player1ThreeStack
        height: GameProperties.cardHeight

        anchors {
            top: playArea.bottom
        }

        Row {
            id: player1ThreeBottom
            objectName: "player1ThreeBottom"

            spacing: 20

            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        Row {
            id: player1ThreeTop
            objectName: "player1ThreeTop"

            spacing: 20

            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        DropArea {
            id: player1ThreeDropArea

            onDropped: {
                var droppedCard = drop.source;
                if (droppedCard.previousState === "Hand" &&
                        player1ThreeTop.children.length < 3) {

                    droppedCard.setAsTopCard();
                    drop.accept();
                }
            }

            anchors {
                fill: parent
            }
        }

    }

    StackView {
        height: parent.height / 3

        anchors {
            top:  player1ThreeStack.bottom
            left: parent.left
            right: parent.right
        }

        Row {
            id: player1CardsArea
            objectName: "player1CardsArea"

            add: Transition {
                NumberAnimation { properties: "x, y";}
            }

            spacing: Engine.calculateSpacing(player1CardsArea)

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

        }

        DropArea {
            id: player1CardsDropArea

            onDropped: {
                var droppedCard = drop.source;
                if (droppedCard.previousState === "ThreeTop") {
                    droppedCard.setAsHandCard();
                    drop.accept();
                }
            }

            anchors {
                fill: parent
            }
        }
    }

    Item {
        id: graveyard
        objectName: "graveyard"

        width: GameProperties.cardWidth
        height: GameProperties.cardHeight

        anchors {
            right: parent.left
        }
    }
}

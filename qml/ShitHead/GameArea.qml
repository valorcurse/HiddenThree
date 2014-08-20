import QtQuick 2.0
import QtQuick.Controls 1.2
import "ShitHead.js" as Engine

Item {
    id: gameArea

    property alias player2Area: player2Area
    property alias player2ThreeTop: player2ThreeTop
    property alias player2ThreeBottom: player2ThreeBottom
    property alias stackOfCardsArea: stackOfCardsArea
    property alias playArea: playArea
    property alias player1ThreeTop: player1ThreeTop
    property alias player1ThreeBottom: player1ThreeBottom
    property alias player1CardsArea: player1CardsArea
    property alias graveyard: graveyard

    property bool cardsAreDealt: false
    property bool topCardsAreChosen: Engine.areTopCardsChosen()

    Row {
        id: player2Area
        objectName: "player2Area"

        height: parent.height / 3

        spacing: Engine.calculateSpacing(player2Area);
        layoutDirection: Qt.RightToLeft // Else the card symbols are hidden

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: player2ThreeTop.top
        }
    }

    Row {
        id: player2ThreeTop
        objectName: "player2ThreeTop"

        height: parent.height / 4
        spacing: 20
        z: 1 // Displays these cards on top

        anchors {
            bottom: playArea.top
            horizontalCenter: parent.horizontalCenter
        }
    }

    Row {
        id: player2ThreeBottom
        objectName: "player2ThreeBottom"

        height: parent.height / 4
        spacing: 20

        anchors {
            bottom: playArea.top
            horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: playArea
        objectName: "playArea"

        height: parent.height / 3
        width: parent.width - stackOfCardsArea.width

        color: "transparent"

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
    }

    StackView {
        id: player1ThreeStack
        height: 154

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
                Engine.chooseTopCard(drop.source);
                drop.accept();
            }

            onEntered: {
                console.log("entered");
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


            spacing: Engine.calculateSpacing(player1CardsArea)
            //            layoutDirection: Qt.RightToLeft // Else the card symbols are hidden

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }

        DropArea {
            id: player1CardsDropArea

            onDropped: {
                Engine.removeTopCard(drop.source);
                drop.accept();
            }

            anchors {
                fill: parent
            }
        }
    }
    Item {
        id: graveyard
        objectName: "graveyard"

        width: 100
        height: 154

        anchors {
            right: parent.left
        }
    }

    states: [
        State {
            name: "dealCards"

            onCompleted: {
                Engine.startNewGame()
            }
        },

        State {
            name: "chooseCards"
            when: cardsAreDealt
        },

        State {
            name: "playCards"
            when: topCardsAreChosen
        }

    ]
}

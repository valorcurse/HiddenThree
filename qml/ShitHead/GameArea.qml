import QtQuick 2.0
import "ShitHead.js" as Engine

Item {
    id: gameArea
    width: parent.width

//    anchors {
//        top: parent.top;
//        bottom: toolBar.top
//    }

//    Image {
//        id: background
//        anchors.fill: parent
//        source: "textures/woodBackground.png"
//        fillMode: Image.PreserveAspectCrop
//    }

    Row {
        id: player2Area
        height: parent.height / 4

        spacing: Engine.calculateSpacing(player2Area);
        layoutDirection: Qt.RightToLeft // Else the card symbols are hidden

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            bottom: hiddenCardsPlayer2Top.top
        }
    }

    Row {
        id: hiddenCardsPlayer2Top
        height: parent.height / 4
        spacing: 20
        z: 1 // Displays these cards on top

        //            opacity: 0.5

        anchors {
            bottom: playArea.top
            horizontalCenter: parent.horizontalCenter
        }
    }

    Row {
        id: hiddenCardsPlayer2Bottom
        height: parent.height / 4
        spacing: 20

        anchors {
            bottom: playArea.top
            horizontalCenter: parent.horizontalCenter
        }
    }

    Item {
        id: playArea
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
    }

    Row {
        id: hiddenCardsPlayer1Top
        height: parent.height / 4
        spacing: 20
        z: 1 // Displays these cards on top

        //            opacity: 0.5

        anchors {
            top: playArea.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    Row {
        id: hiddenCardsPlayer1Bottom
        height: parent.height / 4
        spacing: 20

        anchors {
            top: playArea.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    Row {
        id: player1Area
        height: parent.height / 4

        spacing: Engine.calculateSpacing(player1Area)
        //            layoutDirection: Qt.RightToLeft // Else the card symbols are hidden

        anchors {
            bottom: parent.bottom
            top:  hiddenCardsPlayer1Top.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    Item {
        id: graveyard
        width: 100
        height: 154

        anchors {
            right: parent.left
        }
    }
}

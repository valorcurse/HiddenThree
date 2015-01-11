import QtQuick 2.0
import QtQuick.Controls 1.2

import MultiplayerNetwork 1.0
import "../Components"

Item {

    anchors.fill: parent

    Row {
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        spacing: 20

        TextField {
            id: gameName
            placeholderText: "Enter game name"
        }

        Button {
            text: "Create game"

            onClicked: {
                if (gameName.text !== "") {
//                    game.name = gameName.text;

                    myself.gameOwner = true;
                    newGameLoader.source = "NewGameCreated.qml";
                }
            }
        }
    }
}

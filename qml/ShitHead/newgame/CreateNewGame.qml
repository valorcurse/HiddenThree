import QtQuick 2.0
import QtQuick.Controls 1.2

import ReceiveRequest 1.0
import SendRequest 1.0
import NetworkCommand 1.0
import ".."

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
                    game.name = gameName.text;

                    newGameLoader.source = "NewGameCreated.qml";
                }
            }
        }
    }
}

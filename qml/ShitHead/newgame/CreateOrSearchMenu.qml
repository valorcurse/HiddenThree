import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import "../GameProperties.js" as GameProperties
import ".."

Item {
    Column {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        spacing: 20

        Button {
            text: "Create Game"

            anchors {
                horizontalCenter: parent.horizontalCenter
            }

            onClicked: {
                // Need to find a better place to initiate this
//                GameProperties.cardHeight = Screen.height / 6;
//                GameProperties.cardWidth =  GameProperties.cardHeight / 1.54;

//                pageLoader.source = "GameArea.qml";


                newGameLoader.source = "CreateNewGame.qml";
            }
        }

        Button {
            text: "Join Game"

            anchors {
                horizontalCenter: parent.horizontalCenter
            }

            onClicked: {
                pageLoader.source = "../SearchForGame.qml";
            }
        }
    }
}

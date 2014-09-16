import QtQuick 2.0
import QtQuick.Window 2.1
import "GameProperties.js" as GameProperties

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
                GameProperties.cardHeight = Screen.height / 6;
                GameProperties.cardWidth =  GameProperties.cardHeight / 1.54;

                pageLoader.source = "GameArea.qml";
            }
        }

        Button {
            text: "Join Game"

            anchors {
                horizontalCenter: parent.horizontalCenter
            }

            onClicked: {
//                pageLoader.source = "GameArea.qml";
            }
        }
    }
}

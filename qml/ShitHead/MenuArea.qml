import QtQuick 2.0
import "GameProperties.js" as GameProperties
import QtQuick.Window 2.1

Item {

    Column {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        //         AnimatedImage { id: adnimation; source: "textures/waiting.gif" }

        Button {
            text: "New Game"

            onClicked: {
                GameProperties.cardHeight = Screen.height / 6;
                GameProperties.cardWidth =  GameProperties.cardHeight / 1.54;
                pageLoader.source = "newgame/NewGame.qml";
            }
        }
    }
}

import QtQuick 2.0

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
                pageLoader.source = "GameArea.qml";
            }
        }
    }
}

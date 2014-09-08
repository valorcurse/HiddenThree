import QtQuick 2.0

Item {

    Column {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        Button {
            text: "Create Game"

            onClicked: {
//                pageLoader.source = "GameArea.qml";
            }
        }

        Button {
            text: "Join Game"

            onClicked: {
//                pageLoader.source = "GameArea.qml";
            }
        }
    }
}

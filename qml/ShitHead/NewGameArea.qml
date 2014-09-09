import QtQuick 2.0

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

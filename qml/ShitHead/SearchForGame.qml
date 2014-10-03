import QtQuick 2.0
import QtQuick.Controls 1.2
import SendRequest 1.0
import ReceiveRequest 1.0

Item {
    Column {

        spacing: 20

        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        Button {
            id: searchButton
            text: "Search for game"

            anchors {
                horizontalCenter: parent.horizontalCenter
            }

            onClicked: {
                sendRequest.startBroadcasting();
            }
        }

        TableView {
            TableViewColumn{ role: "title"  ; title: "Title" ; width: 100 }
            TableViewColumn{ role: "author" ; title: "Creator" ; width: 100 }
            model: libraryModel

            anchors {
                horizontalCenter: parent.horizontalCenter
            }
        }
    }
    ListModel {
        id: libraryModel
//        ListElement{ title: "A Masterpiece" ; creator: "Gabriel" }
//        ListElement{ title: "Brilliance"    ; creator: "Jens" }
//        ListElement{ title: "Outstanding"   ; creator: "Frederik" }
    }

    SendRequest {
        id: sendRequest
    }

    ReceiveRequest {
        id: receiveRequest

//        onRequestReceived: {
//            console.log("Received message");
//        }
    }

    Component.onCompleted: {
        sendRequest.startBroadcasting();
    }
}

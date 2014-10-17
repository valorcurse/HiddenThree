import QtQuick 2.0
import QtQuick.Controls 1.2
import SendRequest 1.0
import ReceiveRequest 1.0
import NetworkCommand 1.0
import AppProperties 1.0

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
                sendRequest.broadcast();
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

        onRequestReceived: {
            if (message) {
                var json;

                try {
                    json = JSON.parse(message);
                } catch (e) {
                    return undefined;
                }

                // If got own message back
                if (json.uuid === AppProperties.getUuid.toString())
                    return;

                if (json.command === NetworkCommand.GAMEFOUND) {
                    console.log("Found game | uuid: " + json.commandData);
                }
            }
        }
    }

    NetworkCommand {
        id: findGame
        commandType: NetworkCommand.FINDGAME
    }

    Component.onCompleted: {
        sendRequest.broadcast(findGame);
    }
}

import QtQuick 2.0
import QtQuick.Controls 1.2
import SendRequest 1.0
import ReceiveRequest 1.0
import NetworkCommand 1.0
import AppProperties 1.0
import CommandData 1.0

Item {
    Column {

        spacing: 20
        width: parent.width / 2

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
            width: parent.width

            TableViewColumn{ role: "title"  ; title: "Title" ; width: 100 }
            TableViewColumn{ role: "uuid" ; title: "ID" ; width: 100 }
            model: libraryModel

            anchors {
                horizontalCenter: parent.horizontalCenter
            }
        }
    }
    ListModel {
        id: libraryModel

        function indexOf(uuid) {
            for (var i = 0; i < libraryModel.count; i++) {
                if (uuid === libraryModel.get(i).uuid) {
                    return i;
                }
            }

            return -1;
        }
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

                // If got own message back or a previously received message
                if (json.uuid === AppProperties.getUuid.toString() ||
                        libraryModel.indexOf(json.uuid) !== -1)
                    return;

                if (json.command === CommandData.GAMEFOUND) {
                    console.log("Found game | uuid: " + json.commandData.gameName);
                    libraryModel.append({"title": json.commandData.gameName, "uuid": json.uuid})
                }
            }
        }
    }

    NetworkCommand {
        id: findGame

        commandData: GameFound {
            id: findGameCommand
            gameName: game.name

            onDataChanged: {
                foundGame.updateJson();
            }
        }
    }

    Component.onCompleted: {
        sendRequest.broadcast(findGame);
    }
}

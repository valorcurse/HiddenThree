import QtQuick 2.0
import QtQuick.Controls 1.2
import MultiplayerNetwork 1.0
import AppProperties 1.0

import "../JS/ShitHead.js" as Engine

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
                sendRequest.broadcast(findGame);
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

            onDoubleClicked: {
                var rowObject = libraryModel.get(row);
                sendRequest.send(joinGame, rowObject.ip);
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
                if (json.uuid === AppProperties.getUuid.toString())
                    return;

                if (json.commandData.commandType === CommandData.GAMEFOUND) {
                    if (libraryModel.indexOf(json.uuid) > -1)
                        return;

                    game.name = json.commandData.gameName;
                    game.uuid = json.uuid;

                    libraryModel.append({"title": game.name,
                                            "uuid": game.uuid,
                                            "ip": ip})

                }
                else if (json.commandData.commandType === CommandData.GAMEJOINED) {
                    console.log("Joined game!");

                    console.log("IP: " + ip + " | Create: " + JSON.stringify(json));

                    myself.playerID = json.commandData.newPlayerID;

                    for (var playerIndex in json.commandData.players) {

                        var player = json.commandData.players[playerIndex];
                        console.log("New player: " + JSON.stringify(player));
                        Engine.createNewPlayer(player.id,
                                               player.ip,
                                               player.uuid);
                    }

                    newGameLoader.source = "NewGameCreated.qml";
                }
            }
        }
    }

    SendRequest {
        id: sendRequest
    }

    NetworkCommand {
        id: findGame
        objectName: "findGame"

        commandData: FindGame {
        }
    }

    NetworkCommand {
        id: joinGame

        commandData: JoinGame {
        }
    }

    Component.onCompleted: {
        sendRequest.broadcast(findGame);
    }
}

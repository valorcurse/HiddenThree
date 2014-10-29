import QtQuick 2.0
import QtQuick.Controls 1.2
import SendRequest 1.0
import ReceiveRequest 1.0
import NetworkCommand 1.0
import AppProperties 1.0
import CommandData 1.0

import "ShitHead.js" as Engine

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
                //                console.log(libraryModel.get(row).ip)
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

//                console.log(AppProperties.getUuid.toString() +
//                            " && " + json.uuid +
//                            " = " + (AppProperties.getUuid.toString() === json.uuid));

                // If got own message back or a previously received message
                if (json.uuid === AppProperties.getUuid.toString())
                    return;

                console.log("Join: " + JSON.stringify(json));

                if (json.commandData.commandType === CommandData.GAMEFOUND) {
                    //                    console.log("Found game | uuid: " + json.commandData.gameName);

                    if (libraryModel.indexOf(json.uuid) === -1) {
                        libraryModel.append({"title": json.commandData.gameName,
                                                "uuid": json.uuid,
                                                "ip": ip})
                    }
                }
                else if (json.commandData.commandType === CommandData.GAMEJOINED) {
                    console.log("Joined game!");
                }
            }
        }
    }
    //    Game {
    //        id: game
    //    }
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

    //    Game {
    //        id: game
    //    }

    Component.onCompleted: {
        sendRequest.broadcast(findGame);
    }
}

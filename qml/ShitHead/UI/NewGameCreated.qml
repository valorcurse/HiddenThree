import QtQuick 2.0
import QtQuick.Controls 1.2
import MultiplayerNetwork 1.0
import AppProperties 1.0

import "../Components"
import "../JS/ShitHead.js" as Engine

Item {
    Component.onCompleted: {
        myself.playerID = game.players.length;
        game.players.push(myself);
        joinedPlayersList.addPlayer(myself.playerID,
                                    myself.ip,
                                    AppProperties.getUuid.toString());


        //        console.log("Nr Players: " + game.players.length);
//        for (var player in game.players) {
//             console.log("player: " + game.players[player]);
////            playersJson.push(game.players[player].toJson());
//        }
    }

    Column {

        spacing: 20
        width: parent.width / 2

        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        TableView {
            width: parent.width

            anchors {
                horizontalCenter: parent.horizontalCenter
            }

            TableViewColumn { role: "name"; title: "name"; width: 100 }
            TableViewColumn { role: "ip"; title: "IP"; width: 100 }
            TableViewColumn { role: "uuid"; title: "UUID"; width: 100 }
            model: joinedPlayersList
        }
    }

    ListModel {
        id: joinedPlayersList

        function addPlayer(name, ip, uuid) {
            joinedPlayersList.append({"name": name,
                                         "ip": ip,
                                         "uuid": uuid})
        }

        function indexOf(uuid) {
            for (var i = 0; i < joinedPlayersList.count; i++) {
                if (uuid === joinedPlayersList.get(i).uuid) {
                    return i;
                }
            }

            return -1;
        }
    }

    ReceiveRequest {

        onRequestReceived: {
            var json = JSON.parse(message);

            if (myself.gameOwner) {

//                console.log("IP: " + ip + " | Create: " + JSON.stringify(json));

                if (json && typeof json === "object" && json !== null) {
                    if (json.commandData.commandType === CommandData.FINDGAME) {
                        console.log("Someone is looking for a game")

                        answerRequest.send(gameFound, ip);
                    }

                    else if (json.commandData.commandType === CommandData.JOINGAME) {

                        if (joinedPlayersList.indexOf(json.uuid) > -1)
                            return;

//                        console.log("Someone wants to join the game")

                        var playersJson = [];
                        for (var player in game.players) {
                           playersJson.push(game.players[player].toJson());
                        }

                        console.log(JSON.stringify(playersJson));

                        var newPlayer = Engine.createNewPlayer(ip, json.uuid);
                        joinedPlayersList.addPlayer(newPlayer.playerID,
                                                    newPlayer.ip,
                                                    newPlayer.uuid);
                        gameJoined.commandData.newPlayerID = newPlayer.playerID;
                        gameJoined.commandData.players = JSON.stringify(playersJson);

                        answerRequest.send(gameJoined, ip);

                        //                    game.state = "SettingUp";
                        //                    pageLoader.source = "../GameArea.qml";
                    }
                }
            }


        }
    }

    SendRequest {
        id: answerRequest
    }

    NetworkCommand {
        id: gameFound

        commandData: GameFound {
            gameName: game.name
            //              gameName: "lolol"
        }
    }

    NetworkCommand {
        id: gameJoined

        commandData: GameJoined {
        }
    }

    NetworkCommand {
        id: shuffleDeck
        commandData: ShuffledDeck {

        }
    }
}

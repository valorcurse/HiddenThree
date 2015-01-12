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

        for (var playerIndex in game.players) {
            var player = game.players[playerIndex];

            var name = (player.uuid === AppProperties.getUuid.toString())
                    ? "me (" + player.playerID.toString() + ")"
                    : player.playerID.toString()

            joinedPlayersList.addPlayer(player.playerID,
                                        name,
                                        player.ip,
                                        player.uuid);
        }
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
            TableViewColumn { role: "ip"; title: "IP"; width: 120 }
            TableViewColumn { role: "uuid"; title: "UUID"; width: 150 }
            model: joinedPlayersList
        }
    }

    ListModel {
        id: joinedPlayersList

        function addPlayer(playerID, name, ip, uuid) {
            joinedPlayersList.insert(playerID, {"name": name,
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

//                        console.log(JSON.stringify(playersJson));

                        var newPlayer = Engine.createNewPlayer(game.players.length,
                                                               ip,
                                                               json.uuid);

                        joinedPlayersList.addPlayer(newPlayer.playerID,
                                                    newPlayer.playerID.toString(),
                                                    newPlayer.ip,
                                                    newPlayer.uuid);

                        gameJoined.commandData.newPlayerID = newPlayer.playerID;
                        gameJoined.commandData.players = playersJson;

                        console.log("GameJoined: " + JSON.stringify(gameJoined.commandData));

                        answerRequest.send(gameJoined, ip);
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

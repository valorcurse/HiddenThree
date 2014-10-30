import QtQuick 2.0
import ReceiveRequest 1.0
import SendRequest 1.0
import NetworkCommand 1.0
import CommandData 1.0
import ".."

Item {
    Column {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        ReceiveRequest {
            onRequestReceived: {
                var json = JSON.parse(message);

                console.log("IP: " + ip + " | Create: " + JSON.stringify(json));

                if (json && typeof json === "object" && json !== null) {
                    if (json.commandData.commandType === CommandData.FINDGAME) {
                        console.log("Someone is looking for a game")
                        answerRequest.send(gameFound, ip);
                    }

                    else if (json.commandData.commandType === CommandData.JOINGAME) {
                        console.log("Someone wants to join the game")
                        answerRequest.send(gameJoined, ip);
                        pageLoader.source = "GameArea.qml";
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
//                gameName: game.name
                gameName: "lolol"
            }
        }

        NetworkCommand {
            id: gameJoined

            commandData: GameJoined {
            }
        }
    }
}

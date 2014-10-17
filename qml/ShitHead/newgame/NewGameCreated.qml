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

                if (json && typeof json === "object" && json !== null) {
                    if (json.command === NetworkCommand.FINDGAME) {
                        console.log("Someone is looking for a game")
                        answerRequest.broadcast(foundGame);
                    }
                }
            }
        }

        NetworkCommand {
            id: foundGame
            commandType: NetworkCommand.GAMEFOUND

            commandData: FindGame {
                gameName: game.name
            }
        }

        SendRequest {
            id: answerRequest
        }
    }
}

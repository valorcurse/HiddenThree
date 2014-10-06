import QtQuick 2.0
import ReceiveRequest 1.0
import SendRequest 1.0

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
                    if (json.command === "findGame") {
                        var jsonTest = {
                            "name": "lalal"
                        }

                        answerRequest.sendCommand(jsonTest);
                    }
                }
            }
        }

        SendRequest {
            id: answerRequest
        }
    }

    Component.onCompleted: {
        //        answerRequest.startBroadcasting();
    }
}

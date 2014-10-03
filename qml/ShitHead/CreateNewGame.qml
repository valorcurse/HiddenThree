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
        }

        SendRequest {
            id: answerRequest
        }
    }

    Component.onCompleted: {
//        answerRequest.startBroadcasting();
    }
}

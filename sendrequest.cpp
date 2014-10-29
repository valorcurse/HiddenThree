#include "sendrequest.h"

SendRequest::SendRequest(QObject *parent) :
    QObject(parent)
{
    maxNumberOfShots = 6;
    timer = new QTimer(this);
    udpSocket = new QUdpSocket(this);

    connect(timer, SIGNAL(timeout()), this, SLOT(broadcastDatagram()));
    numberOfShots = 0;
}

void SendRequest::broadcast(NetworkCommand * command) {
    timer->start(1000);
    commandToSend = command;
}

void SendRequest::broadcastDatagram() {
    if (numberOfShots >= maxNumberOfShots) {
        timer->stop();
        numberOfShots = 0;
    } else {
        if (commandToSend != nullptr) {
            QByteArray networkCmdMessage = commandToSend->toJson();

            udpSocket->writeDatagram(networkCmdMessage, networkCmdMessage.size(),
                                     QHostAddress::Broadcast, 45454);
        }

        numberOfShots++;
    }
}

void SendRequest::send(NetworkCommand * command, QString ip) {
    if (command != nullptr) {
        QByteArray networkCmdMessage = command->toJson();

        QHostAddress host(ip);
        udpSocket->writeDatagram(networkCmdMessage, networkCmdMessage.size(),
                                 host, 45454);
    }
}

void SendRequest::sendCommand(QJsonObject message) {
    qDebug() << "Send message: " << message["name"];
}

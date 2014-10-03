#include "sendrequest.h"

SendRequest::SendRequest(QObject *parent) :
    QObject(parent)
{
    maxNumberOfShots = 6;
    timer = new QTimer(this);
    udpSocket = new QUdpSocket(this);

    connect(timer, SIGNAL(timeout()), this, SLOT(broadcastDatagram()));
    numberOfShots = 0;

//    startBroadcasting();
}

void SendRequest::startBroadcasting() {
    timer->start(1000);
}

void SendRequest::broadcastDatagram() {
    if (numberOfShots >= maxNumberOfShots) {
        timer->stop();
        numberOfShots = 0;
    } else {
        qDebug() << "Starting to send requests";

        QByteArray datagram = "Broadcast message";
        udpSocket->writeDatagram(datagram.data(), datagram.size(),
                                 QHostAddress::Broadcast, 45454);
        numberOfShots++;
    }
}

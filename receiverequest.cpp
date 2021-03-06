#include "receiverequest.h"

ReceiveRequest::ReceiveRequest(QObject *parent) :
    QObject(parent)
{
    udpSocket = new QUdpSocket(this);
    udpSocket->bind(45454, QUdpSocket::ShareAddress);

    connect(udpSocket, SIGNAL(readyRead()),
            this, SLOT(processPendingDatagrams()));
}

void ReceiveRequest::processPendingDatagrams() {
    while (udpSocket->hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(udpSocket->pendingDatagramSize());
        QHostAddress ip;
        udpSocket->readDatagram(datagram.data(), datagram.size(), &ip);

        emit requestReceived(datagram.data(), ip.toString());
    }
}

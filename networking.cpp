#include <QtNetwork>

#include "networking.h"

Networking::Networking() {
    udpSocket = new QUdpSocket(this);
    udpSocket->bind(45454, QUdpSocket::ShareAddress);

    connect(udpSocket, SIGNAL(readyRead()),
            this, SLOT(processPendingDatagrams()));
}

Networking::~Networking() {}

void Networking::processPendingDatagrams() {
    while (udpSocket->hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(udpSocket->pendingDatagramSize());
        udpSocket->readDatagram(datagram.data(), datagram.size());
        qDebug() << (tr("Received datagram: \"%1\"")
                             .arg(datagram.data()));
    }
}

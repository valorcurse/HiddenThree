#ifndef SENDREQUEST_H
#define SENDREQUEST_H

#include <QObject>
#include <QUdpSocket>
#include <QTimer>
#include <QJsonObject>
#include <QJsonDocument>
#include <QString>
#include "appproperties.h"
#include "networkcommand.h"


class SendRequest : public QObject
{
    Q_OBJECT
public:
    explicit SendRequest(QObject *parent = 0);

    Q_INVOKABLE void broadcast(NetworkCommand *command);
    Q_INVOKABLE void sendCommand(QJsonObject message);

private slots:
    void broadcastDatagram();

private:
    QUdpSocket *udpSocket;
    NetworkCommand * commandToSend;

    QTimer *timer;
    int maxNumberOfShots,
    numberOfShots;
};

#endif // SENDREQUEST_H

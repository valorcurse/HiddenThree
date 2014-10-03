#ifndef SENDREQUEST_H
#define SENDREQUEST_H

#include <QObject>
#include <QUdpSocket>
#include <QTimer>

class SendRequest : public QObject
{
    Q_OBJECT
public:
    explicit SendRequest(QObject *parent = 0);
    Q_INVOKABLE void startBroadcasting();

private slots:
    void broadcastDatagram();

private:
    QUdpSocket *udpSocket;

    QTimer *timer;
    int maxNumberOfShots,
    numberOfShots;
};

#endif // SENDREQUEST_H

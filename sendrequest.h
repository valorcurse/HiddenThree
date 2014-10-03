#ifndef SENDREQUEST_H
#define SENDREQUEST_H

#include <QObject>

class SendRequest : public QObject
{
    Q_OBJECT
public:
    explicit SendRequest(QObject *parent = 0);

private slots:
    void startBroadcasting();
    void broadcastDatagram();

private:
    QUdpSocket *udpSocket;
    QTimer *timer;

};

#endif // SENDREQUEST_H

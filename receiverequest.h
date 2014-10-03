#ifndef RECEIVEREQUEST_H
#define RECEIVEREQUEST_H

#include <QObject>
#include <QUdpSocket>

class ReceiveRequest : public QObject
{
    Q_OBJECT
public:
    explicit ReceiveRequest(QObject *parent = 0);

private slots:
    void processPendingDatagrams();

private:
    QUdpSocket *udpSocket;
};

#endif // RECEIVEREQUEST_H

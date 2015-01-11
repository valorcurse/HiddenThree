#ifndef RECEIVEREQUEST_H
#define RECEIVEREQUEST_H

#include <QObject>
#include <QUdpSocket>
#include <QString>

class ReceiveRequest : public QObject {
    Q_OBJECT

public:
    explicit ReceiveRequest(QObject *parent = 0);

signals:
    void requestReceived(QString message, QString ip);

private slots:
    void processPendingDatagrams();

private:
    QUdpSocket *udpSocket;
    QString requestMessage;
};

#endif // RECEIVEREQUEST_H

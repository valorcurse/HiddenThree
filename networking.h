#ifndef NETWORKING_H
#define NETWORKING_H

#include <QObject>
 #include <QUdpSocket>

class Networking : public QObject {

    Q_OBJECT
//            Q_PROPERTY(QString author READ author WRITE setAuthor NOTIFY authorChanged)
//            Q_PROPERTY(QDateTime creationDate READ creationDate WRITE setCreationDate NOTIFY creationDateChanged)
public:
    Networking();
    virtual ~Networking();

private slots:
    void processPendingDatagrams();

private:
    QUdpSocket *udpSocket;
};

#endif // NETWORKING_H

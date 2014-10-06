#ifndef NETWORKCOMMAND_H
#define NETWORKCOMMAND_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include "appproperties.h"

class NetworkCommand : public QObject
{
    Q_OBJECT

private:
    QJsonObject jsonObject;

public:
    explicit NetworkCommand(QObject *parent = 0);

    typedef enum {
        FINDGAME,
        GAMEFOUND
    } Type;
    Q_ENUMS(Type)

    NetworkCommand(NetworkCommand::Type cmdType);


    QByteArray toJson();
};

#endif // NETWORKCOMMAND_H

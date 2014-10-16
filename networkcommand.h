#ifndef NETWORKCOMMAND_H
#define NETWORKCOMMAND_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include "appproperties.h"

class NetworkCommand : public QObject
{
    Q_OBJECT
    Q_PROPERTY(NetworkCommand::Type commandType READ commandType WRITE setCommandType NOTIFY typeChosen)


public:
    typedef enum {
        FINDGAME,
        GAMEFOUND
    } Type;
    Q_ENUMS(Type)

    explicit NetworkCommand(QObject *parent = 0);
    NetworkCommand(NetworkCommand::Type cmdType);

    void setCommandType(NetworkCommand::Type type);
    NetworkCommand::Type commandType();
    QByteArray toJson();

signals:
    void typeChosen(Type type);

private:
    QJsonObject jsonObject;
    NetworkCommand::Type m_commandType;
};

#endif // NETWORKCOMMAND_H

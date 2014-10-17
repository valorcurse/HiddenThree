#ifndef NETWORKCOMMAND_H
#define NETWORKCOMMAND_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include "appproperties.h"
#include "commanddata.h"

class NetworkCommand : public QObject
{
    Q_OBJECT
    Q_PROPERTY(NetworkCommand::Type commandType READ commandType WRITE setCommandType NOTIFY typeChosen)
    Q_PROPERTY(CommandData * commandData READ commandData WRITE setCommandData)

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

    void setCommandData(CommandData * data);
    CommandData * commandData() const;

    QByteArray toJson();

signals:
    void typeChosen(Type type);

private:
    QJsonObject jsonObject;
    NetworkCommand::Type m_commandType;
    CommandData * m_commandData;
};

#endif // NETWORKCOMMAND_H

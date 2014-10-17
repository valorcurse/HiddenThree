#include "networkcommand.h"

#include <QDebug>
#include <QUuid>

NetworkCommand::NetworkCommand(QObject *parent) :
    QObject(parent)
{
    jsonObject["uuid"] = AppProperties::instance()->uuid.toString();
}

NetworkCommand::NetworkCommand(Type cmdType) {
    jsonObject["uuid"] = AppProperties::instance()->uuid.toString();
    jsonObject["command"] = cmdType;
}

QByteArray NetworkCommand::toJson() {
    QJsonDocument jsonDoc(jsonObject);
    return jsonDoc.toJson();
}

void NetworkCommand::setCommandType(NetworkCommand::Type type) {
    jsonObject["command"] = type;
}

NetworkCommand::Type NetworkCommand::commandType() {
    return m_commandType;
}

void NetworkCommand::setCommandData(CommandData *data) {
    m_commandData = data;
}

CommandData * NetworkCommand::commandData() const {
    return m_commandData;
}

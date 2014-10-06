#include "networkcommand.h"

#include <QDebug>
#include <QUuid>

NetworkCommand::NetworkCommand(QObject *parent) :
    QObject(parent)
{
}

NetworkCommand::NetworkCommand(Type cmdType) {
    jsonObject["uuid"] = AppProperties::instance()->uuid.toString();
    jsonObject["command"] = cmdType;
}

QByteArray NetworkCommand::toJson() {
    QJsonDocument jsonDoc(jsonObject);
    return jsonDoc.toJson();
}

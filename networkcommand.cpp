#include "networkcommand.h"

#include <QDebug>
#include <QUuid>

NetworkCommand::NetworkCommand(QObject *parent) :
    QObject(parent)
{
//    QObject::connect(this, SIGNAL(dataChanged(CommandData *)),
//                         this, SLOT(updateJson(CommandData *)));

    jsonObject["uuid"] = AppProperties::instance()->uuid.toString();
}

//NetworkCommand::NetworkCommand(Type cmdType) {
//    jsonObject["uuid"] = AppProperties::instance()->uuid.toString();
//    jsonObject["command"] = cmdType;
//}

QByteArray NetworkCommand::toJson() {
    QJsonDocument jsonDoc(jsonObject);
    return jsonDoc.toJson();
}

//void NetworkCommand::setCommandType(NetworkCommand::Type type) {
//    jsonObject["command"] = type;
//}

//NetworkCommand::Type NetworkCommand::commandType() {
//    return m_commandType;
//}

void NetworkCommand::setCommandData(CommandData *data) {
    m_commandData = data;

//    emit dataChanged(data);
//    jsonObject["data"] = data->toJson();
}

CommandData * NetworkCommand::commandData() const {
    return m_commandData;
}

void NetworkCommand::updateJson() {
    jsonObject["commandData"] = commandData()->toJson();
}

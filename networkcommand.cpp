#include "networkcommand.h"

#include <QDebug>
#include <QUuid>

NetworkCommand::NetworkCommand(QObject *parent) :
    QObject(parent)
{
    jsonObject["uuid"] = AppProperties::instance()->uuid.toString();
}

QByteArray NetworkCommand::toJson() {
    QJsonDocument jsonDoc(jsonObject);
    return jsonDoc.toJson();
}

void NetworkCommand::setCommandData(CommandData * data) {
    m_commandData = data;
    m_commandData->setParent(this);
}

CommandData * NetworkCommand::commandData() const {
    return m_commandData;
}

void NetworkCommand::updateJson() {
    qDebug() << "Updating command data";
    jsonObject["commandData"] = commandData()->toJson();
}

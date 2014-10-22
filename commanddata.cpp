#include "commanddata.h"

CommandData::CommandData(QObject *parent) :
    QObject(parent)
{
}

FindGame::FindGame(QObject * parent)
 : CommandData(parent)
 {
 }

void FindGame::setGameName(QString name) {
    m_gameName = name;
    jsonObject["gameName"] = m_gameName;

    emit dataChanged(m_gameName);
}

QString FindGame::gameName() const {
    return m_gameName;
}

QJsonValue FindGame::toJson() {
    QJsonValue jsonValue(jsonObject);
    return jsonValue;
}

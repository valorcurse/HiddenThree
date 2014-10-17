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
    emit dataChanged(m_gameName);
    qDebug() << "name: " << gameName();
}

QString FindGame::gameName() const {
    return m_gameName;
}

QJsonValue FindGame::toJson() {
    QJsonObject obj;
    obj["gameName"] = gameName();
//    QJsonDocument jsonDoc(obj);
    QJsonValue jsonValue(obj);
    qDebug() << "name2:  "<< gameName();
    qDebug() << "obj: " << obj;
    qDebug() << "value: " << jsonValue.toString();
    return jsonValue;
}

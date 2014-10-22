#include "commanddata.h"

CommandData::CommandData(QObject *parent) :
    QObject(parent)
{
}

void CommandData::setCommandType(CommandType type) {
    jsonObject["command"] = type;
}

CommandData::CommandType CommandData::commandType() {
    return m_commandType;
}

// ##############################################################

FindGame::FindGame(QObject * parent)
 : CommandData(parent)
 {
    m_commandType = CommandType::FINDGAME;
 }

//void FindGame::setGameName(QString name) {
//    m_gameName = name;
//    jsonObject["gameName"] = m_gameName;

//    emit dataChanged(m_gameName);
//}

//QString FindGame::gameName() const {
//    return m_gameName;
//}

QJsonValue FindGame::toJson() {
    QJsonValue jsonValue(jsonObject);
    return jsonValue;
}

// ##############################################################

GameFound::GameFound(QObject * parent)
 : CommandData(parent)
 {
    m_commandType = CommandType::GAMEFOUND;
 }

void GameFound::setGameName(QString name) {
    m_gameName = name;
    jsonObject["gameName"] = m_gameName;

    emit dataChanged(m_gameName);
}

QString GameFound::gameName() const {
    return m_gameName;
}

QJsonValue GameFound::toJson() {
    QJsonValue jsonValue(jsonObject);
    return jsonValue;
}

// ##############################################################

JoinGame::JoinGame(QObject * parent)
 : CommandData(parent)
 {
    m_commandType = CommandType::JOINGAME;
 }

QJsonValue JoinGame::toJson() {
    QJsonValue jsonValue(jsonObject);
    return jsonValue;
}

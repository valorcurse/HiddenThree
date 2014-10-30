#include "commanddata.h"
#include "networkcommand.h"

CommandData::CommandData(QObject *parent) :
    QObject(parent)
{
}

void CommandData::setCommandType(CommandType type) {
    m_commandType = type;
    jsonObject["commandType"] = type;

    emit dataChanged();
}

CommandData::CommandType CommandData::commandType() {
    return m_commandType;
}

void CommandData::setParent(QObject * parent) {
    QObject::setParent(parent);

    QObject::connect(this, SIGNAL(dataChanged()),
                     parent, SLOT(updateJson()));
    emit dataChanged();
}

QJsonValue CommandData::toJson() {
    QJsonValue jsonValue(jsonObject);
    return jsonValue;
}

// ##############################################################

FindGame::FindGame(QObject * parent)
    : CommandData(parent)
{
    setCommandType(CommandType::FINDGAME);
}

// ##############################################################

GameFound::GameFound(QObject * parent)
    : CommandData(parent)
{
    setCommandType(CommandType::GAMEFOUND);
}

void GameFound::setGameName(QString name) {
    m_gameName = name;
    jsonObject["gameName"] = m_gameName;

    emit dataChanged();
}

QString GameFound::gameName() const {
    return m_gameName;
}

// ##############################################################

JoinGame::JoinGame(QObject * parent)
    : CommandData(parent)
{
    setCommandType(CommandType::JOINGAME);
}

// ##############################################################

GameJoined::GameJoined(QObject * parent)
    : CommandData(parent)
{
    setCommandType(CommandType::GAMEJOINED);
}

// ##############################################################

PlayCard::PlayCard(QObject * parent)
    : CommandData(parent)
{
    setCommandType(CommandType::PLAYCARD);
}

// ##############################################################

CardPlayed::CardPlayed(QObject * parent)
    : CommandData(parent)
{
    setCommandType(CommandType::CARDPLAYED);
}

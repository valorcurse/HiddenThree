#include "commanddata.h"
#include "networkcommand.h"

CommandData::CommandData(QObject *parent) :
    QObject(parent)
{
    if (parent != NULL)
    qDebug() << "parent: " << parent->metaObject()->className();

//    NetworkCommand *networkCommand = dynamic_cast<NetworkCommand *> (this->parent());
//    QObject::connect(this, SIGNAL(dataChanged()),
//                     parent, SLOT(updateJson()));
}

void CommandData::setCommandType(CommandType type) {
    m_commandType = type;
    jsonObject["commandType"] = type;

    //    emit networkCommand->dataChanged();

    qDebug() << "Emitting signal";
    emit dataChanged();
}

CommandData::CommandType CommandData::commandType() {
    return m_commandType;
}

void CommandData::setParent(QObject * parent) {
    QObject::setParent(parent);

    qDebug() << "setting parent: " << parent->metaObject()->className();

    QObject::connect(this, SIGNAL(dataChanged()),
                     parent, SLOT(updateJson()));
    emit dataChanged();
}

// ##############################################################

FindGame::FindGame(QObject * parent)
    : CommandData(parent)
{
    setCommandType(CommandType::FINDGAME);
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
    //    m_commandType = CommandType::GAMEFOUND;
    //    jsonObject["commandType"] = m_commandType;
    setCommandType(CommandType::GAMEFOUND);
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
    setCommandType(CommandType::JOINGAME);
}

QJsonValue JoinGame::toJson() {
    QJsonValue jsonValue(jsonObject);
    return jsonValue;
}

// ##############################################################

GameJoined::GameJoined(QObject * parent)
    : CommandData(parent)
{
    setCommandType(CommandType::GAMEJOINED);
}

QJsonValue GameJoined::toJson() {
    QJsonValue jsonValue(jsonObject);
    return jsonValue;
}

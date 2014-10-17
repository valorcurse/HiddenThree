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
}

QString FindGame::gameName() const {
    return m_gameName;
}

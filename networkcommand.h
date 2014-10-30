#ifndef NETWORKCOMMAND_H
#define NETWORKCOMMAND_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include "appproperties.h"
#include "commanddata.h"

class NetworkCommand : public QObject
{
    Q_OBJECT
    Q_PROPERTY(CommandData * commandData READ commandData WRITE setCommandData)

public:
    explicit NetworkCommand(QObject *parent = 0);

    void setCommandData(CommandData * data);
    CommandData * commandData() const;

    QByteArray toJson();

public slots:
    void updateJson();

private:
    QJsonObject jsonObject;
    CommandData * m_commandData;
};

#endif // NETWORKCOMMAND_H

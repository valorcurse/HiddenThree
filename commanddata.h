#ifndef COMMANDDATA_H
#define COMMANDDATA_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>

class CommandData : public QObject
{
    Q_OBJECT

    friend class NetworkCommand;

public:
    explicit CommandData(QObject *parent = 0);
    virtual QJsonValue toJson() = 0;
};

class FindGame : public CommandData {
    Q_OBJECT
    Q_PROPERTY(QString gameName READ gameName WRITE setGameName NOTIFY dataChanged)

public:
    FindGame(QObject * parent = 0);

    void setGameName(QString name);
    QString gameName() const;

    virtual QJsonValue toJson();

signals:
    void dataChanged(QString data);

private:
    QString m_gameName;
    QJsonObject jsonObject;
};

#endif // COMMANDDATA_H

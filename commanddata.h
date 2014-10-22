#ifndef COMMANDDATA_H
#define COMMANDDATA_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>

class CommandData : public QObject {
    Q_OBJECT

    Q_PROPERTY(CommandType commandType READ commandType WRITE setCommandType)

    friend class NetworkCommand;

public:
    typedef enum {
        FINDGAME,
        GAMEFOUND,
        JOINGAME
    } CommandType;
    Q_ENUMS(CommandType)

    explicit CommandData(QObject *parent = 0);

    virtual QJsonValue toJson() = 0;
    void setCommandType(CommandType type);
    CommandType commandType();

protected:
    QJsonObject jsonObject;
    CommandType m_commandType;
};

class FindGame : public CommandData {
    Q_OBJECT
//    Q_PROPERTY(QString gameName READ gameName WRITE setGameName NOTIFY dataChanged)

public:
    FindGame(QObject * parent = 0);

//    void setGameName(QString name);
//    QString gameName() const;

    virtual QJsonValue toJson();

signals:
//    void dataChanged(QString data);

private:
    QString m_gameName;
//    QJsonObject jsonObject;
};

class GameFound : public CommandData {
    Q_OBJECT
    Q_PROPERTY(QString gameName READ gameName WRITE setGameName NOTIFY dataChanged)

public:
    GameFound(QObject * parent = 0);

    void setGameName(QString name);
    QString gameName() const;

    virtual QJsonValue toJson();

signals:
    void dataChanged(QString data);

private:
    QString m_gameName;
};

class JoinGame: public CommandData {
    Q_OBJECT

public:
    JoinGame(QObject * parent = 0);

    virtual QJsonValue toJson();
};


#endif // COMMANDDATA_H

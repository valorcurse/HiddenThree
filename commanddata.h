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
        JOINGAME,
        GAMEJOINED,
        PLAYCARD,
        CARDPLAYED
    } CommandType;
    Q_ENUMS(CommandType)

    explicit CommandData(QObject *parent = 0);

    QJsonValue toJson();

    void setCommandType(CommandType type);
    CommandType commandType();

    void setParent(QObject *);

protected:
    QJsonObject jsonObject;
    CommandType m_commandType;

signals:
    void dataChanged();
};

// ##############################################################

class FindGame : public CommandData {
    Q_OBJECT

public:
    FindGame(QObject * parent = 0);

private:
    QString m_gameName;
};

// ##############################################################

class GameFound : public CommandData {
    Q_OBJECT
    Q_PROPERTY(QString gameName READ gameName WRITE setGameName)

public:
    GameFound(QObject * parent = 0);

    void setGameName(QString name);
    QString gameName() const;

private:
    QString m_gameName;
};

// ##############################################################

class JoinGame: public CommandData {
    Q_OBJECT

public:
    JoinGame(QObject * parent = 0);
};

// ##############################################################

class GameJoined: public CommandData {
    Q_OBJECT

public:
    GameJoined(QObject * parent = 0);
};

// ##############################################################

class PlayCard: public CommandData {
    Q_OBJECT
    Q_PROPERTY(QString number READ number WRITE setNumber)
    Q_PROPERTY(QString type READ type WRITE setType)
    Q_PROPERTY(PlayAction action READ action WRITE setAction)

public:
    PlayCard(QObject * parent = 0);

    typedef enum {
        TOP,
        PLAY
    } PlayAction;
    Q_ENUMS(PlayAction)

    void setNumber(QString number);
    QString number() const;

    void setType(QString type);
    QString type() const;

    void setAction(PlayAction action);
    PlayAction action() const;

private:
    QString m_number, m_type;
    PlayAction m_action;
};

// ##############################################################

class CardPlayed: public CommandData {
    Q_OBJECT

public:
    CardPlayed(QObject * parent = 0);
};


#endif // COMMANDDATA_H

#ifndef COMMANDDATA_H
#define COMMANDDATA_H

#include <QObject>

class CommandData : public QObject
{
    Q_OBJECT

    friend class NetworkCommand;

public:
    explicit CommandData(QObject *parent = 0);

signals:

public slots:

};

class FindGame : public CommandData {
    Q_OBJECT
    Q_PROPERTY(QString gameName READ gameName WRITE setGameName)

public:
    FindGame(QObject * parent = 0);

    void setGameName(QString name);
    QString gameName() const;

private:
    QString m_gameName;
};

#endif // COMMANDDATA_H

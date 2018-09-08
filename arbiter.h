#include <QObject>
#include <QList>

struct NewPlayState {
    Q_GADGET

    Q_PROPERTY(bool burnStack MEMBER burnStack)
    Q_PROPERTY(int turnIncrement MEMBER turnIncrement)

public:
    NewPlayState() {}

    NewPlayState(bool clearStack, int turnIncrement) :
        burnStack(clearStack), turnIncrement(turnIncrement) {}

    bool burnStack;
    int turnIncrement;

};
Q_DECLARE_METATYPE(NewPlayState)

class Arbiter : public QObject {
    Q_OBJECT

public:
    Q_INVOKABLE NewPlayState newPlayState(QList<QString> stack, QList<QString> proposedCards);
    Q_INVOKABLE QList<bool> playIsPossible(QList<QString> stack, QList<QString> proposedCards);
    Q_INVOKABLE bool playIsAllowed(QList<QString> stack, QString proposedCard);

private:
    int translateCard(QString card);
};


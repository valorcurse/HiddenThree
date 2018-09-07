#include <QObject>
#include <QList>

struct NewPlayState {
    Q_GADGET

    Q_PROPERTY(bool getClearStack MEMBER clearStack)
    Q_PROPERTY(int getTurnIncrement MEMBER turnIncrement)

public:
    NewPlayState() {}

    NewPlayState(bool clearStack, int turnIncrement) :
        clearStack(clearStack), turnIncrement(turnIncrement) {}

    bool clearStack;
    int turnIncrement;

};

class Arbiter : public QObject {
    Q_OBJECT

public:
    Q_INVOKABLE bool playIsAllowed(QList<QString> stack, QString proposedCard);
    Q_INVOKABLE NewPlayState newPlayState(QList<QString> stack, QList<QString> proposedCards);
    Q_INVOKABLE QList<bool> playIsPossible(QList<QString> stack, QList<QString> proposedCards);

private:
    int translateCard(QString card);
};


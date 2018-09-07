#include <QObject>
#include <QList>

struct NewPlayState {
    Q_GADGET

    Q_PROPERTY(bool clearStack MEMBER m_clearStack)
    Q_PROPERTY(int turnIncrement MEMBER m_turnIncrement)

public:
    NewPlayState(bool clearStack, int turnIncrement) :
        m_clearStack(clearStack), m_turnIncrement(turnIncrement) {}
private:
    bool m_clearStack;
    int m_turnIncrement;

};

class Arbiter : public QObject {
    Q_OBJECT

public:
    Q_INVOKABLE bool playIsAllowed(QList<QString> stack, QString proposedCard);
    Q_INVOKABLE NewPlayState newPlayState(QList<QString> stack, QList<QString> proposedCards);
    Q_INVOKABLE QList<bool> playIsPossible(QList<QString> stack, QList<QString> proposedCards);

private:
};


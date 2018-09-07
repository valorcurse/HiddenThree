#include <QList>

struct NewPlayState {
    bool clearStack;
    int turnIncrement;
};

class Arbiter {
    protected:
        bool playIsAllowed(QList<QString> stack, QString proposedCard);
    public:
        struct NewPlayState newPlayState(QList<QString> stack, QList<QString> proposedCards);
        QList<bool> playIsPossible(QList<QString> stack, QList<QString> proposedCards);
    private:
};


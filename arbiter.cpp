#include "arbiter.h"

bool Arbiter::playIsAllowed(QList<QString> stack, QString proposedCard){
    return true;
}

struct NewPlayState Arbiter::newPlayState(QList<QString> stack, QList<QString> proposedCards){
    struct NewPlayState state;
    state.clearStack = false;
    state.turnIncrement = 1;
    return state;
}


QList<bool> Arbiter::playIsPossible(QList<QString> stack, QList<QString> proposedCards){
    QList<bool> retList;
    retList.reserve(proposedCards.size());
    for (QString s : proposedCards){
        retList.append(playIsAllowed(stack, s));
    }
    return retList;
}

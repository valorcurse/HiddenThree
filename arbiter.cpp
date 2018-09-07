#include "arbiter.h"

bool Arbiter::playIsAllowed(QList<QString> stack, QString proposedCard){
    return true;
}

NewPlayState Arbiter::newPlayState(QList<QString> stack, QList<QString> proposedCards){
    NewPlayState state(false, 1);
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

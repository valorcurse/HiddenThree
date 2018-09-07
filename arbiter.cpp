#include "arbiter.h"
#include <QMap>

static QMap<QString, int> cardMap = {
    {"2", 0},
    {"3", 1},
    {"4", 2},
    {"5", 3},
    {"6", 4},
    {"7", 5},
    {"8", 6},
    {"9", 7},
    {"10", 8},
    {"j", 9},
    {"q", 10},
    {"k", 11},
    {"a", 12}
};


bool Arbiter::playIsAllowed(QList<QString> stack, QString proposedCard){
    if (stack.isEmpty() || proposedCard == "2" || proposedCard == "3" || proposedCard == "10") return true;

    int topCard = 0;
    for (QString card : stack){
        topCard = cardMap[card];
        if (topCard != 1) break;
    }
    if (topCard == 1) return true;
    int pCard = cardMap[proposedCard];
    if (topCard == 5){
        return pCard <= 5;
    } else {
        return pCard >= topCard;
    }
}

// In this function two checks are possible:
// * Are the cards equal to eachother?
// * Is this play even allowed?
// Neither of these checks is done because we assume that the functions calling this function are sane.
NewPlayState Arbiter::newPlayState(QList<QString> stack, QList<QString> proposedCards){
    NewPlayState state;
    int newCard = cardMap[proposedCards.first()];
    if (newCard == 8) {
        state.clearStack = true;
        state.turnIncrement = 0;
        return state;
    }
    // Check for a set of four
    int cardSetCount = proposedCards.size();
    for (QString card : stack){
        if (cardMap[card] == newCard){
            cardSetCount++;
        } else {
            break;
        }
    }
    if (cardSetCount >= 4){
        state.clearStack = true;
        state.turnIncrement = 0;
        return state;
    }
    state.clearStack = false;
    if (newCard == 6){
        state.turnIncrement = 2;
    } else {
        state.turnIncrement = 1;
    }

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

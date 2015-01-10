import QtQuick 2.0

Item {
    property var area
    property alias cards: cards

    function indexOf(item) {
        for (var i = 0; i < cards.count; i++) {
            if (item === cards.get(i).object) {
                return i;
            }
        }

        return undefined;
    }

    function getCard(number, type) {
        for (var i = 0; i < cards.count; i++) {
            if (number === cards.get(i).object.cardObject.number &&
                    type === cards.get(i).object.cardObject.type) {
                return i;
            }
        }

        return -1;
    }

    ListModel {
        id: cards
    }
}

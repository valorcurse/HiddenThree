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

    ListModel {
        id: cards
    }
}

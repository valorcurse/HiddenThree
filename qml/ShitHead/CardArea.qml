import QtQuick 2.0

Item {
    //    property var cards: []
    property var area
    property alias cards: cards
        property int cardCount: 0
    //    onCardsChanged: {
    //        console.log("Card added");
    //    }

    ListModel {
        id: cards

        onRowsInserted: {
            console.log("Card added");
            cardCount++;
        }

        onRowsRemoved: {
            console.log("Card removed");
            cardCount--;
        }

        //        onCountChanged: {
        //        }
    }

}

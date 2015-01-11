import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Controls 1.2

import "../Components"

Item {
    Game {
        id: game
        //        state: "SettingUp"

    }

//    Player {
//        id: myself
//        gameOwner: true
//        playerID: game.players.length

//        Component.onCompleted: {
//            game.players.push(myself);
//        }
//    }

    Loader {
        id: newGameLoader
        source: "CreateOrSearchMenu.qml"

        anchors {
            fill: parent
        }
    }
}

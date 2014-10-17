import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import ".."

Item {
    Game {
        id: game
    }

    Loader {
        id: newGameLoader
        source: "CreateOrSearchMenu.qml"

        anchors {
            fill: parent
        }
    }
}

import QtQuick 2.0
import QtQuick.Controls 1.2
import "ShitHead.js" as Engine

Rectangle {
    id: app

    property int screenWidth: 540
    property int screenHeight: 720

    width: screenWidth; height: screenHeight

    SystemPalette { id: activePalette }

    Loader {
        id: pageLoader
        z: 1
        source: "MenuArea.qml"

        anchors {
            fill: parent
            //            left: parent.left
            //            right: parent.right
            //            top: parent.top
            //            bottom: toolBar.top
        }

        onLoaded: {
            areaBinder.target = pageLoader.item
        }
    }

    Binding {
        id: areaBinder

        property: "state"
        value: "dealCards"
    }

    Image {
        id: background
        anchors.fill: parent
        z: 0
        source: "textures/woodBackground.png"
        fillMode: Image.PreserveAspectCrop
    }

    //    Rectangle {
    //        id: toolBar
    //        z: 2
    //        width: parent.width; height: 30
    //        color: activePalette.window
    //        anchors.bottom: app.bottom

    //        Button {
    //            anchors { left: parent.left; verticalCenter: parent.verticalCenter }
    //            text: "New Game"
    //            onClicked: {
    //                pageLoader.source = "GameArea.qml"
    //            }
    //        }
    //    }
}

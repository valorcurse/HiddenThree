import QtQuick 2.0

Item {
    id: block
    property string imageSource

    Image {
        id: img
        anchors.fill: parent
        anchors.rightMargin: 5;
        anchors.bottomMargin: 5;

        source: imageSource
    }
}

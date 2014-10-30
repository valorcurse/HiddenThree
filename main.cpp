#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QScreen>
#include <QUuid>
#include <QQmlEngine>
#include <QtQml>

#include <iostream>
#include "appproperties.h"
#include "receiverequest.h"
#include "sendrequest.h"
#include "networkcommand.h"
#include "commanddata.h"

int main(int argc, char *argv[]) {

    qmlRegisterSingletonType<AppProperties>("AppProperties", 1, 0, "AppProperties",
                                                   AppProperties::instance);

    qmlRegisterType<ReceiveRequest>("MultiplayerNetwork", 1, 0, "ReceiveRequest");
    qmlRegisterType<SendRequest>("MultiplayerNetwork", 1, 0, "SendRequest");
    qmlRegisterType<NetworkCommand>("MultiplayerNetwork", 1, 0, "NetworkCommand");
    qmlRegisterUncreatableType<CommandData>("MultiplayerNetwork", 1, 0, "CommandData", "");
    qmlRegisterType<FindGame>("MultiplayerNetwork", 1, 0, "FindGame");
    qmlRegisterType<GameFound>("MultiplayerNetwork", 1, 0, "GameFound");
    qmlRegisterType<JoinGame>("MultiplayerNetwork", 1, 0, "JoinGame");
    qmlRegisterType<GameJoined>("MultiplayerNetwork", 1, 0, "GameJoined");

    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/ShitHead/main.qml"));

    if (app.screens().count() > 1) {
        QScreen * firstScreen = app.screens().first();
//        viewer.setGeometry(firstScreen->geometry());
        viewer.setFramePosition(firstScreen->geometry().bottomRight());
    }

//        viewer.showFullScreen();
    viewer.showExpanded();

    return app.exec();
}

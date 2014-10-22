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
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/ShitHead/main.qml"));

    qmlRegisterType<ReceiveRequest>("ReceiveRequest", 1, 0, "ReceiveRequest");
    qmlRegisterType<SendRequest>("SendRequest", 1, 0, "SendRequest");
    qmlRegisterType<NetworkCommand>("NetworkCommand", 1, 0, "NetworkCommand");
    qmlRegisterUncreatableType<CommandData>("CommandData", 1, 0, "CommandData", "");
    qmlRegisterSingletonType<AppProperties>("AppProperties", 1, 0, "AppProperties",
                                                   AppProperties::instance);
    qmlRegisterType<FindGame>("CommandData", 1, 0, "FindGame");
    qmlRegisterType<GameFound>("CommandData", 1, 0, "GameFound");
    qmlRegisterType<JoinGame>("CommandData", 1, 0, "JoinGame");

    if (app.screens().count() > 1) {
        QScreen * firstScreen = app.screens().first();
//        viewer.setGeometry(firstScreen->geometry());
        viewer.setFramePosition(firstScreen->geometry().bottomRight());
    }

//        viewer.showFullScreen();
    viewer.showExpanded();

    return app.exec();
}

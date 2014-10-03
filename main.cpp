#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QScreen>
#include <QQmlEngine>
#include <QtQml>

#include <iostream>
#include "receiverequest.h"
#include "sendrequest.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/ShitHead/main.qml"));

    qmlRegisterType<ReceiveRequest>("ReceiveRequest", 1, 0, "ReceiveRequest");
    qmlRegisterType<SendRequest>("SendRequest", 1, 0, "SendRequest");

//    if (app.screens().count() > 1) {
//        QScreen * firstScreen = app.screens().first();
//        viewer.setGeometry(firstScreen->geometry());
//    }

//        viewer.showFullScreen();
    viewer.showExpanded();

    return app.exec();
}

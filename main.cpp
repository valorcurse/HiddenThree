#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
//#include <QDesktopWidget>
//#include <QApplication>
#include <QScreen>

#include <iostream>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/ShitHead/main.qml"));

    std::cout << "Number of screens: " << app.screens().count() << std::endl;

    if (app.screens().count() > 1) {
        QScreen * lastScreen = app.screens().first();
        viewer.setGeometry(lastScreen->geometry());
    }

//        viewer.showFullScreen();
    viewer.showExpanded();

    return app.exec();
}

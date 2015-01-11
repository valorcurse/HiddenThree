# Add more folders to ship with the application, here
rootFolder.source = qml/ShitHead
rootFolder.target = qml

componentsFolder.source = qml/ShitHead/Components
componentsFolder.target = qml

uiFolder.source = qml/ShitHead/UI
uiFolder.target = qml

jsFolder.source = qml/ShitHead/JS
jsFolder.target = js

DEPLOYMENTFOLDERS = rootFolder componentsFolder uiFolder jsFolder

# Additional import path used to resolve QML modules in Creator's code model
#QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    networking.cpp \
    sendrequest.cpp \
    receiverequest.cpp \
    appproperties.cpp \
    networkcommand.cpp \
    commanddata.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

#include(qml/ShitHead/Components)

#OTHER_FILES += \
#    qml/ShitHead/GameProperties.js \
#    qml/ShitHead/newgame/CreateOrSearchMenu.qml

HEADERS += \
    networking.h \
    sendrequest.h \
    receiverequest.h \
    appproperties.h \
    networkcommand.h \
    commanddata.h

DEFINES += QMLJSDEBUGGER

CONFIG += c++11

QT += core
#CONFIG += console

OTHER_FILES += \
    qml/ShitHead/UI/PlayerCards.qml

# Add more folders to ship with the application, here
folder_01.source = qml/ShitHead
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
#QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    networking.cpp \
    sendrequest.cpp \
    receiverequest.cpp \
    appproperties.cpp \
    networkcommand.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qml/ShitHead/GameProperties.js \
    NewGameArea.qml

HEADERS += \
    networking.h \
    sendrequest.h \
    receiverequest.h \
    appproperties.h \
    networkcommand.h

DEFINES += QMLJSDEBUGGER

CONFIG += c++11

#QT += widgets
#CONFIG += console

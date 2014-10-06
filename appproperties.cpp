#include "appproperties.h"

AppProperties::AppProperties(QObject *parent) :
    QObject(parent)
{
}

QObject * AppProperties::instance(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

        if (!s_instance)
            s_instance = new AppProperties;
        return s_instance;
}

AppProperties * AppProperties::instance() {
    if (!s_instance)
        s_instance = new AppProperties;
    return s_instance;
}

QUuid AppProperties::getUuid() {
    return uuid;
}

AppProperties *AppProperties::s_instance = 0;

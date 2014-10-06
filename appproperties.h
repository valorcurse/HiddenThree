#ifndef APPPROPERTIES_H
#define APPPROPERTIES_H

#include <QUuid>
#include <QObject>
#include <QQmlEngine>

class AppProperties : public QObject {
    Q_OBJECT
    Q_PROPERTY (QUuid getUuid READ getUuid)

public:
    explicit AppProperties(QObject *parent = 0);

    static AppProperties * s_instance;

    const QUuid uuid = QUuid::createUuid();

    static QObject * instance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static AppProperties * instance();
    QUuid getUuid();
//    static AppProperties *instance();
};

//static QObject * instance(QQmlEngine *engine, QJSEngine *scriptEngine) {
//    Q_UNUSED(engine)
//    Q_UNUSED(scriptEngine)

//    AppProperties *example = new AppProperties();
//    return example;
//}

#endif // APPPROPERTIES_H

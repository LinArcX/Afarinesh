#ifndef DISPATCHER_H
#define DISPATCHER_H

#include <QGuiApplication>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "modules/core/dispatcher/dispatcherMacro.h"

class Dispatcher : public QObject {
    Q_OBJECT

public:
    Dispatcher(QGuiApplication&, bool& isRTL, QObject* parent = nullptr);
    Dispatcher(QObject* parent = nullptr);

    void registerTypes();
    void execRunTimeQML();

    Q_INVOKABLE void clearCache();

    static Dispatcher* getInstance()
    {
        static Dispatcher* instance;
        if (!instance)
            instance = new Dispatcher();
        return instance;
    }

    static QQmlApplicationEngine* getEngine()
    {
        static QQmlApplicationEngine* engine;
        if (!engine) {
            engine = new QQmlApplicationEngine();
        }
        return engine;
    }

    static QQmlContext* getContext()
    {
        static QQmlContext* context;
        if (!context)
            context = getEngine()->rootContext();
        return context;
    }

private:
    QQmlApplicationEngine* mEngine;
    QQmlContext* mContext;

signals:
    void cacheCleared();
};

#endif // DISPATCHER_H

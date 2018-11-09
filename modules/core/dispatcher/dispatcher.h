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
    Dispatcher(QGuiApplication&, QObject* parent = nullptr);
    Dispatcher(QObject* parent = nullptr);

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

    void registerTypes();

private:
};

#endif // DISPATCHER_H

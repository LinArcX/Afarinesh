#include "dispatcher.h"
#include "modules/pages/myClass/MyClass.h"

#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QSettings>

Dispatcher::Dispatcher(QGuiApplication& mApp, QObject* parent)
    : QObject(parent)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QQuickStyle::setStyle("Imagine");

    // Load Splash Screen
    QQmlApplicationEngine* mEngine = getEngine();

    registerTypes();

    mEngine->load(QUrl(QLatin1String(MAIN_QML)));
    QQmlContext* mContext = getContext();

    mContext->setContextProperty(DISPATCHER, this);
    mContext->setContextProperty(APP, &mApp);
}

void Dispatcher::registerTypes()
{
    qmlRegisterType<MyClass>("MyClass", 1, 0, "MyClass");
}

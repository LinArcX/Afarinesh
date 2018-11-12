#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "dispatcher.h"
#include "modules/pages/generator/presenter/generator.h"
#include "util/cpp/QtUtil.h"

Dispatcher::Dispatcher(QGuiApplication& mApp, QObject* parent)
    : QObject(parent)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QQuickStyle::setStyle("Universal");

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
    qmlRegisterType<Generator>("Generator", 1, 0, "Generator");
    qmlRegisterType<QtUtil>("QtUtil", 1, 0, "QtUtil");
}

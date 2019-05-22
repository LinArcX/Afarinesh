#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "dispatcher.h"
#include "modules/pages/addProject/presenter/addProject.h"
#include "modules/pages/launcher/presenter/launcher.h"

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
    qmlRegisterType<AddProject>("AddProjectClass", 1, 0, "AddProjectClass");
    qmlRegisterType<Launcher>("LauncherClass", 1, 0, "LauncherClass");
}

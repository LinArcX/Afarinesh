#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "dispatcher.h"
#include "modules/pages/addProject/presenter/addProject.h"
#include "modules/pages/launcher/presenter/launcher.h"
#include "modules/pages/listProjects/presenter/listProjects.h"
#include "modules/pages/settings/presenter/settings.h"

Dispatcher::Dispatcher(QGuiApplication& mApp, QObject* parent)
    : QObject(parent)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    Settings& settings = *new Settings();
    settings.loadAppStyle();
    settings.loadFontFamily();
    settings.loadFontSize();

    registerTypes();

    QQmlApplicationEngine* mEngine = getEngine();

    mEngine->load(QUrl(QLatin1String(MAIN_QML)));
    QQmlContext* mContext = getContext();

    mContext->setContextProperty(DISPATCHER, this);
    mContext->setContextProperty(APP, &mApp);
}

void Dispatcher::registerTypes()
{
    qmlRegisterType<AddProject>("AddProjectClass", 1, 0, "AddProjectClass");
    qmlRegisterType<ListProjects>("ListProjectsClass", 1, 0, "ListProjectsClass");
    qmlRegisterType<Launcher>("LauncherClass", 1, 0, "LauncherClass");
    qmlRegisterType<Settings>("SettingsClass", 1, 0, "SettingsClass");
}

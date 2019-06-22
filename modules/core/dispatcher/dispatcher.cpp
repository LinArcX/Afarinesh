#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "dispatcher.h"
#include "modules/pages/addProject/presenter/addProject.h"
#include "modules/pages/launcher/presenter/launcher.h"
#include "modules/pages/listProjects/presenter/listProjects.h"
#include "modules/pages/settings/presenter/settings.h"

#ifdef QT_DEBUG
#include "runtimeqml.h"
#else
#endif

Dispatcher::Dispatcher(QGuiApplication& app, bool& isRTL, QObject* parent)
    : QObject(parent)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    app.setOrganizationName("linarcx");
    app.setOrganizationDomain("io.github.com");
    app.setApplicationName("Trinity");

    registerTypes();

    getContext()->setContextProperty(IS_RTL, isRTL);
    getContext()->setContextProperty(DISPATCHER, this);
    getContext()->setContextProperty(APP, &app);
    getContext()->setContextProperty(ENGINE, getEngine());

#ifdef QT_DEBUG
    getContext()->setContextProperty("DEBUG_MODE", QVariant(true));
    getEngine()->load(QUrl(QLatin1String(MAIN_QML)));
#else
    getContext()->setContextProperty("RELEASE_MODE", QVariant(true));
    execRunTimeQML();
#endif
}

Dispatcher::~Dispatcher()
{
}

void Dispatcher::clearCache()
{
    getEngine()->trimComponentCache();
    getEngine()->clearComponentCache();
    getEngine()->trimComponentCache();
    emit cacheCleared();
}

void Dispatcher::registerTypes()
{
    qmlRegisterType<AddProject>("AddProjectClass", 1, 0, "AddProjectClass");
    qmlRegisterType<ListProjects>("ListProjectsClass", 1, 0, "ListProjectsClass");
    qmlRegisterType<Launcher>("LauncherClass", 1, 0, "LauncherClass");
    qmlRegisterType<Settings>("SettingsClass", 1, 0, "SettingsClass");
}

void Dispatcher::execRunTimeQML()
{
    // QRC_RUNTIME_SOURCE_PATH is defined in the .pro/.qbs of this example to $$PWD
    // In other projects where runtimeqml folder is on the same level of the .pro, you can use QRC_SOURCE_PATH (defined in runtimeqml.pri/qbs)
    RuntimeQML* rt = new RuntimeQML(getEngine(), QRC_RUNTIME_SOURCE_PATH "/qml.qrc");

    //rt->noDebug();
    //rt->addSuffix("conf");
    //rt->ignorePrefix("/test");
    //rt->ignoreFile("Page2.qml");
    rt->setAutoReload(true);
    rt->setCloseAllOnReload(false);
    //    rt->setMainQmlFilename("modules/pages/launcher/view/main.qml"); // Default is "main.qml"
    getContext()->setContextProperty("RuntimeQML", rt);
    //engine.load(QUrl(QLatin1String("qrc:/main.qml"))); // Replaced by rt->reload()
    rt->reload();
}

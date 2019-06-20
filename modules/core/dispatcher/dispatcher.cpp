#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "dispatcher.h"
#include "modules/pages/addProject/presenter/addProject.h"
#include "modules/pages/launcher/presenter/launcher.h"
#include "modules/pages/listProjects/presenter/listProjects.h"
#include "modules/pages/settings/presenter/settings.h"

#include "runtimeqml.h"

Dispatcher::Dispatcher(QGuiApplication& mApp, bool& isRTL, QObject* parent)
    : QObject(parent)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    mApp.setOrganizationName("linarcx");
    mApp.setOrganizationDomain("io.github.com");
    mApp.setApplicationName("Trinity");

    registerTypes();

    mEngine = getEngine();
    mContext = getContext();
    mContext->setContextProperty(IS_RTL, isRTL);
    mContext->setContextProperty(DISPATCHER, this);
    mContext->setContextProperty(APP, &mApp);
    mContext->setContextProperty(ENGINE, mEngine);

    execRunTimeQML();
    //    mEngine->load(QUrl(QLatin1String(MAIN_QML)));
}

void Dispatcher::clearCache()
{
    mEngine->trimComponentCache();
    mEngine->clearComponentCache();
    mEngine->trimComponentCache();
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
    RuntimeQML* rt = new RuntimeQML(mEngine, QRC_RUNTIME_SOURCE_PATH "/qml.qrc");

    //rt->noDebug();
    //rt->addSuffix("conf");
    //rt->ignorePrefix("/test");
    //rt->ignoreFile("Page2.qml");
    rt->setAutoReload(true);
    rt->setCloseAllOnReload(false);
    //    rt->setMainQmlFilename("modules/pages/launcher/view/main.qml"); // Default is "main.qml"
    mContext->setContextProperty("RuntimeQML", rt);
    //engine.load(QUrl(QLatin1String("qrc:/main.qml"))); // Replaced by rt->reload()
    rt->reload();
}

//    qputenv("QML_DISABLE_DISK_CACHE", "true");

#include "modules/core/dispatcher/dispatcher.h"
#include <QGuiApplication>

int main(int argc, char* argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    app.setOrganizationName("linarcx");
    app.setOrganizationDomain("io.github.com");
    app.setApplicationName("Trinity");

    Dispatcher dispatcher(app);
    return app.exec();
}

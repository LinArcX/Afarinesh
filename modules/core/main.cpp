#include <QApplication>

#include "modules/core/dispatcher/dispatcher.h"

int main(int argc, char* argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    Dispatcher dispatcher(app);
    return app.exec();
}
#include "modules/core/dispatcher/dispatcher.h"
#include "modules/pages/settings/presenter/settings.h"

#include <QGuiApplication>
#include <QTranslator>

int main(int argc, char* argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QTranslator appTranslator;
    QTranslator qtTranslator;

    Settings settings;
    settings.loadAppStyle();
    settings.loadFontFamily();
    settings.loadFontSize();
    bool isRTL = settings.loadLanguage(app, appTranslator, qtTranslator);

    Dispatcher dispatcher(app, isRTL);
    return app.exec();
}

#include <QApplication>
#include <poppler/qt5/poppler-qt5.h>

#include "modules/core/dispatcher/dispatcher.h"

int main(int argc, char* argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    QString filename;
    Poppler::Document* document = Poppler::Document::load(filename);
    if (!document || document->isLocked()) {
        // ... error message ....
        delete document;
    }

    Dispatcher dispatcher(app);
    return app.exec();
}

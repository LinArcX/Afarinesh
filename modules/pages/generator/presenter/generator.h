#ifndef GENERATOR_H
#define GENERATOR_H

#include <QObject>
#include <QVariant>

#include "util/cpp/RegexUtil.h"

class Generator : public QObject {
    Q_OBJECT

private:
public:
    explicit Generator(QObject* parent = nullptr);

    //    enum TemplateProp {
    //        NAME = 'name',
    //        AUTHOR,
    //        ICON,
    //        COMMENT
    //    };

    Q_INVOKABLE void isDirExists(QVariant rawDir);
    Q_INVOKABLE void listTemplates(QVariant path);
    Q_INVOKABLE void getTemplateInfo(QVariant rawDir);
    Q_INVOKABLE void generate(QVariant rawAlternative, QVariant rawPath, QVariant rawFileName);

signals:
    void fileGenerated(QVariant file);
    void templatesReady(QStringList templates);
    void templateInfoReady(QStringList templateInfo);
    void configFileExists(bool isExists);
};

#endif // GENERATOR_H

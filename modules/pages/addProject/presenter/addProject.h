#ifndef ADDPROJECT_H
#define ADDPROJECT_H

#include <QObject>
#include <QProcess>
#include <QVariant>

#include "util/cpp/RegexUtil.h"

class AddProject : public QObject {
    Q_OBJECT

private:
public:
    explicit AddProject(QObject* parent = nullptr);

    QProcess* pListAppVars;
    //    void returnAppVars();

    Q_INVOKABLE void generateProject(QVariant templateName, QVariant projectName, QVariant projectPath, QVariantMap vars);
    Q_INVOKABLE void getVariables(QVariant templateName);

signals:
    void varsReady(QStringList vars);
    void projectGenerated();

private:
    QMap<QString, QStringList>* patternBothInFileNames;
    QMap<QString, QStringList>* patternBothInsideFiles;
    QMap<QString, QStringList>* patternInFileNames;
    QMap<QString, QStringList>* patternInsideFiles;
};

#endif // ADDPROJECT_H

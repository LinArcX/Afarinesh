#ifndef LISTPROJECTS_H
#define LISTPROJECTS_H

#include <QObject>
#include <QProcess>
#include <QVariant>

#include "util/cpp/RegexUtil.h"

class ListProjects : public QObject {
    Q_OBJECT

public:
    explicit ListProjects(QObject* parent = nullptr);
    Q_INVOKABLE void getAllProjects(QVariant templateName);

signals:
    void projectsReady(QStringList projects);
    void projectGenerated();

private:
    QMap<QString, QStringList>* patternInsideFiles;
};

#endif // LISTPROJECTS_H

#ifndef ADDPROJECT_H
#define ADDPROJECT_H

#include <QObject>
#include <QVariant>

#include "util/cpp/RegexUtil.h"

class AddProject : public QObject {
    Q_OBJECT

private:
public:
    explicit AddProject(QObject* parent = nullptr);

    Q_INVOKABLE void generateProject(QVariant name, QVariant path);

signals:
};

#endif // ADDPROJECT_H

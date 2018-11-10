#ifndef GENERATOR_H
#define GENERATOR_H

#include <QObject>
#include <QVariant>
#include <glib.h>

#include "util/cpp/RegexUtil.h"

class Generator : public QObject {
    Q_OBJECT

public:
    explicit Generator(QObject* parent = nullptr);

    Q_INVOKABLE void generate(QVariant rawAlternative, QVariant rawPath, QVariant rawFileName);
signals:
    void fileGenerated(QVariant file);
};

#endif // GENERATOR_H

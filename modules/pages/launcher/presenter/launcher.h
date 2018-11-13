#ifndef LAUNCHER_H
#define LAUNCHER_H

#include <QObject>
#include <QVariant>

class Launcher : public QObject {
    Q_OBJECT

public:
    explicit Launcher(QObject* parent = nullptr);
    Q_INVOKABLE void getAllKeys();
    Q_INVOKABLE void hasConfig(QVariant rawPath);
    Q_INVOKABLE void listTemplates(QVariant rawPath);
    Q_INVOKABLE void templateInfo(QVariant rawPath);

signals:
    void allKeysReady(QStringList keys);
    void configFound(bool hasConfig);
    void templatesReady(QStringList templates);
    void templateInfoReady(QStringList templateInfo);
};

#endif // LAUNCHER_H

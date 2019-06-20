#ifndef LAUNCHER_H
#define LAUNCHER_H

#include <QObject>
#include <QVariant>

class Launcher : public QObject {
    Q_OBJECT

public:
    explicit Launcher(QObject* parent = nullptr);
    Q_INVOKABLE void getAllKeys();
    Q_INVOKABLE void removeItem(QVariant key);
    Q_INVOKABLE void hasConfig(QVariant rawPath);
    Q_INVOKABLE void listTemplates(QVariant rawPath);
    Q_INVOKABLE void templateInfo(QVariant rawPath);
    Q_INVOKABLE void savePath(QVariant key, QVariant rawPath);
    Q_INVOKABLE void clearCache();

signals:
    void allKeysReady(QStringList keys);
    void configFound(bool hasConfig);
    void templatesReady(QStringList templates);
    void templateInfoReady(QStringList templateInfo);
    void cacheCleared();
};

#endif // LAUNCHER_H

#include <QSettings>
#include <QStringList>

#include "QtUtil.h"

QtUtil::QtUtil()
{
}

QStringList QtUtil::getAllKeys(QString organization, QString application, QString group)
{
    QStringList keys;
    QSettings settings(organization, application);
    settings.beginGroup(group);
    QStringList rawKeys = settings.allKeys();
    if (rawKeys.isEmpty()) {
    } else {
        for (QString key : rawKeys) {
            keys.append(settings.value(key).toString());
        }
    }
    settings.endGroup();
    return keys;
}

QVariant QtUtil::getValue(QString organization, QString application, QString group, QString key)
{
    QSettings settings(organization, application);
    settings.beginGroup(group);
    QVariant fKey = settings.value(key);
    settings.endGroup();
    return fKey;
}

void QtUtil::setKeyValue(QString organization, QString application, QString group, QString key, QString value)
{
    QSettings settings(organization, application);
    settings.beginGroup(group);
    settings.setValue(key, value);
    settings.endGroup();
}

void QtUtil::removeKey(QString organization, QString application, QString group, QString key)
{
    QSettings settings(organization, application);
    settings.beginGroup(group);
    settings.remove(key);
    settings.endGroup();
}

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
    if (keys.isEmpty()) {
    } else {
        for (QString key : rawKeys) {
            keys.append(settings.value(key).toString());
        }
    }
    settings.endGroup();
    return keys;
}

void QtUtil::setKeyValue(QString organization, QString application, QString group, QString key, QString value)
{
    QStringList values;
    QSettings settings(organization, group);
    settings.beginGroup(application);
    settings.value(key, value);
    settings.endGroup();
}

#include <QSettings>
#include <QStringList>

#include "QtUtil.h"

QtUtil::QtUtil(QObject* parent)
{
}

void QtUtil::getAllKeys(QString organization, QString application, QString group)
{
    QVariantList keys;
    QSettings settings(organization, application);
    settings.beginGroup(group);
    QStringList rawKeys = settings.allKeys();
    if (keys.isEmpty()) {
        emit keysIsReady(*new QVariantList());
    } else {
        for (QString key : rawKeys) {
            keys.append(QVariant::fromValue(settings.value(key).toString()));
        }
        emit keysIsReady(keys);
    }
    settings.endGroup();
}

void QtUtil::addNewTemplates(QString organization, QString application, QString group, QString key, QString value)
{
    QStringList values;
    QSettings settings(organization, group);
    settings.beginGroup("Templates");
    settings.value(key, value);
    settings.endGroup();
}

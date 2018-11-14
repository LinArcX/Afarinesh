#ifndef QTUTIL_H
#define QTUTIL_H

#include <QStringList>
#include <QVariantList>
#include <iostream>

class QtUtil {

public:
    static QStringList getAllKeys(QString organization, QString application, QString group);
    static QVariant getValue(QString organization, QString application, QString group, QString key);
    static void setKeyValue(QString organization, QString application, QString group, QString key, QString value);
    static void removeKey(QString organization, QString application, QString group, QString key);

private:
    QtUtil();
};

#endif // QTUTIL_H

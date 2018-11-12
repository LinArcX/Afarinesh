#ifndef QTUTIL_H
#define QTUTIL_H

#include <QObject>
#include <QStringList>
#include <QVariantList>
#include <iostream>

class QtUtil : public QObject {
    Q_OBJECT

public:
    QtUtil(QObject* parent = nullptr);

    Q_INVOKABLE void getAllKeys(QString organization, QString application, QString group);
    Q_INVOKABLE void addNewTemplates(QString organization, QString application, QString group, QString key, QString value);

    //private:
    //    QtUtil();

signals:
    void keysIsReady(QVariantList keys);
};

#endif // QTUTIL_H

#ifndef TEST_H
#define TEST_H

#include <QObject>
#include <QVariant>

class MyClass : public QObject {
    Q_OBJECT

public:
    explicit MyClass(QObject* parent = nullptr);

    Q_INVOKABLE void isUpperCase(QString var);

signals:
    void dataReady(QVariant data);
};

#endif // TEST_H

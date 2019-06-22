#ifndef SETTINGS_H
#define SETTINGS_H

#include <QGuiApplication>
#include <QObject>
#include <QString>
#include <QVariantList>
#include <QVariantMap>

#include "util/cpp/PropertyHelper.h"

class Settings : public QObject {
    Q_OBJECT

public:
    explicit Settings(QObject* parent = nullptr);

    Q_INVOKABLE void setSettings(QVariantMap);
    Q_INVOKABLE void resetSettings();
    Q_INVOKABLE static void restartApp();

    static void loadAppStyle();
    void loadFontFamily();
    static void loadFontSize();
    bool loadLanguage(QGuiApplication& app, QTranslator& appTranslator, QTranslator& qtTranslator);

    QString appStyleName();
    Q_INVOKABLE QVariantList appStyles();
    Q_INVOKABLE int appStyleIndex();

    QString fontFamilyName();
    Q_INVOKABLE QVariantList fontFamilies();
    Q_INVOKABLE int fontFamilyIndex();

    QString fontSizeName();
    Q_INVOKABLE QVariantList fontSizes();
    Q_INVOKABLE int fontSizeIndex();

    QString languagesName();
    Q_INVOKABLE QVariantList languages();
    Q_INVOKABLE int languageIndex();

    Q_INVOKABLE bool isDark();

private:
signals:
    void blockSizeReady(QVariant blockSize);
};

#endif // SETTINGS_H

#include <QDebug>
#include <QFont>
#include <QFontDatabase>
#include <QGuiApplication>
#include <QProcess>
#include <QQuickStyle>
#include <QSettings>
#include <QString>
#include <QStringList>
#include <QTranslator>
#include <sys/utsname.h>

#include "modules/core/dispatcher/dispatcher.h"
#include "modules/pages/settings/presenter/settings.h"
#include <modules/pages/settings/presenter/settingsMacro.h>

using namespace std;

Settings::Settings(QObject* parent)
{
}

void Settings::setSettings(QVariantMap mSettings)
{
    for (auto iter = mSettings.begin(); iter != mSettings.end(); ++iter) {
        QString mKey = iter.key();
        if (mKey == FONT_FAMILY) {
            QFont fontFamily(iter.value().toString());
            QSettings settings(COMPANY_NAME, APP_NAME);
            settings.beginGroup(FONT_GROUP);
            settings.setValue(FONT_FAMILY, fontFamily);
            settings.endGroup();
            loadFontFamily();
        } else if (mKey == FONT_SIZE) {
            int fontSize = iter.value().toInt();
            QSettings settings(COMPANY_NAME, APP_NAME);
            settings.beginGroup(FONT_GROUP);
            settings.setValue(FONT_SIZE, fontSize);
            settings.endGroup();
            loadFontSize();
        } else if (mKey == STYLE) {
            QString appStyle = iter.value().toString();
            QSettings settings(COMPANY_NAME, APP_NAME);
            settings.beginGroup(APP_GROUP);
            settings.setValue(STYLE, appStyle);
            settings.endGroup();
            loadAppStyle();
        } else if (mKey == CURRENT_LANGUAGE) {
            QString appLanguage = iter.value().toString();
            QSettings settings(COMPANY_NAME, APP_NAME);
            settings.beginGroup(APP_GROUP);
            settings.setValue(CURRENT_LANGUAGE, appLanguage);
            settings.endGroup();
            loadAppStyle();
        } else if (mKey == "darkMeterial") {
            qputenv("QT_QUICK_CONTROLS_MATERIAL_THEME", "Dark");
        } else if (mKey == "darkUniversal") {
            qputenv("QT_QUICK_CONTROLS_UNIVERSAL_THEME", "Dark");
        } else {
            qunsetenv("QT_QUICK_CONTROLS_MATERIAL_THEME");
            qunsetenv("QT_QUICK_CONTROLS_UNIVERSAL_THEME");
        }
    }
}

void Settings::resetSettings()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.clear();
}

void Settings::restartApp()
{
    QProcess::startDetached(QGuiApplication::applicationFilePath());
    exit(12);
}

void Settings::loadAppStyle()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(APP_GROUP);
    QString mStyle = qvariant_cast<QString>(settings.value(STYLE, DEFAULT_STYLE));
    QQuickStyle::setStyle(mStyle);
    settings.endGroup();
}

void Settings::loadFontFamily()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(FONT_GROUP);
    QFont mFont = qvariant_cast<QFont>(settings.value(FONT_FAMILY, DEFAULT_FONT));
    int id = QFontDatabase::addApplicationFont(":/fonts/" + mFont.family() + ".ttf");
    QString family = QFontDatabase::applicationFontFamilies(id).at(0);
    QFont _font(family);
    qApp->setFont(_font);
    settings.endGroup();
}

void Settings::loadFontSize()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(FONT_GROUP);
    QFont mFont;
    mFont.setPixelSize(qvariant_cast<int>(settings.value(FONT_SIZE, 12)));
    QGuiApplication::setFont(mFont);
    settings.endGroup();
}

bool Settings::loadLanguage(QGuiApplication& app, QTranslator& appTranslator, QTranslator& qtTranslator)
{
    bool isRTL = false;
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(APP_GROUP);
    QString appLanguage = qvariant_cast<QString>(settings.value(CURRENT_LANGUAGE, "EN"));
    settings.endGroup();
    if (appLanguage == "Persian") {
        isRTL = true;
        appTranslator.load(":/translations/persian.qm");
        app.installTranslator(&appTranslator);

        qtTranslator.load(":/translations/qt_fa.qm");
        app.installTranslator(&qtTranslator);

        app.setLayoutDirection(Qt::LeftToRight);
    }
    return isRTL;
}

QString Settings::appStyleName()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(APP_GROUP);
    QString appStyle = qvariant_cast<QString>(settings.value(STYLE, DEFAULT_STYLE));
    settings.endGroup();
    return appStyle;
}

QVariantList Settings::appStyles()
{
    QVariantList appStyles;
    appStyles
        << "Fusion"
        << "Imagine"
        << "Material"
        << "Universal";

    return appStyles;
}

int Settings::appStyleIndex()
{
    QString currentAppStyle = appStyleName();
    QVariant qv(currentAppStyle);
    return appStyles().indexOf(qv);
}

QString Settings::fontFamilyName()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(FONT_GROUP);
    QFont fontFamily = qvariant_cast<QFont>(settings.value(FONT_FAMILY, DEFAULT_FONT));
    settings.endGroup();
    return fontFamily.family();
}

QVariantList Settings::fontFamilies()
{
    QVariantList fontLists;
    fontLists
        << "Adele"
        << "AlexBrush"
        << "Aller"
        << "Amatic"
        << "BeautifulCreatures"
        << "CaviarDreams"
        << "Daywalker"
        << "RadioSpace"
        << "Shabnam"
        << "Titillium"
        << "Vazir"
        << "XmYekan";
    return fontLists;
}

int Settings::fontFamilyIndex()
{
    QString currentFontFamily = fontFamilyName();
    QVariant qv(currentFontFamily);
    return fontFamilies().indexOf(qv);
}

QString Settings::fontSizeName()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(FONT_GROUP);
    QString fontSize = qvariant_cast<QString>(settings.value(FONT_SIZE, 12));
    settings.endGroup();
    return fontSize;
}

QVariantList Settings::fontSizes()
{
    QVariantList fontLists;
    fontLists
        << "8"
        << "9"
        << "10"
        << "11"
        << "12"
        << "13"
        << "14"
        << "15"
        << "16"
        << "17"
        << "18";

    return fontLists;
}

int Settings::fontSizeIndex()
{
    QString fontSizeIndex = fontSizeName();
    QVariant qv(fontSizeIndex);
    return fontSizes().indexOf(qv);
}

QString Settings::languagesName()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(APP_GROUP);
    QString language = qvariant_cast<QString>(settings.value(CURRENT_LANGUAGE, "Egnglish"));
    settings.endGroup();
    return language;
}

QVariantList Settings::languages()
{
    QVariantList fontLists;
    fontLists
        << "English"
        << "Persian";

    return fontLists;
}

int Settings::languageIndex()
{
    QString languageIndex = languagesName();
    QVariant qv(languageIndex);
    return languages().indexOf(qv);
}

bool Settings::isDark()
{
    bool isDark;
    QString currentStyle = QQuickStyle::name();
    if (currentStyle == "Universal") {
        bool isUniversalDark = qEnvironmentVariableIsSet("QT_QUICK_CONTROLS_UNIVERSAL_THEME");
        if (isUniversalDark)
            isDark = true;
        else
            isDark = false;
    } else if (currentStyle == "Material") {
        bool isMaterialDark = qEnvironmentVariableIsSet("QT_QUICK_CONTROLS_MATERIAL_THEME");
        if (isMaterialDark)
            isDark = true;
        else
            isDark = false;
    }
    return isDark;
}

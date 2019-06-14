#include <QDebug>
#include <QSettings>
#include <QString>
#include <QVariant>
#include <iostream>

#include "modules/core/dispatcher/dispatcherMacro.h"
#include "modules/pages/launcher/presenter/launcher.h"

#include "util/cpp/ConvertUtil.h"
#include "util/cpp/FileUtil.h"
#include "util/cpp/QtUtil.h"
#include "util/cpp/RegexUtil.h"
#include "util/cpp/YamlUtil.h"

using namespace std;

Launcher::Launcher(QObject* parent)
{
}

void Launcher::getAllKeys()
{
    QStringList keys = QtUtil::getAllKeys(ORGANIZATION, APPLICATION, TEMPLATES_GROUP);
    emit allKeysReady(keys);
}

void Launcher::removeItem(QVariant key)
{
    QtUtil::removeKey(ORGANIZATION, APPLICATION, TEMPLATES_GROUP, key.toString());
}

void Launcher::hasConfig(QVariant rawPath)
{
    QString dir = rawPath.toString().split("//")[1];
    const std::string configFile = dir.toStdString() + "/trinity.yaml";
    bool isConfiFileExists = FileUtil::fileExists(QString::fromStdString(configFile));
    if (isConfiFileExists) {
        emit configFound(true);
    } else {
        emit configFound(false);
    }
}

void Launcher::listTemplates(QVariant rawPath)
{
    QStringList templates;
    bool templatesDirExists = FileUtil::dirExists(rawPath.toString().split("//")[1] + "/templates");
    if (templatesDirExists) {
        templates = FileUtil::directoryList(rawPath.toString().split("//")[1] + "/templates");
        emit templatesReady(templates);
    } else {
        emit templatesReady(*new QStringList());
    }
}

void Launcher::templateInfo(QVariant rawPath)
{
    QStringList info;
    QString dir = rawPath.toString().split("//")[1];
    const std::string configFile = dir.toStdString() + "/trinity.yaml";
    //    bool isConfiFileExists = FileUtil::fileExists(QString::fromStdString(configFile));
    QString name = QString::fromStdString(YamlUtil::getValue(configFile, "name"));
    QString author = QString::fromStdString(YamlUtil::getValue(configFile, "author"));
    QString icon = QString::fromStdString(YamlUtil::getValue(configFile, "icon"));
    const std::string iconPath = dir.toStdString() + icon.toStdString();
    QString comment = QString::fromStdString(YamlUtil::getValue(configFile, "comment"));
    info.append(name);
    info.append(author);
    info.append(icon);
    info.append(comment);
    info.append(rawPath.toString() + "/templates");
    emit templateInfoReady(info);
}

void Launcher::savePath(QVariant key, QVariant rawPath)
{
    QtUtil::setKeyValue(ORGANIZATION, APPLICATION, TEMPLATES_GROUP, key.toString(), rawPath.toString());
}

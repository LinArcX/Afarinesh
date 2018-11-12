#include <QDebug>
#include <QSettings>
#include <QString>
#include <QVariant>
#include <iostream>

#include "modules/pages/generator/presenter/generator.h"
#include "util/cpp/ConvertUtil.h"
#include "util/cpp/FileUtil.h"
#include "util/cpp/RegexUtil.h"
#include "util/cpp/YamlUtil.h"

using namespace std;

Generator::Generator(QObject* parent)
{
}

void Generator::isDirExists(QVariant rawDir)
{
    QString dir = rawDir.toString().split("//")[1];
    const std::string configFile = dir.toStdString() + "/afarinesh.yaml";
    bool isConfiFileExists = FileUtil::fileExists(QString::fromStdString(configFile));
    if (isConfiFileExists) {
        emit configFileExists(true);
    } else {
        emit configFileExists(false);
    }
}

void Generator::listTemplates(QVariant path)
{
    QStringList templates;
    bool templatesDirExists = FileUtil::dirExists(path.toString() + "/templates");
    if (templatesDirExists) {
        templates = FileUtil::directoryList(path.toString().split("//")[1] + "/templates");
        emit templatesReady(templates);
    } else {
        emit templatesReady(*new QStringList());
    }
}

void Generator::getTemplateInfo(QVariant rawDir)
{
    QStringList info;
    QString dir = rawDir.toString().split("//")[1];
    const std::string configFile = dir.toStdString() + "/afarinesh.yaml";
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
    emit templateInfoReady(info);
}

void Generator::generate(QVariant rawAlternative, QVariant rawPath, QVariant rawFileName)
{
    if (!FileUtil::checkExistDirectory(rawPath.toString())) {
        FileUtil::makeDirectory(rawPath.toString());
    }
    QString targetPath = QDir::currentPath() + "/QtCpp/feature/feature.cpp";
    string rawTarget = FileUtil::readStringFromFile(targetPath).toUtf8().toStdString();
    char* target = ConvertUtil::stringToCharPointer(rawTarget);

    string strAlternative = rawAlternative.toString().toStdString();
    const char* alternative = strAlternative.c_str();

    const char* cPattern = "\\{\\*c\\*}";
    target = RegexUtil::findReplaseRegx(cPattern, alternative, target, RegexUtil::Replacement::CAMELCASE);

    const char* uPattern = "\\{\\*u\\*}";
    target = RegexUtil::findReplaseRegx(uPattern, alternative, target, RegexUtil::Replacement::UPPERCASE);

    const char* lPattern = "\\{\\*l\\*}";
    target = RegexUtil::findReplaseRegx(lPattern, alternative, target, RegexUtil::Replacement::LOWERCASE);
    cout << target;

    FileUtil::writeFile(rawPath.toString() + rawFileName.toString(), target);
    delete[] target;
}

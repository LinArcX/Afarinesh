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

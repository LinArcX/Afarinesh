#include <QDebug>
#include <QSettings>
#include <QString>
#include <QVariant>
#include <iostream>

#include "modules/core/dispatcher/dispatcherMacro.h"
#include "modules/pages/addProject/presenter/addProject.h"
#include "util/cpp/ConvertUtil.h"
#include "util/cpp/FileUtil.h"
#include "util/cpp/QtUtil.h"
#include "util/cpp/RegexUtil.h"
#include "util/cpp/YamlUtil.h"

using namespace std;

AddProject::AddProject(QObject* parent)
{
    // Full address of files --> find . | ag "/.*(?<=\{\{).+?(?=\}\})[^/]*$" | awk -F/ '{print $NF}'

    // Full Address of vars --> ag "(?<=\{\{).+?(?=\}\})" --hidden

    // List of vars --> ag "(?<=\{\{).+?(?=\}\})" --hidden | awk -F: '{print $NF}' | grep -oP '(?<=\{\{).+?(?=\}\})'
}

void AddProject::generateProject(QVariant name, QVariant path)
{
    const QString address = QtUtil::getValue(ORGANIZATION, APPLICATION, TEMPLATES_GROUP, name.toString()).toString();

    //    if (!FileUtil::checkExistDirectory(path.toString())) {
    //        FileUtil::makeDirectory(path.toString());
    //    }

    //    QString targetPath = QDir::currentPath() + "/QtCpp/feature/feature.cpp";
    //    string rawTarget = FileUtil::readStringFromFile(targetPath).toUtf8().toStdString();
    //    char* target = ConvertUtil::stringToCharPointer(rawTarget);

    //    string strAlternative = "rawAlternative.toString().toStdString();";
    //    const char* alternative = strAlternative.c_str();

    //    const char* cPattern = "\\{\\*c\\*}";
    //    target = RegexUtil::findReplaseRegx(cPattern, alternative, target, RegexUtil::Replacement::CAMELCASE);

    //    const char* uPattern = "\\{\\*u\\*}";
    //    target = RegexUtil::findReplaseRegx(uPattern, alternative, target, RegexUtil::Replacement::UPPERCASE);

    //    const char* lPattern = "\\{\\*l\\*}";
    //    target = RegexUtil::findReplaseRegx(lPattern, alternative, target, RegexUtil::Replacement::LOWERCASE);
    //    cout << target;

    //    FileUtil::writeFile(path.toString() + name.toString(), target);
    //    delete[] target;
}

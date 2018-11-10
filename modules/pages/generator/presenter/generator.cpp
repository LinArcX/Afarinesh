#include <QDebug>
#include <QVariant>
#include <iostream>

#include "modules/pages/generator/presenter/generator.h"
#include "util/cpp/ConvertUtil.h"
#include "util/cpp/FileUtil.h"
#include "util/cpp/RegexUtil.h"

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

    //    char* target;
    //    std::vector<char> writable(rowTarget.begin(), rowTarget.end());
    //    writable.push_back('\0');
    //    target = &*writable.begin();

    //    stringToCharPointer(rowTarget, target);

    //    GRegex* lRegex;
    //    GMatchInfo* lMatchInfo;
    //    lRegex = g_regex_new("\\{\\*l\\*}", GRegexCompileFlags::G_REGEX_JAVASCRIPT_COMPAT, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &err);

    //    GRegex* cRegex;
    //    GMatchInfo* cMatchInfo;
    //    cRegex = g_regex_new("\\{\\*c\\*}", GRegexCompileFlags::G_REGEX_JAVASCRIPT_COMPAT, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &err);
    //    // check for compilation errors here!

    //    g_regex_match(lRegex, templateString, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &lMatchInfo);
    //    if (g_match_info_matches(lMatchInfo)) {
    //        gchar* result = g_match_info_fetch(lMatchInfo, 0);
    //        const char* lReplacement = FileUtil::lowerCaseAllChars(replacement).c_str();
    //        templateString = g_regex_replace(lRegex, templateString, strlen(templateString), 0, lReplacement, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, NULL);
    //    }

    //    g_regex_match(cRegex, templateString, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &cMatchInfo);
    //    if (g_match_info_matches(cMatchInfo)) {
    //        gchar* result = g_match_info_fetch(cMatchInfo, 0);
    //        const char* cReplacement = FileUtil::capitilizeFirstChar(replacement).c_str();
    //        templateString = g_regex_replace(cRegex, templateString, strlen(templateString), 0, cReplacement, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, NULL);
    //        g_print(templateString);
    //    }

    //    QString strType = FileUtil::determineWordType(QString::fromLocal8Bit(result));
    //    if (strType == "isCamelCase") {
    //    }

    //    char* test = "This Text Has 12 {*TOKEN*} to match!";
    //lRegex = g_regex_new("(?=(?<=\\{\\*).*?(?=\\*\\}))(?=l)", GRegexCompileFlags::G_REGEX_JAVASCRIPT_COMPAT, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &err);
    //lRegex = g_regex_new("(?=(?<=\\{\\*).*?(?=\\*\\}))(?=l)", GRegexCompileFlags::G_REGEX_JAVASCRIPT_COMPAT, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &err);

    // \{\*c\*}
    //\\b(sub)([^ ]*)
    // {\\*a\\*\\}
    //    \{\*(?<TOKEN>[a-zA-Z]+)\*}
    // (?<=\{\*).*?(?=\*\})
    //    (?=([A-Z][a-zA-Z0-9-]*)+)(?=(?<=\{\*).*?(?=\*\}))
    // (?=([A-Z][A-Z]+))(?=(?<=\{\*).*?(?=\*\}))
    // (?=(\b[[:upper:]]{2,}\b))(?=(?<=\{\*).*?(?=\*\}))
    // (?=([A-Z][a-z]))(?=(?<=\{\*).*?(?=\*\}))
    //    try {
    //        //        QRegExp rx("\\d*\\.\\d+");
    //        //        rx.setPatternSyntax(QRegExp::RegExp2);
    //        //        QString str = "offsets: 1.23 .50 71.00 6.00";

    //        //        QRegExp e("\\{\\*(?<TOKEN>[a-zA-Z]+)\\*}");
    //        //        e.setPatternSyntax(QRegExp::WildcardUnix);
    //        //        QString str2 = "{*asd*}";

    //        string s("there is {*test*} in 32 and 45.2bit strings");

    //        //        int pos = e.indexIn(s);
    //        //        int pos1 = rx.indexIn(str);

    //        //        QString as = s.replace(e, "token");
    //        //        qDebug() << as;
    //        //        qDebug() << pos << pos1;

    //        //std::regex e("\\d+", std::regex_constants::ECMAScript); // matches words beginning by "sub"
    //        std::regex e("\(?<=\\{\\*).*?(?=\\*\\})", std::regex_constants::ECMAScript); // matches words beginning by "sub"

    //        // using string/c-string (3) version:
    //        string asd = "aaaaaaa";
    //        string a = std::regex_replace(s, e, asd);
    //        QString str = QString::fromUtf8(a.c_str());
    //        emit dataReady(qVariantFromValue(str));

    //    } catch (exception& e) {
    //        cout << e.what();
    //    }

    //    while (file.toStdString().find("{*Token*}") != string::npos) {
    //        std::string output = FileUtil::determineWordType("{*Token*}");
    //        if (output == "isCamelCase") {
    //            file.toStdString().replace("{*Token*}", 6, "good");

    //        } else if (output == "isLower") {
    //            file.toStdString().replace(file.toStdString().find("{*Token*}"), 6, "good");

    //        } else if (output == "isUpper") {
    //            file.toStdString().replace(file.toStdString().find("{*Token*}"), 6, "good");
    //        }
    //    }

    //    cout << file.toStdString() << endl;
}

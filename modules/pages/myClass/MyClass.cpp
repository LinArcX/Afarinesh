#include <QDebug>
#include <QRegExp>
#include <glib.h>
#include <iostream>
#include <regex>

#include "modules/pages/myClass/MyClass.h"
#include "util/cpp/file_util.h"

using namespace std;

MyClass::MyClass(QObject* parent)
{
}

void MyClass::isUpperCase(QString var)
{
    char* replacement = "Saeed";
    string mTemplate = FileUtil::readStringFromFile("/mnt/D/Document/WorkSpace/Qt/Project/Afarinesh/templates/QtCpp/TOKEN.cpp").toUtf8().toStdString().c_str();
    std::vector<char> writable(mTemplate.begin(), mTemplate.end());
    writable.push_back('\0');
    char* templateString = &*writable.begin();

    GRegex* uRegex;
    GRegex* lRegex;
    GRegex* cRegex;

    GError* err = nullptr;
    GMatchInfo* uMatchInfo;
    GMatchInfo* lMatchInfo;
    GMatchInfo* cMatchInfo;

    uRegex = g_regex_new("\\{\\*u\\*}", GRegexCompileFlags::G_REGEX_JAVASCRIPT_COMPAT, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &err);
    lRegex = g_regex_new("\\{\\*l\\*}", GRegexCompileFlags::G_REGEX_JAVASCRIPT_COMPAT, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &err);
    cRegex = g_regex_new("\\{\\*c\\*}", GRegexCompileFlags::G_REGEX_JAVASCRIPT_COMPAT, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &err);
    // check for compilation errors here!

    g_regex_match(uRegex, templateString, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &uMatchInfo);
    if (g_match_info_matches(uMatchInfo)) {
        gchar* result = g_match_info_fetch(uMatchInfo, 0);
        //g_print(result);
        const char* uReplacement = FileUtil::upperCaseAllChars(replacement).c_str();
        templateString = g_regex_replace(uRegex, templateString, strlen(templateString), 0, uReplacement, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, NULL);
    }

    g_regex_match(lRegex, templateString, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &lMatchInfo);
    if (g_match_info_matches(lMatchInfo)) {
        gchar* result = g_match_info_fetch(lMatchInfo, 0);
        //g_print(result);
        const char* lReplacement = FileUtil::lowerCaseAllChars(replacement).c_str();
        templateString = g_regex_replace(lRegex, templateString, strlen(templateString), 0, lReplacement, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, NULL);
    }

    g_regex_match(cRegex, templateString, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &cMatchInfo);
    if (g_match_info_matches(cMatchInfo)) {
        gchar* result = g_match_info_fetch(cMatchInfo, 0);
        //g_print(result);
        const char* cReplacement = FileUtil::capitilizeFirstChar(replacement).c_str();
        templateString = g_regex_replace(cRegex, templateString, strlen(templateString), 0, cReplacement, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, NULL);
        g_print(templateString);
    }

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

#include <QRegExp>
#include <QRegularExpression>
#include <QVariant>
#include <glib.h>
#include <iostream>
#include <regex>

#include "ConvertUtil.h"
#include "RegexUtil.h"
#include "util/cpp/FileUtil.h"

RegexUtil::RegexUtil()
{
}

char* RegexUtil::findReplaseRegx(const char* pattern, const char* rawAlternative, char* target, Replacement replacement)
{
    GError* err = nullptr;
    GRegex* regex;
    GMatchInfo* uMatchInfo;
    char* alternative;

    regex = g_regex_new(pattern, GRegexCompileFlags::G_REGEX_JAVASCRIPT_COMPAT, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &err);
    g_regex_match(regex, target, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, &uMatchInfo);
    if (g_match_info_matches(uMatchInfo)) {
        gchar* result = g_match_info_fetch(uMatchInfo, 0);
        if (replacement == Replacement::UPPERCASE) {
            alternative = ConvertUtil::stringToCharPointer(FileUtil::upperCaseAllChars(rawAlternative));
        } else if (replacement == Replacement::LOWERCASE) {
            alternative = ConvertUtil::stringToCharPointer(FileUtil::lowerCaseAllChars(rawAlternative));
        } else if (replacement == Replacement::CAMELCASE) {
            alternative = ConvertUtil::stringToCharPointer(FileUtil::capitilizeFirstChar(rawAlternative));
        }
        target = g_regex_replace(regex, target, strlen(target), 0, alternative, GRegexMatchFlags::G_REGEX_MATCH_NOTEMPTY_ATSTART, NULL);
    }
    return target;
}

QStringList RegexUtil::findAllAcuurances(QString text, QString rxString)
{
    QStringList items;
    QRegularExpression rx(rxString);
    if (!rx.isValid()) {
        return QStringList(nullptr);
    }

    QRegularExpression::PatternOptions patternOptions = QRegularExpression::NoPatternOption;
    QRegularExpression::MatchOptions matchOptions = QRegularExpression::NoMatchOption;

    rx.setPatternOptions(patternOptions);
    const int capturingGroupsCount = rx.captureCount() + 1;
    QRegularExpressionMatchIterator iterator = rx.globalMatch(text, 0, QRegularExpression::NormalMatch, matchOptions);
    int i = 0;

    while (iterator.hasNext()) {
        QRegularExpressionMatch match = iterator.next();
        //                    qDebug() << QString::number(i);
        for (int captureGroupIndex = 0; captureGroupIndex < capturingGroupsCount; ++captureGroupIndex) {
            //                qDebug() << QString::number(captureGroupIndex);
            items.append(match.captured(captureGroupIndex));
        }
        ++i;
    }
    //        const QStringList namedCaptureGroups = rx.namedCaptureGroups();
    //        for (int i = 0; i < namedCaptureGroups.size(); ++i) {
    //            const QString currentNamedCaptureGroup = namedCaptureGroups.at(i);
    //            //qDebug() << QString::number(i);
    //            if (!currentNamedCaptureGroup.isNull()) {
    //                qDebug() << currentNamedCaptureGroup;
    //            }
    //        }
    return items;
}

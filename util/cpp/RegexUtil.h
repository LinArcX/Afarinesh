#ifndef REGEXUTIL_H
#define REGEXUTIL_H

#include <QDir>
#include <QDirIterator>
#include <QFile>
#include <QSharedPointer>
#include <QStandardPaths>
#include <QTextStream>

class RegexUtil {
private:
    RegexUtil();

public:
    enum Replacement {
        UPPERCASE,
        LOWERCASE,
        CAMELCASE
    };

    static char* findReplaseRegx(const char* pattern, const char* rawAlternative, char* target, Replacement replacement);
    static QStringList findAllAcuurances(QString text, QString rxString);
};

#endif // REGEXUTIL_H

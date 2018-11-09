#ifndef FILEUTIL_H
#define FILEUTIL_H

#include <QDir>
#include <QDirIterator>
#include <QFile>
#include <QStandardPaths>
#include <QTextStream>

#include <QSharedPointer>
#include <QStandardPaths>

#include "stacer-core_global.h"

class STACERCORESHARED_EXPORT FileUtil {
public:
    static QString readStringFromFile(const QString& path, const QIODevice::OpenMode& mode = QIODevice::ReadOnly);
    static QStringList readListFromFile(const QString& path, const QIODevice::OpenMode& mode = QIODevice::ReadOnly);
    static QString determineWordType(QString word);
    static std::string upperCaseAllChars(std::string word);
    static std::string lowerCaseAllChars(std::string word);
    static std::string capitilizeFirstChar(std::string word);

    static bool writeFile(const QString& path, const QString& content, const QIODevice::OpenMode& mode = QIODevice::WriteOnly | QIODevice::Truncate);
    static QStringList directoryList(const QString& path);
    static quint64 getFileSize(const QString& path);

private:
    FileUtil();
};

#endif // FILEUTIL_H

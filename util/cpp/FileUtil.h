#ifndef FILEUTIL_H
#define FILEUTIL_H

#include <QDir>
#include <QDirIterator>
#include <QFile>
#include <QStandardPaths>
#include <QTextStream>

#include <QSharedPointer>
#include <QStandardPaths>

class FileUtil {
public:
    static QString readStringFromFile(const QString& path, const QIODevice::OpenMode& mode = QIODevice::ReadOnly);
    static QStringList readListFromFile(const QString& path, const QIODevice::OpenMode& mode = QIODevice::ReadOnly);

    static bool writeFile(const QString& path, const QString& content, const QIODevice::OpenMode& mode = QIODevice::WriteOnly | QIODevice::Truncate);
    static QStringList directoryList(const QString& path);
    static quint64 getFileSize(const QString& path);

    static bool checkExistDirectory(QString);
    static bool makeDirectory(QString);
    static void listFilesRecursively(const std::string& path, std::function<void(const std::string&)> cb);

    static QStringList getAllFilesInDir(QString, QDir::Filters filters, QStringList exceptions = {});

    static QString determineWordType(QString word);
    static std::string upperCaseAllChars(std::string word);
    static std::string lowerCaseAllChars(std::string word);
    static std::string capitilizeFirstChar(std::string word);
    static void replaceString(QString path, QString sourceText, QString targetText);
    static void replaceString(QString path, QRegExp sourceText, QString targetText);
    static void renameFile(QString oldName, QString newName);
    static bool fileExists(QString path);
    static bool dirExists(QString path);
    static bool copyRecursively(const QString& srcFilePath, const QString& tgtFilePath);

private:
    FileUtil();
};

#endif // FILEUTIL_H

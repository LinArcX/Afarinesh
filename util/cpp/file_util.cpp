#include "file_util.h"
#include <iostream>

FileUtil::FileUtil()
{
}

QString FileUtil::readStringFromFile(const QString& path, const QIODevice::OpenMode& mode)
{
    QSharedPointer<QFile> file(new QFile(path));

    QString data;

    if (file->open(mode)) {

        data = file->readAll();

        file->close();
    }

    return data;
}

QStringList FileUtil::readListFromFile(const QString& path, const QIODevice::OpenMode& mode)
{
    QStringList list = FileUtil::readStringFromFile(path, mode).trimmed().split("\n");

    return list;
}

std::string FileUtil::upperCaseAllChars(std::string word)
{
    for (int i = 0; i <= word.length(); i++) {
        if (word[i] >= 97 && word[i] <= 122) {
            word[i] = word[i] - 32;
        }
    }
    return word;
}

std::string FileUtil::lowerCaseAllChars(std::string word)
{
    for (int i = 0; i <= word.length(); i++) {
        if (word[i] >= 65 && word[i] <= 90) {
            word[i] = word[i] + 32;
        }
    }
    return word;
}

std::string FileUtil::capitilizeFirstChar(std::string word)
{
    bool cap = true;
    for (int i = 0; i <= word.length(); i++) {
        if (cap && word[i] >= 97 && word[i] <= 122) {
            word[i] = word[i] - 32;
            cap = false;
        }
        if (word[i] >= 65 && word[i] <= 90) {
            word[i] = word[i] + 32;
        }
    }
    return word;

    //    for (unsigned int i = 0; i <= word.length(); i++) {
    //        if (cap) {
    //            word[i] = toupper(word.toStdString()[i]);
    //            cap = false;
    //        } else {
    //            word[i] = tolower(word.toStdString()[i]);
    //        }
    //    }
    //    return word;
}

QString FileUtil::determineWordType(QString word)
{
    char c;
    int i = 0;
    std::string str = "";
    QString output = "";

    int ccCount = 0;
    int lowerCount = 0;
    int upperCount = 0;
    int totalCount = word.size();

    bool isUpper = false;
    bool isLower = false;
    bool isCamelCase = false;
    str = word.toStdString().c_str();

    if (isupper(str[0])) {
        ccCount++;
        upperCount++;
        i++;
    } else {
        lowerCount++;
        i++;
    }

    while (str[i]) {
        c = str[i];
        if (isupper(c)) {
            upperCount++;
        } else if (islower(c)) {
            ccCount++;
            lowerCount++;
        }
        i++;
    }
    if (totalCount == ccCount) {
        isCamelCase = true;
        output = "isCamelCase";
    } else if (totalCount == lowerCount) {
        isLower = true;
        output = "isLower";
    } else if (totalCount == upperCount) {
        isUpper = true;
        output = "isUpper";
    } else {
        output = "Undefined";
    }
    return output;
}

bool FileUtil::writeFile(const QString& path, const QString& content, const QIODevice::OpenMode& mode)
{
    QFile file(path);

    if (file.open(mode)) {
        QTextStream stream(&file);
        stream << content.toUtf8() << endl;

        file.close();

        return true;
    }

    return false;
}

QStringList FileUtil::directoryList(const QString& path)
{
    QDir dir(path);

    QStringList list;

    for (const QFileInfo& info : dir.entryInfoList(QDir::NoDotAndDotDot | QDir::Files))
        list << info.fileName();

    return list;
}

quint64 FileUtil::getFileSize(const QString& path)
{
    quint64 totalSize = 0;

    QFileInfo info(path);

    if (info.exists()) {
        if (info.isFile()) {
            totalSize += info.size();
        } else if (info.isDir()) {

            QDir dir(path);

            for (const QFileInfo& i : dir.entryInfoList(QDir::NoDotAndDotDot | QDir::Files | QDir::Dirs)) {
                totalSize += getFileSize(i.absoluteFilePath());
            }
        }
    }

    return totalSize;
}
